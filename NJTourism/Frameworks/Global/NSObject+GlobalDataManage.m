//
//  NSObject+GlobalDataManage.m
//  FatFist
//
//  Created by lyywhg on 13-5-24.
//
//

#import "NSObject+GlobalDataManage.h"

@implementation NSObject (GlobalDataManage)

- (AppDelegate *)appDelegate
{
    return [AppDelegate currentAppDelegate];
}

@end
