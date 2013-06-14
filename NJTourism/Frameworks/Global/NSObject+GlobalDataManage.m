//
//  NSObject+GlobalDataManage.m
//  FatFist
//
//  Copyright 2011 FatFish. All rights reserved.
//
//
#import "NSObject+GlobalDataManage.h"
@implementation NSObject (GlobalDataManage)
- (AppDelegate *)appDelegate
{
    return [AppDelegate currentAppDelegate];
}
@end
