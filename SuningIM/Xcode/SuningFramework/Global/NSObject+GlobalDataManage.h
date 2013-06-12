//
//  NSObject+GlobalDataManage.h
//  TempleteProject
//
//  Created by shasha on 13-3-19.
//  Copyright (c) 2013年 shasha. All rights reserved.
//

/*!
 
 @header   NSObject+GlobalDataManage
 @abstract 便捷获取app全局数据,使用self.XX便捷获取
 @author   莎莎
 @version  1.0  2013/3/19 Creation
 
 */
#import <Foundation/Foundation.h>

@interface NSObject (GlobalDataManage)
//应用程序代理
- (AppDelegate *)appDelegate;

//当前用户
- (UserInfoDTO *)user;

- (SettingsDTO *)settings;
@end
