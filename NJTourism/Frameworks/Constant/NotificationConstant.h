//
//  MessageCenter.h
//  FatFist
//
//  Created by lyywhg on 13-5-24.
//
//

/**
 用于Notification Name的的定义，工程中的每一个Notification都必须在此定义并说明。
 */
//登录

/**
 登录完成:
 */
#define  LOGIN_OK_NOTIFICATION                           @"LOGIN_OK_MESSAGE"
//自动登录完成
#define  AUTOLOGIN_OK_NOTIFICATION                       @"AUTOLOGIN_OK_MESSAGE"

//注册完成
#define  REGISTE_OK_NOTIFICATION                         @"REGISTE_OK_MESSAGE"  

//登录session失效
#define  LOGIN_SESSION_FAILURE_NOTIFICATION                      @"LOGIN_SESSION_FAILURE"

//登录用户与上次登录不同
#define LOGIN_USER_CHANGE_NOTIFICATION                   @"LOGIN_USER_CHANGE_MESSAGE"

#define  POPUP_NOTIFICATION                         @"POPUP_MESSAGE"

#define  POPUP_NOTIFICATION                         @"POPUP_MESSAGE"

//注销
#define  LOGOUT_OK_NOTIFICATION                     @"LOGOUT_OK"
//
#define  BACK_HOME_NOTIFICATION                     @"BACK_HOME"

#define  ACTION_COMPLETE_NOTIFICATION               @"ACTION_COMPLETE"

//收到消息
#define  GETMESSAGEFROMESERVICE                     @"GETMESSAGEFROMESERVICE"      
 

