//
//  LoginService.m
//  SuningPan
//
//  Created by shasha on 13-4-2.
//  Copyright (c) 2013年 suning. All rights reserved.
//

#import "LoginService.h"

@interface LoginService ()
- (void)loginFinished:(BOOL)isSuccess;
@end

@implementation LoginService

- (void)beginLoginRequestWithUserName:(NSString *)userName passWord:(NSString *)password
{
	NSMutableDictionary *postDataDic = [[NSMutableDictionary alloc] init];
    self.uid = userName;
    self.password = password;
	self.user.uid = userName;
    [postDataDic setObject:userName forKey:@"lid"];
    [postDataDic setObject:password forKey:@"pwd"];
    NSString *url = [NSString stringWithFormat:@"%@/%@/%@/%@",
                     kHostAddressForHttp,
                     ActionArea_Login,
                     ActionArea_User
                     ,Action_UserLogin];
	
    [self cancelRequestByCmdCode:CC_UserLogin];
	SNRequest *request = [self POST:url dict:postDataDic];
	request.cmdCode = CC_UserLogin;
}

- (void)loginFinished:(BOOL)isSuccess
{
    if (isSuccess) {
        [[NSNotificationCenter defaultCenter] postNotificationName:LOGIN_OK_NOTIFICATION object:nil userInfo:nil];
    }
	if ([self.delegate conformsToProtocol:@protocol(LoginServiceDelegate) ])
	{
		if ([self.delegate respondsToSelector:@selector(LoginCompletedWithResult:errorMsg:)])
		{
			[self.delegate LoginCompletedWithResult:isSuccess errorMsg:self.errorMsg];
		}
	}
}

- (void)handleRequest:(SNRequest *)request
{
	switch (request.cmdCode)
	{
            
            case CC_UserLogin:
        {
            if (request.failed)
            {
                [self loginFinished:NO];
            }
            else if(request.succeed)
            {
                NSDictionary *dataDic = request.jsonItems;
                NSString *isSuccess = EncodeObjectFromDic(dataDic, @"isRightInfo");
                if ([isSuccess isEqualToString:@"1"])
                {
                    
                    SNBasicBlock backBlock = ^{
                        [self parseDataFromDic:dataDic];
                    };
                    PERFORMSEL_BACK(backBlock);
                    }
                else{
                    self.errorCode = EncodeObjectFromDic(dataDic, @"errorCode");
                    if ([self.errorCode isEqualToString:@"2001"] || [self.errorCode isEqualToString:@"2010"] || [self.errorCode isEqualToString:@"2000"] || [self.errorCode isEqualToString:@"2020"] || [self.errorCode isEqualToString:@"2030"] || [self.errorCode isEqualToString:@"5350"] || [self.errorCode isEqualToString:@"7001"])
                    {
                        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"错误" message:@"您输入的账号或密码有误，请重新输入！" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                        [alert show];
                    }
                    else if ([self.errorCode isEqualToString:@"2031"])
                    {
                        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"错误" message:@"系统正忙，请稍后登陆！" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                        [alert show];
                    }
                    else if ([self.errorCode isEqualToString:@"2100"])
                    {
                        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"错误" message:@"您进行了多次错误密码尝试，将无法登陆，请与易购客服联系解锁您的账户！" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                        [alert show];
                    }
                    else if (self.errorCode == nil)
                    {
                        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"错误" message:@"服务器发生异常，请您稍后再试！" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                        [alert show];
                    }
                    [self loginFinished:NO];

            }
        }
        }
                
        break;
        default:
        break;

    }
}


- (void)parseDataFromDic:(NSDictionary *)dataDic{
    UserInfoDTO *userInfo = [[UserInfoDTO alloc] init];
    [userInfo encodeFromDictionary:dataDic];
    [UserCenter defaultCenter].userInfoDTO = userInfo;
    SNBasicBlock mainBlock = ^{
        [self loginFinished:YES];
    };
    PERFORMSEL_MAIN(mainBlock);
}
@end
