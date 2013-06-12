//
//  ModulePlugin.m
//  SuningPan
//
//  Created by shasha on 13-4-3.
//  Copyright (c) 2013年 suning. All rights reserved.
//

#import "ModulePlugin.h"
#import "ModulePluginManager.h"

@interface ModulePlugin(){
}

@end

@implementation ModulePlugin

- (id)initWithModuleType:(E_ModuleType)type{
    
    self = [super init];
    if (self) {
        _isViewController = NO;
        _moduleId = 0;
        _moduleType = type;
        _moduleName = kModulePluginName;
    }
    return self;
}

- (id)initWithModuleName:(NSString *)name{
    self = [super init];
    if (self) {
        _isViewController = NO;
        _moduleId = 0;
        _moduleType = eTypeModulePlugin;
        _moduleName = name;
    }
    return self;
}



- (void)setManager:(ModulePluginManager *)manager{
    __manager = manager;
}

- (void)bePresentedViewController:(UIViewController *)parentVC{
    DLog(@"This Plugin is not a type of ViewController");
}

- (void)bePushedViewController:(UINavigationController *)navVC{
    DLog(@"This Plugin is not a type of ViewController");
}

- (void)excuteWithCompleteBlock:(SNCallBackBlockWithResult)block{
    DLog(@"This Plugin is not a type of Object can excute operation");
}

@end
