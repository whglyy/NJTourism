//
//  NSObject+GlobalDataManage.h
//  FatFist
//
//  Copyright 2011 FatFish. All rights reserved.
//
//

/*!
 
 @header   NSObject+GlobalDataManage
 @abstract 便捷获取app全局数据,使用self.XX便捷获取
 @author   lyywhg
 @version  1.0  2013/3/19 Creation
 
 */

#import <Foundation/Foundation.h>
#import "AppDelegate.h"
@interface NSObject (GlobalDataManage)
//应用程序代理
- (AppDelegate *)appDelegate;
@end
