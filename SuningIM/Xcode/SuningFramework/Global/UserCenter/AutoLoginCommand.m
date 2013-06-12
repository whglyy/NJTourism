//
//  AutoLoginCommand.m
//  SuningEBuy
//
//  Created by  liukun on 12-12-15.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "AutoLoginCommand.h"

@implementation AutoLoginCommand



- (id)init
{
    self = [super init];
    if (self) {
        service = [[LoginService alloc] init];
        service.delegate = self;
    }
    return self;
}

- (void)execute
{
    NSString *userName = [Config currentConfig].userId;
    NSString *password = [Config currentConfig].password;
    
    if (![userName isEmptyOrWhitespace] && ![password isEmptyOrWhitespace])
    {
        [service beginLoginRequestWithUserName:userName passWord:password];
    }
}

- (void)LoginCompletedWithResult:(BOOL)isSuccess errorMsg:(NSString *)errorMsg
{
    //do nothing
    //the service do all the things need to do.
    
    //[[NSNotificationCenter defaultCenter] postNotificationName:AUTOLOGIN_OK_MESSAGE object:errorMsg];
    
   
}

@end
