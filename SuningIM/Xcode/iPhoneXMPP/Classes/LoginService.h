/**
    LoginService.h
    LoginService.h
    Created by shasha on 13-4-2.
      Copyright (c) 2013年 suning. All rights reserved.
 */

#import <Foundation/Foundation.h>
#import "DataService.h"
#import "UserInfoDTO.h"

@protocol LoginServiceDelegate <NSObject>
@optional

- (void)LoginCompletedWithResult:(BOOL)isSuccess
                               errorMsg:(NSString *)errorMsg;
@end


@interface LoginService : DataService
@property (nonatomic, assign) id<LoginServiceDelegate>  delegate;
@property (nonatomic, retain) NSString *uid;
@property (nonatomic, retain) NSString *password;

- (void)beginLoginRequestWithUserName:(NSString *)userName passWord:(NSString *)password;

@end
