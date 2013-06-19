//
//  HttpMessage.h
//  SuningIphone
//
//  Created by wangrui on 7/3/12.
//  Copyright (c) 2012 suning. All rights reserved.
//

#import "MsgConstant.h"
#import "ASIHTTPRequest.h"
#import <Foundation/Foundation.h>

@protocol HttpResponseDelegate;

@interface HttpMessage : NSObject
{
    @private

    // 客户端请求信息

    E_CMDCODE     _cmdCode;                 // 请求标识
    NSInteger     _timeout;                 // 请求超时时间
    NSString     *_requestUrl;              // 请求地址
    NSDictionary *_postDataDic;             // 请求数据
    NSString     *_requestMethod;           // 请求方法

    // 服务端响应信息

    id <HttpResponseDelegate> _delegate;    // 请求回调
    NSString                 *_response;    // 响应信息
    NSError                  *_error;       // 请求失败的错误码

    // 电子书项目封装
    BOOL      isSuccess_;
    int       result_;
    NSString *msg_;
    NSString *errorCode_;
    id        data_;
}

@property (nonatomic, assign) E_CMDCODE                 cmdCode;
@property (nonatomic, assign) NSInteger                 timeout;
@property (nonatomic, copy)   NSString                 *requestUrl;
@property (nonatomic, retain) NSDictionary             *postDataDic;
@property (nonatomic, assign) id <HttpResponseDelegate> delegate;
@property (nonatomic, copy)   NSString                 *requestMethod;

@property (nonatomic, retain) NSError *error;

@property (nonatomic, copy)   NSString *response;
@property (nonatomic, assign) BOOL      isSuccess;
@property (nonatomic, assign) int       result;
@property (nonatomic, retain) NSString *msg;
@property (nonatomic, retain) NSString *errorCode;
@property (nonatomic, retain) id        data;

// use this to init
- (id)initWithDelegate:(id <HttpResponseDelegate>)delegate
            requestUrl:(NSString *)url
           postDataDic:(NSDictionary *)postDic
               cmdCode:(E_CMDCODE)code
         requestMethod:(NSString *)method;

/*!
 *   @abstract      取消代理
 */
- (void)cancelDelegate;
@end

#pragma mark delegate_
@protocol HttpResponseDelegate <NSObject>

@optional

- (void)receiveDidFinished:(HttpMessage *)receiveMsg;

- (void)receiveDidFailed:(HttpMessage *)receiveMsg;

@end
