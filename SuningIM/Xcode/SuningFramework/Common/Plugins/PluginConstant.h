//
//  PluginConstant.h
//  SuningPan
//
//  Created by shasha on 13-4-5.
//  Copyright (c) 2013年 suning. All rights reserved.
//

typedef enum{
    eTypeModulePlugin               = 0,//组建类型
    eTypeSafePasswordModule         = 1,//密码锁类型
    eTypeFeedBackModule             = 2,//用户反馈类型
    eTypeLocalCacheModule           = 3,//本地缓存类型
    eTypeLocalCacheClearModule      = 4,//清除本地缓存类型
    eTypeTrafficStaticModule        = 5,//流量统计类型
    eTypeAutoVersionUpdateModule    = 6,//自动版本更新类型
    eTypeManulVersionUpdateModule   = 7,//手动版本更新类型
    eTypeMustVersionUpdateModule    = 8,//强制更新版本类型
    eTypeHelperGuidPlugin           = 9,//指引页
} E_ModuleType;

#define kModulePluginName               @"modulePlugin"
#define kSafePasswordModuleName         @"safePasswordModule"
#define kFeedBackModuleName             @"feedBackModule"
#define kLocalCacheModuleName           @"localCacheModule"
#define klocalCacheClearModuleName      @"localCacheClearModule"
#define kTrafficStaticModuleName        @"trafficStaticModule"
#define kManulVersionUpdateModuleName   @"manulVersionUpdateModule"
#define kAutoVersionUpdateModuleName    @"autoVersionUpdateModule"
#define kHelperGuidModuleName           @"HelperGuidModule"


static NSDictionary *_PluginNameMap;

static inline NSDictionary *PluginNameMap(){
    if (!_PluginNameMap) {
        _PluginNameMap = [[NSDictionary alloc] initWithObjectsAndKeys:
                          @"TrafficStatisticModulePlugin",kTrafficStaticModuleName,
                          @"LocalCacheModulePlugin",kLocalCacheModuleName,
                          @"LocalCacheModulePlugin",klocalCacheClearModuleName,
                          @"FeedBackModulePlugin",kFeedBackModuleName,
                          @"VersionUpdateModulePlugin",kManulVersionUpdateModuleName,
                          @"VersionUpdateModulePlugin",kAutoVersionUpdateModuleName,
                          @"HelperGuidModulePlugin",kHelperGuidModuleName,
                          nil];
    }
    return _PluginNameMap;
}
