//
//  NSObject+GlobalDataManage.m
//  TempleteProject
//
//  Created by lyywhg on 13-3-19.
//  Copyright (c) 2013年 lyywhg. All rights reserved.
//

#import "NSObject+GlobalDataManage.h"

@implementation NSObject (GlobalDataManage)

- (AppDelegate *)appDelegate
{
    return [AppDelegate currentAppDelegate];
}

- (UserInfoDTO *)user
{
    return [UserCenter defaultCenter].userInfoDTO;
}

@end
