/**
    LogoutService.h
    LogoutService.h
    Created by wangman on 13-5-3.
      Copyright (c) 2013年 suning. All rights reserved.
 */

#import "DataService.h"
#import "DataService.h"

@protocol LogoutServiceDelegate <NSObject>
@optional

- (void)logoutCompletedWithResult:(BOOL)isSuccess
                               errorMsg:(NSString *)errorMsg;

@end


@interface LogoutService : DataService
@property (nonatomic, assign) id<LogoutServiceDelegate>  delegate;

- (void)beginLogoutRequest:(NSString *)sessionId;

@end
