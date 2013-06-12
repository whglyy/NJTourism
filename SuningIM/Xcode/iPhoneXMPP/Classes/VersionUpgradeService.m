//
//  UpgradeService.m
//  SuningPan
//
//  Created by wangman on 13-5-4.
//  Copyright (c) 2013年 suning. All rights reserved.
//

#import "VersionUpgradeService.h"
@interface VersionUpgradeService()
- (void)Finished:(BOOL)isSuccess;
@end

@implementation VersionUpgradeService

- (void)beginVersionUpgradeRequest{
    NSMutableDictionary *postDataDic = [[NSMutableDictionary alloc] init];
    [postDataDic setObject:@"IOS" forKey:@"platformname"];
    [postDataDic setObject:@"mobile" forKey:@"productname"];
    [postDataDic setObject:@"1.0" forKey:@"versionno"];
    NSString *url = [NSString stringWithFormat:@"%@/%@/%@/%@",
                     kHostAddressForHttp,
                     ActionArea_Update,
                     ActionArea_Download,
                     ActionArea_DownloadUpdate];
    [self cancelRequestByCmdCode:CC_Upgrade];
    SNRequest *request =[self GET:url params:postDataDic];
    request.cmdCode = CC_Upgrade;
}

- (void)Finished:(BOOL)isSuccess{
    if ([self.delegate conformsToProtocol:@protocol(VersionUpgradeServiceDelegate) ]) {
        if ([self.delegate respondsToSelector:@selector(versionUpgradeCompletedWithResult:errorMsg:)]) {
            [self.delegate versionUpgradeCompletedWithResult:isSuccess errorMsg:self.errorMsg];
        }
    }
}
- (void)handleRequest:(SNRequest *)request{
    switch (request.cmdCode) {
        case CC_Upgrade:{
            if (request.failed) {
                self.errorMsg = [self  errorMsgOfRequestError:request.error];
                [self Finished:NO];
            }else if(request.succeed){
                BOOL isSuccess = [self isResponseSuccess:request.jsonItems withCMDCode:request.cmdCode];
                if (isSuccess) {
                    
                    NSDictionary *dataDic = [self dataInfoOfResponse:request.jsonItems];
                    NSDictionary *versiondic = [dataDic objectForKey:@"version"];
                    
                    [ModulePluginManager currentManager].settingDTO.upgrade =
                    EncodeObjectFromDic(dataDic, @"upgrade");
                    
                    if ([[ModulePluginManager currentManager].settingDTO.upgrade isEqual:@"Y"]) {
                        
                        [ModulePluginManager currentManager].settingDTO.downloadUrl =
                        EncodeObjectFromDic(versiondic, @"downloadUrl");
                        
                        [ModulePluginManager currentManager].settingDTO.forceUpgrade =
                        EncodeObjectFromDic(versiondic, @"isForce");
                        
                        NSString *verisonContentStr = EncodeObjectFromDic(versiondic, @"updateDesc");
                        if (IsStrEmpty(verisonContentStr)) {
                            verisonContentStr = L(@"do you want to update");
                        }
                        [ModulePluginManager currentManager].settingDTO.versionContent = verisonContentStr;
                    }
                    [self Finished:YES];
                }else{
                    
                    //Do Your Error Managerment
#warning 缺少错误处理
                    
                    if (IsStrEmpty(self.errorMsg)) {
                        self.errorMsg = kError_NormalRequestError;
                    }
                    [self Finished:NO];
                }
            }
        }
            break;
        default:
            break;
    }

}

@end
