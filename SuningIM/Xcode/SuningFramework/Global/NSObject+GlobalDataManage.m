//
//  NSObject+GlobalDataManage.m
//  TempleteProject
//
//  Created by shasha on 13-3-19.
//  Copyright (c) 2013年 shasha. All rights reserved.
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

- (SettingsDTO *)settings{
    return [ModulePluginManager currentManager].settingDTO;
}

@end
