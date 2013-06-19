//
//  HttpMsgCtrl.m
//  SuningIphone
//
//  Created by wangrui on 7/3/12.
//  Copyright (c) 2012 suning. All rights reserved.
//

#import <map>
#import "HttpMsgCtrl.h"
#import "ASIHTTPRequest.h"
#import "ASINetworkQueue.h"

using namespace std;

typedef map <int, HttpMessage *>               map_send;
typedef map <int, HttpMessage *> :: iterator   iter_send;
typedef map <int, HttpMessage *> :: value_type value_send;

static map_send     g_mapSend;
static HttpMsgCtrl *msgCtrl = nil;

@implementation HttpMsgCtrl

@synthesize lock = _lock;
@synthesize networkQueue = _networkQueue;

- (void)dealloc
{
    TT_RELEASE_SAFELY(_lock);
    TT_RELEASE_SAFELY(_networkQueue);

    [super dealloc];
}

+ (HttpMsgCtrl *)shareInstance
{
    @synchronized(self)
    {
        if (!msgCtrl)
        {
            msgCtrl = [[self alloc] init];
        }
    }

    return msgCtrl;
}

+ (id)allocWithZone:(NSZone *)zone
{
    @synchronized(self)
    {
        if (!msgCtrl)
        {
            msgCtrl = [super allocWithZone:zone];

            return msgCtrl;
        }
    }

    return nil;
}

- (id)new
{
    return self;
}

- (id)copyWithZone:(NSZone *)zone
{
    return self;
}

- (id)retain
{
    return self;
}

- (unsigned)retainCount
{
    return UINT_MAX;    // denotes an object that cannot be released
}

- (id)autorelease
{
    return self;
}

- (id)init
{
    if (self = [super init])
    {
        _networkQueue = [[ASINetworkQueue alloc] init];

        [_networkQueue reset];

        _networkQueue.delegate = self;
        _networkQueue.shouldCancelAllRequestsOnFailure = NO;
        _networkQueue.requestDidStartSelector = @selector(requestDidStart:);
        _networkQueue.requestDidReceiveResponseHeadersSelector = @selector(request:didReceiveResponseHeaders:);
        _networkQueue.requestDidFinishSelector = @selector(requestDidFinished:);
        _networkQueue.requestDidFailSelector = @selector(requestDidFailed:);

        _lock = [[NSLock alloc] init];
    }

    return self;
}

// 获得tagcode(short转int)
- (int)getTagCode:(int)cmdCode
{
    static unsigned short int curCode = 0x0001;

    int returnCode = (curCode & 0x0000ffff);

    returnCode |= cmdCode << 16 & 0xffff0000;

    [self.lock lock];

    curCode++;

    if (0xffff == curCode)
    {
        curCode = 0x0001;
    }

    [self.lock unlock];

    return returnCode;
}

// 得到cmdcode(int转short)
- (int)getCmdcode:(int)tagCode
{
    int returnCode = tagCode >> 16 & 0x0000ffff;

    return returnCode;
}

#pragma mark -
#pragma mark Send http request
- (void)sendHttpMsg:(HttpMessage *)sendMsg
{
    if (sendMsg == nil)
    {
        return;
    }

    DLog(@"sendMsg id = %#x ", sendMsg.cmdCode);
    DLog(@"request url = %@", sendMsg.requestUrl);
    DLog(@"postDataDic = %@", sendMsg.postDataDic);

    int msgTag = [self getTagCode:sendMsg.cmdCode];

    ASIHTTPRequest *request;

    if ([sendMsg.requestMethod isEqualToString:@"GET"])
    {
        NSMutableString *urlString = [[NSMutableString alloc] initWithString:sendMsg.requestUrl];

        if (sendMsg.postDataDic != nil)
        {
            [urlString appendString:@"?"];
            NSArray *allKeys = [sendMsg.postDataDic allKeys];

            for (NSString *key in allKeys)
            {
                [urlString appendFormat:@"%@=%@&", key, [sendMsg.postDataDic objectForKey:key]];
            }
        }

        NSString *absoluteString = [urlString substringWithRange:NSMakeRange(0, urlString.length - 1)];
        NSString *absoluteStringUTF8 = [absoluteString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];

        NSURL *url = [[NSURL alloc] initWithString:absoluteStringUTF8];

        TT_RELEASE_SAFELY(urlString);

        request = [ASIHTTPRequest requestWithURL:url];

        TT_RELEASE_SAFELY(url);
    }
    else
    {
        request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:sendMsg.requestUrl]];
        NSDictionary *postDic = sendMsg.postDataDic;

        if (postDic)
        {
            NSArray *allKeys = [postDic allKeys];

            for (NSString *key in allKeys)
            {
                [(ASIFormDataRequest *)request setPostValue :[postDic objectForKey:key] forKey : key];
            }
        }
    }

    request.tag = msgTag;
    request.timeOutSeconds = sendMsg.timeout;
    request.shouldAttemptPersistentConnection = YES;
    request.responseEncoding = NSUTF8StringEncoding;
    request.validatesSecureCertificate = NO;

    [self.lock lock];

    // 这里retain 一次 方便外部释放对应
    [sendMsg retain];

    g_mapSend.insert(value_send(msgTag, sendMsg));

    [self.lock unlock];

    [self.networkQueue addOperation:request];

    [self.networkQueue go];
}

- (void)cancelHttpMsg:(HttpMessage *)msg
{
    if (msg == nil)
    {
        return;
    }

    DLog(@"msg id = %#x ", msg.cmdCode);

    int msgTag = [self getTagCode:msg.cmdCode];

    for (ASIHTTPRequest *request in [self.networkQueue operations])
    {
        if (request.tag == msgTag)
        {
            [request clearDelegatesAndCancel];
            break;
        }
    }
}

#pragma mark -
#pragma mark Request delegate methods
- (void)requestDidStart:(ASIHTTPRequest *)request
{
    DLog(@"----requestStarted----\n");
}

- (void)request:(ASIHTTPRequest *)request didReceiveResponseHeaders:(NSDictionary *)responseHeaders
{
    DLog(@"----didReceiveResponseHeaders----\n");
}

- (void)requestDidFinished:(ASIHTTPRequest *)request
{
    [self.lock lock];

    iter_send it = g_mapSend.find(request.tag);

    [self.lock unlock];

    if (it != g_mapSend.end())
    {
        HttpMessage *sendMsg = it->second;

        sendMsg.response = request.responseString;
        sendMsg.isSuccess = request.isSuccess;
        sendMsg.result = request.result;
        sendMsg.msg = request.msg;
        sendMsg.errorCode = request.errorCode;
        sendMsg.data = request.data;

        if (sendMsg.delegate && [sendMsg.delegate respondsToSelector:@selector(receiveDidFinished:)])
        {
            [sendMsg.delegate receiveDidFinished:sendMsg];
        }

        [sendMsg release];

        [self.lock lock];

        g_mapSend.erase(it);

        [self.lock unlock];
    }
}

- (void)requestDidFailed:(ASIHTTPRequest *)request
{
    [self.lock lock];

    iter_send it = g_mapSend.find(request.tag);

    [self.lock unlock];

    if (it != g_mapSend.end())
    {
        HttpMessage *sendMsg = it->second;

        sendMsg.error = [request error];

        if (sendMsg.delegate && [sendMsg.delegate respondsToSelector:@selector(receiveDidFailed:)])
        {
            [sendMsg.delegate receiveDidFailed:sendMsg];
        }

        [sendMsg release];

        [self.lock lock];

        g_mapSend.erase(it);

        [self.lock unlock];
    }
}

@end
