//
//  LocalCacheModulePlugin.m
//  SuningPan
//
//  Created by shasha on 13-4-5.
//  Copyright (c) 2013年 suning. All rights reserved.
//

#import "LocalCacheModulePlugin.h"
#import "EGOCache.h"

@interface LocalCacheModulePlugin(){
}

@end

@implementation LocalCacheModulePlugin
- (id)init
{
    self = [super init];
    if (self) {
        self.isViewController = NO;
        self.moduleId = 0;
        self.moduleType = eTypeLocalCacheModule;
        self.moduleName = kLocalCacheModuleName;
    }
    return self;
}

- (id)initWithModuleType:(E_ModuleType)type{
    
    self = [super init];
    if (self) {
        self.isViewController = NO;
        self.moduleId = 0;
        self.moduleType = type;
        self.moduleName = kLocalCacheModuleName;
        if (type == eTypeLocalCacheClearModule) {
            self.moduleName = klocalCacheClearModuleName;
        }else{
            self.moduleName = kLocalCacheModuleName;
        }
    }
    return self;
}

- (id)initWithModuleName:(NSString *)name{
    self = [super init];
    if (self) {
        self.isViewController = NO;
        self.moduleId = 0;
        self.moduleName = name;
        if (!IsStrEmpty(name)&&[name isEqualToString:kLocalCacheModuleName]) {
            self.moduleType = eTypeLocalCacheModule;
        }else{
            self.moduleType = eTypeLocalCacheClearModule;
        }
    }
    return self;
}

- (void)excuteWithCompleteBlock:(SNCallBackBlockWithResult)block{
    
    if (self.moduleType == eTypeLocalCacheClearModule) {
        [self clearImageMemory];
    }
    //Do some excute task
    SNBasicBlock backBlock = ^(void){
        NSString *totalCache = [[self getTotalImageLabelValue] copy];
        SNBasicBlock mainBlock = ^(void){
            if (block) {
                block(YES,nil,totalCache);
            }
        };
        PERFORMSEL_MAIN(mainBlock);
    };
    PERFORMSEL_BACK(backBlock);
}

- (NSInteger)totalImageMemory
{
    EGOCache *egoCache=[EGOCache currentCache];
    NSInteger length;
    NSInteger totalLength=0;
    NSDictionary *cacheDic = [egoCache.cacheDictionary copy];
    for (NSString *key in cacheDic) {
        NSData *data=[egoCache dataForKey:key];
        length=data.length;
        totalLength+=length;
    }
    return totalLength;
}

- (NSString *)getTotalImageLabelValue
{
    NSInteger memoryInt=[self totalImageMemory];
    NSString *stringInt = [NSString stringWithFormat:@"%d",memoryInt];
    float memoryfloat = [stringInt floatValue]/1024/1024*0.5;
    NSString *memoryStr=[NSString stringWithFormat:@"%.2f M",memoryfloat];
    return memoryStr;
}

- (void)clearImageMemory
{
    [[EGOCache currentCache] clearCache];
    
}

@end
