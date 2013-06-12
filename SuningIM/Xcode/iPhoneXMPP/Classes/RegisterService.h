/**
    RegisterService.h
    RegisterService.h
    Created by wangman on 13-4-26.
      Copyright (c) 2013年 suning. All rights reserved.
 */

#import "DataService.h"

@protocol RegisterServiceDelegate <NSObject>
@optional

- (void)registerCompletedWithResult:(BOOL)isSuccess
                               errorMsg:(NSString *)errorMsg;
- (void)getVerCodeCompletedWithResult:(BOOL)isSuccess
                             errorMsg:(NSString *)errorMsg;
@end


@interface RegisterService : DataService
@property (nonatomic, assign) id<RegisterServiceDelegate>  delegate;

- (void)beginRegisterRequest:(NSString *)userId password:(NSString *)password passwordVerify:(NSString *)passwordVerify smsCheck:(NSString *)smsCheck regType:(NSString *)regType;
- (void)beginVerCodeRequest:(NSString *)userId phoneNum:(NSString *)phoneNum;
@end
