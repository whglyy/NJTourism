//
//  AutoLoginCommand.h
//  SuningEBuy
//
//  Created by  liukun on 12-12-15.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "Command.h"
#import "LoginService.h"

@interface AutoLoginCommand : Command <LoginServiceDelegate>
{
    LoginService *service;
}

@end
