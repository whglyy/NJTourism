//
//  Config.m
//  FatFist
//
//  Copyright 2011 FatFish. All rights reserved.
//
//
#import <Foundation/Foundation.h>

//本地语言
#define  dLocalLanguage          NSStringFromSelector(@selector(localLanguage))

#define  dUID                    NSStringFromSelector(@selector(uid))
#define  dUserId                 NSStringFromSelector(@selector(userId))
#define  dPassword               NSStringFromSelector(@selector(password))
#define  dSavePassword           NSStringFromSelector(@selector(savePassword))
#define  dMySettingsDTO          NSStringFromSelector(@selector(mySettingsDTO))
#define  dEverLaunched           NSStringFromSelector(@selector(everLaunched))
#define  dFirstLaunch            NSStringFromSelector(@selector(firstLaunch))
#define  dCurrentFilesCount      NSStringFromSelector(@selector(currentFilesCount))
#define  dHaveSettedBoxPwd       NSStringFromSelector(@selector(haveSettedBoxPwd))
#define  dLastUserId             NSStringFromSelector(@selector(lastUserId))
#define  dAutoLogin              NSStringFromSelector(@selector(autoLogin))
#define  dIsUpdate               NSStringFromSelector(@selector(isUpdate))
#define  dVersionUpdateCancel    NSStringFromSelector(@selector(versionUpdateCancel))

@interface Config : NSObject
{    
	NSUserDefaults *defaults;
}

+(Config *)            currentConfig;

@property (readwrite, retain) NSUserDefaults             *defaults;

@property (nonatomic, readwrite, retain) NSNumber    *localLanguage;

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
