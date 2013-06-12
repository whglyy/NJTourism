//
//  LogoutService.m
//  SuningPan
//
//  Created by wangman on 13-5-3.
//  Copyright (c) 2013年 suning. All rights reserved.
//

#import "LogoutService.h"
@interface LogoutService()
- (void)Finished:(BOOL)isSuccess;
@end

@implementation LogoutService

- (void)beginLogoutRequest:(NSString *)sessionId{
//    NSMutableDictionary *postDataDic = [[NSMutableDictionary alloc] init];
//    [postDataDic setObject:jid forKey:@"jid"];
    NSString *url = nil;

    [self cancelRequestByCmdCode:CC_Logout];
    SNRequest *request =[self GET:url params:nil];
    request.cmdCode = CC_Logout;
}

- (void)Finished:(BOOL)isSuccess{
    if ([self.delegate conformsToProtocol:@protocol(LogoutServiceDelegate) ]) {
        if ([self.delegate respondsToSelector:@selector(logoutCompletedWithResult:errorMsg:)]) {
            [self.delegate logoutCompletedWithResult:isSuccess errorMsg:self.errorMsg];
        }
    }
}
- (void)handleRequest:(SNRequest *)request{
    switch (request.cmdCode) {
        case CC_Logout:{
            if (request.failed) {
                self.errorMsg = [self  errorMsgOfRequestError:request.error];
                [self Finished:NO];
            }else if(request.succeed){
                BOOL isSuccess = [self isResponseSuccess:request.jsonItems withCMDCode:request.cmdCode];
                if (isSuccess) {                    
                    [self Finished:YES];
                }else{
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
