//
//  SNXmppUserSetting.h
//  SuningIM
//
//  Created by shasha on 13-6-5.
//
//

#import "XMPPModule.h"
#import "SNXmppConstant.h"

@interface SNXmppUserSetting : XMPPModule

//添加用户标签
- (void)deleteUserLabel:(NSString *)userLabel;

//添加用户标签
- (void)getUserLabel:(BOOL)isConfirm;

//为好友添加标签
- (void)addLableForFriends:(NSString *)userLabel to:(NSString *)jid;

//确认添加用户标签
- (void)confirmAddUserLabel:(NSString *)userLabel labelId:(NSString *)labelId;

//保存用户设置
- (void)saveConfig:(EUserAddConfigType)type;

//获取用户设置
- (void)getConfig:(EUserAddConfigType)type;


@end
