//
//  SNXmppOffline.h
//  SuningIM
//
//  Created by shasha on 13-6-5.
//
//

#import "XMPPModule.h"

@interface SNXmppOffline : XMPPModule

//注册离线文件系统
- (void)registerOffline;

//退出离线文件系统
- (void)logoutOffline;

@end
