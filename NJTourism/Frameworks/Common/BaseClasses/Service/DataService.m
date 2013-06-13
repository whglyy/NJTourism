//
//  DataService.m
//  FatFist
//
//  Created by lyywhg on 13-5-24.
//
//

#import "DataService.h"
#import "ErrorAnalyzeUtil.h"

@implementation DataService


- (void)dealloc
{
    [self cancelRequests];

}

- (NSString *)errorMsgOfRequestError:(NSError *)error
{
    ASINetworkErrorType errorCode = error.code;
    
    NSString *errorMsg = nil;
    
    switch (errorCode)
    {
        case ASIConnectionFailureErrorType:
        {
            //连接失败
            errorMsg = L(@"A connection failure occurred");
            
            break;
        }
        case ASIRequestTimedOutErrorType:
        {
            //请求超时
            errorMsg = L(@"The request timed out");
            
            break;
        }
        case ASIAuthenticationErrorType:
        {
            //认证失败
            errorMsg = L(@"Authentication needed");
            
            break;
        }
        case ASIRequestCancelledErrorType:
        {
            //请求被取消
            errorMsg = L(@"The request was cancelled");
            
            break;
        }
        case ASIUnableToCreateRequestErrorType:
        {
            //url不合法，无法创建网络请求
            errorMsg = L(@"Unable to create request (bad url?)");
            
            break;
        }
        case ASIInternalErrorWhileBuildingRequestType:
        {
            //无法连接代理服务器
            errorMsg =  L(@"Unable to obtain information on proxy servers needed for request");
            
            break;
        }
        case ASIInternalErrorWhileApplyingCredentialsType:
        {
            //无法获取认证信息
            errorMsg = L(@"Failed to get authentication object from response headers");
            
            break;
        }
        case ASIFileManagementError:
        {
            DLog(@"%@",[[error userInfo] objectForKey:NSLocalizedDescriptionKey]);
            //文件操作有误
            errorMsg = L(@"Fail to handle file operation");;
            
            break;
        }
        case ASITooMuchRedirectionErrorType:
        {
            //重定向次数过多
            errorMsg = @"The request failed because it redirected too many times";
            
            break;
        }
        case ASICompressionError:
        {
            //数据解压失败
            errorMsg = @"Compression data failed";
            
            break;
        }
        default:
        {
            //发生未知错误
            errorMsg = @"Unknown exception";
            
            break;
        }
    }
        
    return L(errorMsg);
}

- (BOOL)isResponseSuccess:(NSDictionary *)items withCMDCode:(E_CMDCODE)cmd
{
//解析状态信息，返回response的状态。
    NSString *issuccess = EncodeObjectFromDic(items, @"isSuccess");
    if ([issuccess isEqualToString:@"1"]) {
        return YES;
    }else{
        int errorCode = [issuccess intValue];
        self.errorMsg = [ErrorAnalyzeUtil getErrorMsg:cmd errorCode:errorCode];
        return NO;
    }
    
}


@end
