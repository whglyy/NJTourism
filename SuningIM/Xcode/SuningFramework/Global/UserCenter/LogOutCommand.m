//
//  LogOutCommand.m
//  SuningEBuy
//
//  Created by  liukun on 12-12-15.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "LogOutCommand.h"

@implementation LogOutCommand

- (void)dealloc
{
    //    SERVICE_RELEASE_SAFELY(_service);
    TT_RELEASE_SAFELY(logoutService);
    [[NSNotificationCenter defaultCenter] removeObserver:self name:LOGOUT_OK_NOTIFICATION object:nil];

   
}

- (id)init{
    self=[super init];
    if (self) {
        logoutService = [[LogoutService alloc]init];
        logoutService.delegate = self;
    }
    return self;
}




- (void)excute
{
    NSString *jid = [UserCenter defaultCenter].userInfoDTO.jid;
    if (NotNilAndNull(jid)) {
        [logoutService beginLogoutRequest:jid];
    }
}


- (void)logoutCompletedWithResult:(BOOL)isSuccess errorMsg:(NSString *)errorMsg{
    NSMutableDictionary  *notify = [[NSMutableDictionary alloc]init];
    if (errorMsg) {
        [notify setObject:errorMsg forKey:@"errorMsg"];
    }
    [notify setObject:[NSNumber numberWithBool:isSuccess] forKey:@"isSuccess"];
       [[NSNotificationCenter defaultCenter] postNotificationName:LOGOUT_OK_NOTIFICATION object:notify ];
 
  

}

@end
