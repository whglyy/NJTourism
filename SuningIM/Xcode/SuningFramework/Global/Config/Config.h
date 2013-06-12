//
//  Config.m
//  
//
//  Created by     on 2010-4-18
//  Email:   --- at--- gmail.com
//  MSN:     --- at--- tom.com
//  Web Home:       
//  Copyright 2010   .All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SettingsDTO.h"

#define  dUID            NSStringFromSelector(@selector(uid))
#define  dUserId            NSStringFromSelector(@selector(userId))

#define  dPassword       NSStringFromSelector(@selector(password))
#define  dSavePassword   NSStringFromSelector(@selector(savePassword))
#define  dMySettingsDTO      NSStringFromSelector(@selector(mySettingsDTO))

#define dEverLaunched           NSStringFromSelector(@selector(everLaunched))
#define dFirstLaunch            NSStringFromSelector(@selector(firstLaunch))

#define  dCurrentFilesCount       NSStringFromSelector(@selector(currentFilesCount))
#define  dHaveSettedBoxPwd       NSStringFromSelector(@selector(haveSettedBoxPwd))
#define dLastUserId                        NSStringFromSelector(@selector(lastUserId))
#define dAutoLogin                  NSStringFromSelector(@selector(autoLogin))
#define dIsUpdate             NSStringFromSelector(@selector(isUpdate))
#define dVersionUpdateCancel   NSStringFromSelector(@selector(versionUpdateCancel))

//判断会话列表是否变化
#define dIsChatInfoChanged    NSStringFromSelector(@selector(isChatInfoChanged))

@interface Config : NSObject {
    
	NSUserDefaults                                      *defaults;
    
}

+(Config *)            currentConfig;


@property (readwrite, retain) NSUserDefaults             *defaults;

@property (nonatomic, readwrite, retain) NSNumber    *uid;
@property (nonatomic, readwrite, retain) NSString    *userId;
@property (nonatomic, readwrite, retain) NSNumber    *savePassword;
@property (nonatomic, readwrite, retain) NSString    *password;

@property (nonatomic, readwrite, retain) NSArray     *mySettingsDTO;

@property (nonatomic, readwrite, retain) NSNumber    *everLaunched;
@property (nonatomic, readwrite, retain) NSNumber    *firstLaunch;

@property (nonatomic, readwrite, retain) NSNumber    *currentFilesCount;
@property (nonatomic, readwrite, retain) NSNumber    *haveSettedBoxPwd;
@property (nonatomic, readwrite, retain) NSString    *lastUserId;
@property (nonatomic, readwrite, retain) NSNumber    *autoLogin;
@property (nonatomic, readwrite, retain) NSNumber    *isUpdate;
@property (nonatomic, readwrite, retain) NSString    *versionUpdateCancel;

@property (nonatomic, readwrite, retain) NSNumber    *isChatInfoChanged;

@end
