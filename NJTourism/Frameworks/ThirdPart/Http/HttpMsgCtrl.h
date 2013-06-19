//
//  HttpMsgCtrl.h
//  SuningIphone
//
//  Created by wangrui on 7/3/12.
//  Copyright (c) 2012 suning. All rights reserved.
//

#import "HttpMessage.h"
#import <Foundation/Foundation.h>

@class ASINetworkQueue;

@interface HttpMsgCtrl : NSObject
{
    @private
    NSLock          *_lock;
    ASINetworkQueue *_networkQueue;
}

@property (nonatomic, retain) NSLock          *lock;
@property (nonatomic, retain) ASINetworkQueue *networkQueue;

// 获取实例方法
+ (HttpMsgCtrl *)shareInstance;

// 发送请求
- (void)sendHttpMsg:(HttpMessage *)sendMsg;

// 取消发送请求 add by liukun
- (void)cancelHttpMsg:(HttpMessage *)msg;

@end
