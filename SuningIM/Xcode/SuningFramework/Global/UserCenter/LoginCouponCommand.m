//
//  LoginCouponCommand.m
//  SuningEBuy
//
//  Created by  zhang jian on 13-3-26.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "LoginCouponCommand.h"

@interface LoginCouponCommand()


@end

/*********************************************************************/

@implementation LoginCouponCommand

//@synthesize service = _service;



- (id)initWithUserId:(NSString *)userId
{
    self = [super init];
    if (self) {
        _userId = [userId copy];
    }
    return self;
}


//是否可以送券
- (BOOL)canHandselCounponActionKey:(NSString **)actionKey
{
//    NSDictionary *activityMap = [GlobalDataCenter defaultCenter].activitySwitchMap;
//    
//    for (NSString *actionName in [activityMap allKeys])
//    {
//        if ([actionName hasPrefix:@"Mobileloginios"]) {
//            NSString *switchValue = [activityMap objectForKey:actionName];
//            NSArray *list = [switchValue componentsSeparatedByString:@","];
//            
//            for (NSString *dc in list)
//            {
//                if ([dc isEqualToString:kDownloadChannel]) {
//                    *actionKey = actionName;
//                    return YES;
//                }
//            }
//        }
//    }
    return NO;
}

- (void)beginActivityRequest
{
    NSString *actionName = nil;
    if ([self canHandselCounponActionKey:&actionName]) {
        
        
//        [self.service beginActivityWithActionName:actionName userId:_userId];
    }
}

- (void)excute
{
    //判断用户是否登录或是注册的userId,如果不是就监听登录,retain自己
//    if (![UserCenter defaultCenter].isLogined ||
//        ![[UserCenter defaultCenter].userInfoDTO.userId isEqualToString:_userId])
//    {
//        
//        
//        [[NSNotificationCenter defaultCenter] addObserver:self
//                                                 selector:@selector(handselCoupon:)
//                                                     name:LOGIN_OK_MESSAGE
//                                                   object:nil];
//        
//        return;
//    }
    
//    //先判断活动开关列表是否获取成功
//    NSDictionary *activityMap = [GlobalDataCenter defaultCenter].activitySwitchMap;
//    if (activityMap)
//    {
//        [self beginActivityRequest];
//    }
//    else   //没有获取开关时，先获取开关列表
//    {
//        
//        [self retain];
//        [self.service beginGetSwitchList];
//    }
}

- (void)handselCoupon:(NSNotification *)notification
{
//    [[NSNotificationCenter defaultCenter] removeObserver:self
//                                                    name:LOGIN_OK_MESSAGE
//                                                  object:nil];
    
    [self excute];
    
 
}

- (void)getSwitchListCompletionWithResult:(BOOL)isSuccess map:(NSDictionary *)swithMap
{
    if (isSuccess) {
//        [GlobalDataCenter defaultCenter].activitySwitchMap = swithMap;
        
        [self beginActivityRequest];
    }
    
    
}

- (void)activityActionCompletionWithResult:(BOOL)isSuccess errorMsg:(NSString *)errorMsg
{
    
    //暂无操作可做
   
}
@end
