//
//  VersionUpdateModulePlugin.h
//  SuningPan
//
//  Created by shasha on 13-4-7.
//  Copyright (c) 2013年 suning. All rights reserved.
//
#import "ModulePlugin.h"
#import "VersionUpgradeService.h"

#define kSystemVersionKey       @"SystemVersionKey"
#define kForceUpdateSwithKey    @"ForceUpdateSwithKey"

#define kUpdateVersionKey       @"UpdateVersionKey"
#define kUpdateTitleKey         @"UpdateTitleKey"
#define kUpdateContentKey       @"UpdateContentKey"
#define kUpdateDetailKey        @"UpdateDetailKey"
#define kDownLoadUrl            @"DownloadUrl"
#define kUpgrade                @"Upgrade"
#define kForceUpgrade           @"ForceUpgrade"
#define kVersionContent         @"VersionContent"

@interface VersionUpdateModulePlugin : ModulePlugin<VersionUpgradeServiceDelegate>
@end
