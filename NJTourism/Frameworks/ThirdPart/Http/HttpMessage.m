//
//  HttpMessage.m
//  SuningIphone
//
//  Created by wangrui on 7/3/12.
//  Copyright (c) 2012 suning. All rights reserved.
//

#import "MsgConstant.h"
#import "HttpMessage.h"

@implementation HttpMessage

@synthesize cmdCode = _cmdCode;
@synthesize timeout = _timeout;
@synthesize requestUrl = _requestUrl;
@synthesize postDataDic = _postDataDic;
@synthesize delegate = _delegate;
@synthesize requestMethod = _requestMethod;

@synthesize error = _error;

@synthesize response = _response;
@synthesize isSuccess = isSuccess_;
@synthesize result = result_;
@synthesize msg = msg_;
@synthesize errorCode = errorCode_;
@synthesize data = data_;

- (void)dealloc
{
    TT_RELEASE_SAFELY(_requestUrl);
    TT_RELEASE_SAFELY(_postDataDic);
    _delegate = nil;
    TT_RELEASE_SAFELY(_requestMethod);
    TT_RELEASE_SAFELY(_response);
    TT_RELEASE_SAFELY(_error);

    TT_RELEASE_SAFELY(msg_);
    TT_RELEASE_SAFELY(errorCode_);
    TT_RELEASE_SAFELY(data_);

    [super dealloc];
}

- (id)init
{
    if (self = [super init])
    {
        self.timeout = HTTP_TIMEOUT;
    }

    return self;
}

- (id)initWithDelegate:(id <HttpResponseDelegate>)delegate
            requestUrl:(NSString *)url
           postDataDic:(NSDictionary *)postDic
               cmdCode:(E_CMDCODE)code
         requestMethod:(NSString *)method
{
    self = [super init];

    if (self)
    {
        self.timeout = HTTP_TIMEOUT;
        self.delegate = delegate;
        self.requestUrl = url;
        self.postDataDic = postDic;
        self.cmdCode = code;
        self.requestMethod = method;
    }

    return self;
}

- (void)cancelDelegate
{
    self.delegate = nil;
}

@end
