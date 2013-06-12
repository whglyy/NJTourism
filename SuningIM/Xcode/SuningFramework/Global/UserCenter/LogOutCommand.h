//
//  LogOutCommand.h
//  SuningEBuy
//
//  Created by  liukun on 12-12-15.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "Command.h"
#import "LogoutService.h"

@interface LogOutCommand : Command<LogoutServiceDelegate>
{
@private
    LogoutService *logoutService;
}
//注册送券
- (void)excute;

@end
