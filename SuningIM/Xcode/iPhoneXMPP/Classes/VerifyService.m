//
//  VerifyService.m
//  SuningIM
//
//  Created by wangbao on 13-6-3.
//
//

#import "VerifyService.h"
#import "ContactDTO.h"

@implementation VerifyService

- (void)getVerifyRequestWithPhoneNo:(NSString *)phoneNo JID:(NSString *)jid
{
	NSMutableDictionary *postDataDic = [[NSMutableDictionary alloc] init];
    //    self.phoneNo = phoneNo;
    //    self.jid = jid;
    
    [postDataDic setObject:phoneNo forKey:@"phoneNo"];
    [postDataDic setObject:jid forKey:@"jid"];
    
    NSString *url = @"http://imapp.suning.com/mobile/android/requireBinding.do";
    //    url = [NSString stringWithFormat:@"%@/%@/%@",
    //               kHostAddressForHttp,
    //               ActionArea_Login,ActionArea_SimpleLogin];
    
	SNRequest *request = [self GET:url params:postDataDic];
	request.cmdCode = CC_GetVerCode;
}

- (void)getVerifyFinished:(BOOL)isSuccess
{
	if ([self.delegate conformsToProtocol:@protocol(VerifyServiceDelegate) ])
	{
		if ([self.delegate respondsToSelector:@selector(getVerifyCompletedWithResult:Service:)])
		{
			[self.delegate getVerifyCompletedWithResult:isSuccess Service:self];
		}
	}
}

- (void)beginVerifyRequestWithVerifyCode:(NSString *)verifyCode JID:(NSString *)jid Password:(NSString *)password
{
	NSMutableDictionary *postDataDic = [[NSMutableDictionary alloc] init];
    jid = [UserCenter defaultCenter].userInfoDTO.jid;
    password = [UserCenter defaultCenter].userInfoDTO.pwd;
    
    [postDataDic setObject:verifyCode forKey:@"verifyCode"];
    [postDataDic setObject:jid forKey:@"jid"];
    [postDataDic setObject:password forKey:@"pwd"];
    
    NSString *url = [NSString stringWithFormat:@"%@/%@/%@",
               kHostAddressForHttp,ActionArea_mobile,Action_BeginVerify];
    
	SNRequest *request = [self POST:url dict:postDataDic];
	request.cmdCode = CC_BeginVerify;
}

- (void)verifyFinished:(BOOL)isSuccess
{
	if ([self.delegate conformsToProtocol:@protocol(VerifyServiceDelegate) ])
	{
		if ([self.delegate respondsToSelector:@selector(VerifyCompletedWithResult:Service:)])
		{
			[self.delegate VerifyCompletedWithResult:isSuccess Service:self];
		}
	}
}

- (void)readRequestWithPhoneNos:(NSArray *)phoneNos
{
	NSMutableDictionary *postDataDic = [[NSMutableDictionary alloc] init];
    
    NSMutableArray *tempArr = [[NSMutableArray alloc] init];
    
    self.recordArray = phoneNos;
    
    for (ContactDTO *dto in phoneNos) {
        
        NSString *phoneNumStr = IsNilOrNull(dto.phoneNum)?@"":dto.phoneNum;
        
        NSDictionary *dic = [NSDictionary dictionaryWithObject:phoneNumStr forKey:@"phoneNo"];
        
        [tempArr addObject:dic];
    }
    
    NSDictionary *jsonDic = [NSDictionary dictionaryWithObject:tempArr forKey:@"phoneNos"];
    
    NSString *jsonStr  = [jsonDic JSONString];
    
    [postDataDic setObject:jsonStr forKey:@"phoneNos"];
    
    NSString *url = [NSString stringWithFormat:@"%@/%@/%@",
                     kHostAddressForHttp,ActionArea_mobile,Action_ReadPhone];
    
	SNRequest *request = [self POST:url dict:postDataDic];
    
	request.cmdCode = CC_ReadPhone;
}

