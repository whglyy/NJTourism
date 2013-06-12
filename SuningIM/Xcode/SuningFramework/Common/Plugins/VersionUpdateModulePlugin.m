//
//  VersionUpdateModulePlugin.m
//  SuningPan
//
//  Created by shasha on 13-4-7.
//  Copyright (c) 2013年 suning. All rights reserved.
//

#import "VersionUpdateModulePlugin.h"
#import "ModulePluginManager.h"

@interface VersionUpdateModulePlugin (){
    SNCallBackBlockWithResult completionBlock;
}

@property (nonatomic, retain) VersionUpgradeService  *versionUpdateService;

@end

@implementation VersionUpdateModulePlugin

- (void)dealloc
{
    SERVICE_RELEASE_SAFELY(_versionUpdateService);
    completionBlock = nil;
}

- (id)init
{
    self = [super init];
    if (self) {
        self.isViewController = NO;
        self.moduleId = 0;
        self.moduleType = eTypeAutoVersionUpdateModule;
        self.moduleName = kAutoVersionUpdateModuleName;
        _versionUpdateService = [[VersionUpgradeService alloc]init];
        _versionUpdateService.delegate = self;
    }
    return self;
}


- (id)initWithModuleType:(E_ModuleType)type{
    
    self = [super init];
    if (self) {
        self.isViewController = NO;
        self.moduleId = 0;
        self.moduleType = type;
        if (type == eTypeManulVersionUpdateModule) {
            self.moduleName = kManulVersionUpdateModuleName;
        }else{
            self.moduleName = kAutoVersionUpdateModuleName;
        }
        _versionUpdateService = [[VersionUpgradeService alloc]init];
        _versionUpdateService.delegate = self;
    }
    return self;
}

- (id)initWithModuleName:(NSString *)name{
    
    self = [super init];
    if (self) {
        self.isViewController = NO;
        self.moduleId = 0;
        self.moduleName = name;
        if (!IsStrEmpty(name) && [name isEqualToString:kManulVersionUpdateModuleName]) {
            self.moduleType = eTypeManulVersionUpdateModule;
        }else{
            self.moduleType = eTypeAutoVersionUpdateModule;
        }
        _versionUpdateService = [[VersionUpgradeService alloc]init];
        _versionUpdateService.delegate = self;
    }
    return self;
}

-(void)excuteWithCompleteBlock:(SNCallBackBlockWithResult)block{

    [self setCompletionBlock:block];
    
    [self.versionUpdateService beginVersionUpgradeRequest];
}

- (void)versionUpgradeCompletedWithResult:(BOOL)isSuccess errorMsg:(NSString *)errorMsg{
    if (isSuccess) {
        
        NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                             __manager.settingDTO.upgrade,kUpgrade,
                             __manager.settingDTO.downloadUrl,
                             kDownLoadUrl,
                             __manager.settingDTO.versionContent,kVersionContent,
                             __manager.settingDTO.forceUpgrade,kForceUpgrade,
                             __manager.settingDTO.versionTitle,kUpdateTitleKey,
                             __manager.settingDTO.versionDetail,kUpdateDetailKey,
                             __manager.settingDTO.versionForce,
                             kForceUpdateSwithKey,
                             nil];
        
        [self checkVersionUpdateWithSwithMap:dic];

    }else{
        if (completionBlock) {
            completionBlock(NO,errorMsg,nil);
        }
    }
}

- (void)setCompletionBlock:(SNCallBackBlockWithResult)block
{
    completionBlock = [block copy];
}

- (void)checkVersionUpdateWithSwithMap:(NSDictionary *)map
{
    if (map == nil || [map count] == 0) {
        
        if (completionBlock) {
            completionBlock(NO,@"No Version Map To Check",nil);
        }
        return;
    }
    
//    NSDictionary *updateInfoDic = [map objectForKey:kSystemVersionKey];
//    
//    if (NotNilAndNull(updateInfoDic) && [updateInfoDic isKindOfClass:[NSDictionary class]]) {
//        
//        NSString *serverVersion = [updateInfoDic objectForKey:kUpdateVersionKey];
//        NSString *clientVersion =
//        [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
    
        //需要更新
//        if (NotNilAndNull(serverVersion) &&
//            [self checkVersionIsNeedUpdateClientV:clientVersion serverV:serverVersion]) {
    if (NotNilAndNull(map)) {
     
        if ([[map objectForKey:kUpgrade] isEqual:@"Y"]) {
            
            NSString *showContent = nil;
            NSString *content = [map objectForKey:kVersionContent];
            if (IsStrEmpty(content)) {
                content = L(@"发现新版本，是否更新？");
            }
            NSString  *detail = [map objectForKey:kUpdateDetailKey];
            NSString *title = [map objectForKey:kUpdateTitleKey];
            if (IsStrEmpty(title)) {
                title = L(@"版本更新");
            }
            if (!IsStrEmpty(content) && !IsStrEmpty(detail)) {
                detail = [detail stringByReplacingOccurrencesOfString:@"<br />" withString:@"\n"];
                showContent = [NSString stringWithFormat:@"%@\n%@", content, detail];
            }else{
                showContent = content;
            }
            //是否需要强制更新
            if (self.moduleType == eTypeManulVersionUpdateModule && completionBlock) {
                completionBlock(YES,nil,nil);
            }
            if ([self isNeedForceUpdate:map]) {
                [self showMustVersionUpdateDialog:NotNilAndNull(title)?title:nil
                                          content:showContent];
            }else{
                [self showVersionUpdateDialog:NotNilAndNull(title)?title:nil
                                      content:showContent];
            }
        }else{ //不需要更新
            
            if (completionBlock) {
                completionBlock(YES,nil,nil);
            }
            if (self.moduleType == eTypeManulVersionUpdateModule) {   //手动更新
                [self showNoneUpdateDialog];
            }
        }
    }else{
        
        if (completionBlock) {
            completionBlock(NO,@"Error_NoUpdateInfoDic",nil);
        }
    }
    
    
}


