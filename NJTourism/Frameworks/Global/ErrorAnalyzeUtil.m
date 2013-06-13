//
//  ErrorAnalyzeUtil.m
//  FatFist
//
//  Created by lyywhg on 13-5-24.
//
//

#import "ErrorAnalyzeUtil.h"

@implementation ErrorAnalyzeUtil

+ (BOOL)isSessionFailed:(NSString *)SNRetCode{
    if (!IsStrEmpty(SNRetCode)) {
        if ([SNRetCode isEqualToString:@"pan_interceptor_0000_e"]) {
            return YES;
        }else{
            return NO;
        }
    }else{
        return NO;
    }

}


+ (NSString *)getErrorMsg:(E_CMDCODE)cmdCode errorCode:(int)errorCode
{
    NSString *temString = L(@"unkown failture");
    switch (cmdCode) {
        case CC_GetVerCode:{
            switch (errorCode) {
                case 0:  return L(@"参数有错");

                default:
                    break;
            }
        }
            //拦截器
        default:
            break;
    }
    
    
    return temString;
}
@end
