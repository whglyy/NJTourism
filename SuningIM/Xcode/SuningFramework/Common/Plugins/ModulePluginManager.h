//
//  ModulePluginManager.h
//  SuningPan
//
//  Created by shasha on 13-4-3.
//  Copyright (c) 2013年 suning. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PluginConstant.h"
#import "ModulePlugin.h"
#import "SettingsDTO.h"
@interface ModulePluginManager : NSObject
@property (nonatomic, retain) NSMutableArray  *registerModuleList;
@property (nonatomic, assign) NSInteger        nextId;

@property (nonatomic, retain) SettingsDTO     *settingDTO;

+ (ModulePluginManager *)currentManager;

- (ModulePlugin *)getModuleByName:(NSString *)name;
- (ModulePlugin *)getModuleByType:(E_ModuleType)type;
- (void)registerModule:(ModulePlugin *)module;
- (void)registerModulesWithName:(NSArray *)nameList;
//- (void)registerModulesWithType:(NSArray *)typeList;

@end
