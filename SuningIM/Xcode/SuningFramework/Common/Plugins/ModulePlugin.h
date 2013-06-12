//
//  ModulePlugin.h
//  SuningPan
//
//  Created by shasha on 13-4-3.
//  Copyright (c) 2013年 suning. All rights reserved.
//

#import "PluginConstant.h"
@class ModulePluginManager;

@interface ModulePlugin : NSObject{
    ModulePluginManager *__manager;
}

@property (nonatomic, assign) BOOL             isViewController;
@property (nonatomic, assign) NSInteger        moduleId;
@property (nonatomic, copy)   NSString         *moduleName;
@property (nonatomic, assign) E_ModuleType      moduleType;

- (id)initWithModuleType:(E_ModuleType)type;
- (id)initWithModuleName:(NSString *)name;

- (void)setManager:(ModulePluginManager *)manager;

- (void)bePushedViewController:(UINavigationController *)navVC;
- (void)bePresentedViewController:(UIViewController *)parentVC;

- (void)excuteWithCompleteBlock:(SNCallBackBlockWithResult)block;

@end
