//
//  HelperGuidModulePlugin.m
//  SuningPan
//
//  Created by shasha on 13-5-6.
//  Copyright (c) 2013年 suning. All rights reserved.
//
#import "HelpViewController.h"
#import "HelperGuidModulePlugin.h"

@implementation HelperGuidModulePlugin
- (id)init
{
    self = [super init];
    if (self) {
        self.isViewController = NO;
        self.moduleId = 0;
        self.moduleType = eTypeHelperGuidPlugin;
        self.moduleName = kHelperGuidModuleName;
    }
    return self;
}


- (id)initWithModuleType:(E_ModuleType)type{
    
    self = [super init];
    if (self) {
        self.isViewController = NO;
        self.moduleId = 0;
        self.moduleType = type;
        self.moduleName = kHelperGuidModuleName;
     }
    return self;
}

- (id)initWithModuleName:(NSString *)name{
    
    self = [super init];
    if (self) {
        self.isViewController = NO;
        self.moduleId = 0;
        self.moduleName = name;
        self.moduleType = eTypeHelperGuidPlugin;
    }
    return self;
}

- (void)excuteWithCompleteBlock:(SNCallBackBlockWithResult)block{
    
    NSString *clientVersion = [SystemInfo softwareVersion];
    NSString *helperVersion = self.settings.helperVersion;
    BOOL isNeedShowGuid = [self checkVersionIsHelperGuidClientV:clientVersion
                                                     HlperGuidV:helperVersion];
    if (isNeedShowGuid) {
        HelpViewController *helperViewController = [[HelpViewController alloc] init];
        helperViewController.type = 1;
        //启动帮助页面
        [[UIApplication sharedApplication].keyWindow addSubview:helperViewController.view];

        self.settings.helperVersion = clientVersion;
    }
    
    if (block) {
        block(YES,nil,nil);
    }
}

//判断是否需要展示指引页的算法
- (BOOL)checkVersionIsHelperGuidClientV:(NSString *)clientVer
                             HlperGuidV:(NSString *)HelperGuidVer
{
    if (IsNilOrNull(clientVer) ||
        [clientVer isEmptyOrWhitespace] ||
        IsNilOrNull(HelperGuidVer) ||
        [HelperGuidVer isEmptyOrWhitespace])
    {
        return NO;
    }
    NSArray *clientArray = [clientVer componentsSeparatedByString:@"."];
    NSArray *helperArray = [HelperGuidVer componentsSeparatedByString:@"."];
    NSInteger count =
    ([clientArray count] > [helperArray count]) ? [clientArray count] : [helperArray count];

    for (int i = 0; i < count; i++) {
        NSString *clientString = i < [clientArray count] ? [clientArray objectAtIndex:i] : @"0";
        NSString *helperString = i < [helperArray count] ? [helperArray objectAtIndex:i] : @"0";
        if ([clientString intValue] < [helperString intValue]) {
            return YES;
        }else if ([clientString intValue] > [helperString intValue]){
            return NO;
        }
    }
    return NO;
}


//- (BOOL)isNeedForceUpdate:(NSDictionary *)map
//{
//    NSString *forceUpdateVersions = [map objectForKey:kForceUpdateSwithKey];
//
//    NSArray *versions = [forceUpdateVersions componentsSeparatedByString:@","];
//
//    if (versions && [versions count] > 0) {
//        NSString *clientVersion =
//        [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
//
//        for (NSString *ver in versions)
//        {
//            if ([ver isEqualToString:clientVersion]) {
//                return YES;
//            }
//        }
//    }
//    return NO;
//}

@end