- (void)readphoneFinished:(BOOL)isSuccess
{
	if ([self.delegate conformsToProtocol:@protocol(VerifyServiceDelegate) ])
	{
		if ([self.delegate respondsToSelector:@selector(ReadPhoneCompletedWithResult:Service:)])
		{
			[self.delegate ReadPhoneCompletedWithResult:isSuccess Service:self];
		}
	}
}

- (void)stopVerifyRequestWithJID:(NSString *)jid
{
	NSMutableDictionary *postDataDic = [[NSMutableDictionary alloc] init];
    jid = [UserCenter defaultCenter].userInfoDTO.jid;;
    
    [postDataDic setObject:jid forKey:@"jid"];
    
    NSString *url = [NSString stringWithFormat:@"%@/%@/%@",
                     kHostAddressForHttp,ActionArea_mobile,Action_StopVerify];
	SNRequest *request = [self GET:url params:postDataDic];
	request.cmdCode = CC_StopVerify;
}

- (void)stopverifyFinished:(BOOL)isSuccess
{
	if ([self.delegate conformsToProtocol:@protocol(VerifyServiceDelegate) ])
	{
		if ([self.delegate respondsToSelector:@selector(StopVerifyCompletedWithResult:Service:)])
		{
			[self.delegate StopVerifyCompletedWithResult:isSuccess Service:self];
		}
	}
}

- (void)handleRequest:(SNRequest *)request
{
    if (request.succeed) {
        switch (request.cmdCode)
        {
            case CC_BeginVerify : {
                NSDictionary *dataDic = request.jsonItems;
                NSString *isSuccess = EncodeObjectFromDic(dataDic, @"isSuccess");
                if ([isSuccess isEqualToString:@"1"])
                {
                    [self verifyFinished:YES];
                }
                else if ([isSuccess isEqualToString:@"0"])
                {
                    self.errorMsg = @"参数出错";
                }
                else if ([isSuccess isEqualToString:@"2"])
                    
                {
                    self.errorMsg = @"用户密码错误";
                }
                else if ([isSuccess isEqualToString:@"3"])
                {
                    self.errorMsg = @"验证码错误";
                }
                else if ([isSuccess isEqualToString:@"4"])
                {
                    self.errorMsg = @"系统异常";
                }
                [self verifyFinished:NO];
                
            }
            case CC_StopVerify : {
                
                NSDictionary *dataDic = request.jsonItems;
                NSString *isSuccess = EncodeObjectFromDic(dataDic, @"isSuccess");
                if ([isSuccess isEqualToString:@"1"])
                {
                    
                    [self stopverifyFinished:YES];
                }
                else if ([isSuccess isEqualToString:@"0"])
                {
                    self.errorMsg = @"error";
                }
                [self stopverifyFinished:NO];
                
            }
            case CC_ReadPhone : {
                
                NSDictionary *dataDic = request.jsonItems;
                NSString *isSuccess = EncodeObjectFromDic(dataDic, @"isSuccess");
                if ([isSuccess isEqualToString:@"1"])
                {
                    [self parsePhoneContact:dataDic];
                    [self readphoneFinished:YES];
                }
                else if ([isSuccess isEqualToString:@"0"])
                {
                    self.errorMsg = @"error";
                    [self readphoneFinished:NO];

                }
            }
            case CC_GetVerCode:{
                
                BOOL issuccess = [self isResponseSuccess:request.jsonItems
                                             withCMDCode:request.cmdCode];
                
                [self getVerifyFinished:issuccess];
            }
                break;
            default :
                break;
        }
    }else if(request.failed){
    
    }else{
    
    }
    
	
}

- (void)parsePhoneContact:(NSDictionary *)dic{
    
    NSArray *tempArr = [dic objectForKey:@"userStatus"];
    
    for (int i = 0; i < [tempArr count];i ++)
    {
        NSDictionary *dic = [tempArr objectAtIndex:i];
        
        ContactDTO *dto = [self.recordArray objectAtIndex:i];
        
        NSString *jid = EncodeObjectFromDic(dic, @"jid");
        
        dto.jid = jid;
    }
}



@end
