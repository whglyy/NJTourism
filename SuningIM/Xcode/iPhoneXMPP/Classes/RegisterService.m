//
//  RegisterService.m
//  SuningPan
//
//  Created by wangman on 13-4-26.
//  Copyright (c) 2013年 suning. All rights reserved.
//

#import "RegisterService.h"
#import "PasswordVerifyUtil.h"
@interface RegisterService()
- (void)Finished:(BOOL)isSuccess;
@end

@implementation RegisterService

- (void)beginRegisterRequest:(NSString *)userId password:(NSString *)password passwordVerify:(NSString *)passwordVerify smsCheck:(NSString *)smsCheck regType:(NSString *)regType{
    NSMutableDictionary *postDataDic = [[NSMutableDictionary alloc] init];
    [postDataDic setObject:userId forKey:@"uid"];
    [postDataDic setObject:password  forKey:@"pwd"];
    [postDataDic setObject:passwordVerify  forKey:@"pwdVerify"];
    [postDataDic setObject:smsCheck  forKey:@"smsCheck"];
    [postDataDic setObject:regType  forKey:@"regType"];
    NSString *url = @"http://sitappserver.cnsuning.com/loginAuth/user/register.do";
    [self cancelRequestByCmdCode:CC_Register];
    SNRequest *request =[SNRequestQueue POST:url params:postDataDic];
    request.cmdCode = CC_Register;
}
- (void)beginVerCodeRequest:(NSString *)userId phoneNum:(NSString *)phoneNum
{
    NSMutableDictionary *postDataDic = [[NSMutableDictionary alloc] init];
    [postDataDic setObject:userId forKey:@"uid"];
    [postDataDic setObject:phoneNum  forKey:@"phoneNum"];
    NSString *url = @"http://sitappserver.cnsuning.com/loginAuth/VerifyCodeServlet";

    [self cancelRequestByCmdCode:CC_VerCode];
    SNRequest *request =[self POST:url dict:postDataDic];
    request.cmdCode = CC_VerCode;
}
- (void)Finished:(BOOL)isSuccess
{
    if ([self.delegate conformsToProtocol:@protocol(RegisterServiceDelegate) ])
    {
        
        if ([self.delegate respondsToSelector:@selector(registerCompletedWithResult:errorMsg:)])
        {
            [self.delegate registerCompletedWithResult:isSuccess errorMsg:self.errorMsg];
        }
    }
}

- (void)handleRequest:(SNRequest *)request{
    switch (request.cmdCode)
    {
        case CC_Register:
        {
            if (request.failed)
            {
                self.errorMsg = [self  errorMsgOfRequestError:request.error];
                [self Finished:NO];
            }
            else if(request.succeed)
            {
                BOOL isSuccess = [self isResponseSuccess:request.jsonItems withCMDCode:request.cmdCode];
                 NSDictionary *dataDic = [self dataInfoOfResponse:request.jsonItems];
                if (isSuccess)
                {
                    if ([[dataDic objectForKey:@"result"] isEqualToString:@"1"])
                    {
                        self.errorMsg = [dataDic objectForKey:@"msg"];
                        [self Finished:NO];
                    }
                    else
                    {
                        [self Finished:YES];
                    }
                }
                else
                {
                    [self Finished:NO];
                }
                
            }
        }
            break;
        case CC_VerCode:
        {
            if (request.failed)
            {
                self.errorMsg = [self  errorMsgOfRequestError:request.error];
                [self VFinished:NO];
            }else if(request.succeed){
                BOOL isSuccess = [self isResponseSuccess:request.jsonItems withCMDCode:request.cmdCode];
                 NSDictionary *dataDic = [self dataInfoOfResponse:request.jsonItems];
                if (isSuccess)
                {
                    if ([[dataDic objectForKey:@"result"] isEqualToString:@"1"])
                    {
                        self.errorMsg = [dataDic objectForKey:@"msg"];
                        [self VFinished:NO];
                    }
                    else
                    {
                        [self VFinished:YES];
                    }
                }
                else
                {
                    [self VFinished:NO];
                }
            }
        }
            break;
        default:
            break;
    }
}
- (void)VFinished:(BOOL)isSuccess
{
    if ([self.delegate conformsToProtocol:@protocol(RegisterServiceDelegate) ])
    {
        if ([self.delegate respondsToSelector:@selector(getVerCodeCompletedWithResult:errorMsg:)])
        {
            [self.delegate getVerCodeCompletedWithResult:isSuccess errorMsg:self.errorMsg];
        }
    }
}

@end
