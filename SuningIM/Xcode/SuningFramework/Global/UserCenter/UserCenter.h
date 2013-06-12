//
//  UserCenter.h
//  TempleteProject
//
//  Created by shasha on 13-3-19.
//  Copyright (c) 2013年 shasha. All rights reserved.
//

/*!
 
 @header   UserCenter
 @abstract 用户信息中心
 @author   莎莎
 @version  1.0  2013/3/19 Creation
 */

#import <Foundation/Foundation.h>
#import "UserInfoDTO.h"
#import "SNXMPPvCard.h"

@interface UserCenter : NSObject{
@private
    BOOL                 _isLogined;
    UserInfoDTO          *_userInfoDTO;
    NSString            *_lastUserId;
}

/*!
 @property  isLogined
 @abstract  标识位，标识是否有用户登录
 */
@property (nonatomic, readonly) BOOL isLogined;

/*!
 @property      userInfoDTO
 @abstract      保存用户信息的DTO
 */
@property (nonatomic, strong) UserInfoDTO *userInfoDTO;

@property (nonatomic, readonly ,assign)   BOOL         isBindPhone;

@property (nonatomic, strong) NSString     *bindPhoneNum;

@property (nonatomic, strong) NSString  *lastUserId;

@property (nonatomic, strong) SNXMPPvCard  *userVCard;

+ (UserCenter *)defaultCenter;

@end
