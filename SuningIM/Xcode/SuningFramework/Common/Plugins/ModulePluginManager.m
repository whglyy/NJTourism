//
//  ModulePluginManager.m
//  SuningPan
//
//  Created by shasha on 13-4-3.
//  Copyright (c) 2013年 suning. All rights reserved.
//

#import "ModulePluginManager.h"
#import <objc/runtime.h>

@implementation ModulePluginManager
@synthesize settingDTO = _settingDTO;

static ModulePluginManager *manager = nil;

- (id)init
{
self = [super init];
    if (self) {
        [self dataInit];
        [self registerObserverForSettings];
}
    return self;
}

- (void)dataInit{
    _nextId = 0;
    
    _registerModuleList = [[NSMutableArray alloc] init];
    
    PluginNameMap();
    
    _settingDTO = [[SettingsDTO alloc] init];
    NSArray *tempArr = [Config currentConfig].mySettingsDTO;
    SettingsDTO *configSettingDTO = nil;
    if (!IsArrEmpty(tempArr) ) {
        configSettingDTO = [tempArr objectAtIndex:0];
    }
    _settingDTO.versionTitle = configSettingDTO.versionTitle;
      _settingDTO.versionContent = configSettingDTO.versionContent;
      _settingDTO.versionDetail = configSettingDTO.versionDetail;
      _settingDTO.versionForce = configSettingDTO.versionForce;
     _settingDTO.serverVersion = configSettingDTO.serverVersion;
    
    _settingDTO.isAutoCopyPicture = configSettingDTO.isAutoCopyPicture;
    _settingDTO.isOnlyWifyUpload = configSettingDTO.isOnlyWifyUpload;
    _settingDTO.isNeedAlertVoice = configSettingDTO.isNeedAlertVoice;
    _settingDTO.uploadQuality = configSettingDTO.uploadQuality;
    _settingDTO.versionUpdateCancel = configSettingDTO.versionUpdateCancel;
}

- (void)registerModulesWithName:(NSArray *)nameList{

    if (IsArrEmpty(nameList)) {
        return;
    }else{
        for (NSString *name in nameList) {
            if (!IsStrEmpty(name)) {
                if (!IsNilOrNull(_PluginNameMap) && [[_PluginNameMap allKeys] containsObject:name]){
                    NSString *className = [_PluginNameMap objectForKey:name];
                    ModulePlugin *plugin = [[NSClassFromString(className) alloc] initWithModuleName:name];
                    [self registerModule:plugin];
                    continue;
                }else{
                    DLog(@"%@ is not contained in valide plugins",name);
                    continue;
                }
            }else{
                DLog(@"A empty name occur in your registerist");
            }
        }
    }
}

- (void)registerModule:(ModulePlugin *)module{
    if (IsNilOrNull(module)) {
        return;
    }
    [self.registerModuleList addObject:module];
    module.moduleId = self.nextId++;
    [module setManager:self];
}

- (ModulePlugin *)getModuleByName:(NSString *)name{

    if (IsArrEmpty(self.registerModuleList)) {
        return nil;
    }else{
        for (ModulePlugin *module in self.registerModuleList) {
            if ([module.moduleName isEqualToString:name]) {
                return module;
            }
        }
        return nil;
    }
}

- (ModulePlugin *)getModuleByType:(E_ModuleType)type{
    if (IsArrEmpty(self.registerModuleList)) {
        return nil;
    }else{
        for (ModulePlugin *module in self.registerModuleList) {
            if (module.moduleType == type) {
                return module;
            }
        }
        return nil;
    }
}

#pragma mark - KVO Listen SettingDTO Methods
#pragma mark   KVO监听SettingDTO  方法

//注册监听者
- (void)registerObserverForSettings{
    NSArray *propertyNameArr = [self getPropertiesNameList];
    if (IsArrEmpty(propertyNameArr)) {
        return;
    }else{
        for (NSString *propertyName in propertyNameArr) {
             [self.settingDTO addObserver:self forKeyPath:propertyName options:NSKeyValueObservingOptionNew context:NULL];
        }
    }
}

//注销监听者
- (void)unRegisterObserverForSettings{
    NSArray *propertyNameArr = [self getPropertiesNameList];
    if (IsArrEmpty(propertyNameArr)) {
        return;
    }else{
        for (NSString *properName in propertyNameArr) {
            [self.settingDTO removeObserver:self forKeyPath:properName];
        }
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context
{
    DLog(@"A property Changed");
    NSArray *tempArr = [NSArray arrayWithObject:self.settingDTO];
    [Config currentConfig].mySettingsDTO  = tempArr;
}

#pragma mark - Singlone Methods
#pragma mark   单例方法 
+ (ModulePluginManager*)currentManager {
    
	@synchronized(self) {
        
		if(!manager) {
            
			manager = [[ModulePluginManager alloc] init];
			
		}
	}
	
	return manager;
}

+ (void)releaseManager{
    
    if(manager){

        manager = nil;
    }
}

- (void)dealloc
{
    [self unRegisterObserverForSettings];
    _nextId = 0;
  
}





- (NSArray *)getPropertiesNameList{
    NSMutableArray *nameArr = [[NSMutableArray alloc] init];
    unsigned int outCount, i;
    Class cls = [SettingsDTO class];
    objc_property_t *properties = class_copyPropertyList(cls, &outCount);
    if (properties == NULL) {
        free(properties);
        return nameArr;
    }
    for (i = 0; i< outCount; i++) {
        objc_property_t property = properties[i];
        NSString *propertyName = [[NSString alloc]
                                   initWithCString:property_getName(property)
                                   encoding:NSUTF8StringEncoding]
                                  ;
        if (!IsStrEmpty(propertyName)) {
            [nameArr addObject:propertyName];
        }else{
            continue;
        }
    }
    free(properties);
    return nameArr;
}
@end