- (BOOL)isNeedUpdate:(NSDictionary *)map{

    NSString *Update = [map objectForKey:kUpgrade];
    if (IsStrEmpty(Update)) {
        return NO;
    }
    if ([Update isEqualToString:@"Y"]) {
        return YES;
    }else{
        return NO;
    }

}


- (BOOL)isNeedForceUpdate:(NSDictionary *)map{

    NSString *forceUpdate = [map objectForKey:kForceUpgrade];
    if (IsStrEmpty(forceUpdate)) {
        return NO;
    }
    
    if ([forceUpdate isEqualToString:@"Y"]) {
        return YES;
    }else{
        return NO; 
    }
    
}

//更新提示信息：
- (void)showVersionUpdateDialog:(NSString *)title
                        content:(NSString *)content
{
    BBAlertView *alertView = [[BBAlertView alloc] initWithTitle:IsStrEmpty(title)?L(@"UpdateVersionTip"):title
                                                        message:IsStrEmpty(content)?L(@"versionUpdate"):content
                                                       delegate:nil
                                              cancelButtonTitle:L(@"LaterUpdate")
                                              otherButtonTitles:L(@"NowUpdate")];
    alertView.contentAlignment = UITextAlignmentLeft;
    [alertView setConfirmBlock:^{
        NSURL *iTunesUrl = [NSURL URLWithString:[ModulePluginManager currentManager].settingDTO.downloadUrl];
        
        [[UIApplication sharedApplication] openURL:iTunesUrl];
        
        if (self.moduleType == eTypeAutoVersionUpdateModule && completionBlock) {
            completionBlock(YES,nil,nil);
        }
    }];
    
    [alertView setCancelBlock:^{
        if (self.moduleType == eTypeAutoVersionUpdateModule && completionBlock) {
            completionBlock(YES,nil,nil);
            int i =  [self.settings.versionUpdateCancel intValue];
            self.settings.versionUpdateCancel= [NSNumber numberWithInt:(i+1)];
            DLog("%d.....",[self.settings.versionUpdateCancel intValue]);
        }
    }];
    
    [alertView show];
   
    
}

//强制更新提示信息：
- (void)showMustVersionUpdateDialog:(NSString *)title content:(NSString *)content
{
    BBAlertView *alertView = [[BBAlertView alloc] initWithTitle:IsStrEmpty(title)?L(@"UpdateVersionTip"):title
                                                        message:IsStrEmpty(content)?L(@"versionUpdate"):content
                                                       delegate:nil
                                              cancelButtonTitle:nil
                                              otherButtonTitles:L(@"Ok")];
    alertView.contentAlignment = UITextAlignmentLeft;
    
    alertView.shouldDismissAfterConfirm = NO;
    
    [alertView setConfirmBlock:^{
        
        NSURL *iTunesUrl = [NSURL URLWithString:[ModulePluginManager currentManager].settingDTO.downloadUrl];
        
        [[UIApplication sharedApplication] openURL:iTunesUrl];
        
    }];
    
    [alertView show];
  
}

- (void)showNoneUpdateDialog
{
    BBAlertView *alertView = [[BBAlertView alloc] initWithTitle:nil
                                                        message:L(@"MostUpdateVersion")
                                                       delegate:nil
                                              cancelButtonTitle:L(@"Ok")
                                              otherButtonTitles:nil];
    
    [alertView show];
    

}


//判断是否需要更新的算法
//- (BOOL)checkVersionIsNeedUpdateClientV:(NSString *)clientVer
//                                serverV:(NSString *)serverVer
//{
//    if (IsNilOrNull(clientVer) ||
//        [clientVer isEmptyOrWhitespace] ||
//        IsNilOrNull(serverVer) ||
//        [serverVer isEmptyOrWhitespace])
//    {
//        return NO;
//    }
//    NSArray *clientArray = [clientVer componentsSeparatedByString:@"."];
//    NSArray *serverArray = [serverVer componentsSeparatedByString:@"."];
//    NSInteger count =
//    ([clientArray count] > [serverArray count]) ? [clientArray count] : [serverArray count];
//
//    for (int i = 0; i < count; i++) {
//        NSString *clientString = i < [clientArray count] ? [clientArray objectAtIndex:i] : @"0";
//        NSString *serverString = i < [serverArray count] ? [serverArray objectAtIndex:i] : @"0";
//        if ([clientString intValue] < [serverString intValue]) {
//            return YES;
//        }else if ([clientString intValue] > [serverString intValue]){
//            return NO;
//        }
//    }
//    return NO;
//}


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
