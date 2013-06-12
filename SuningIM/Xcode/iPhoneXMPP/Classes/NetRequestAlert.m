//
//  NetRequestAlert.m
//  SuningCS
//
//  Created by lyywhg on 12-12-10.
//  Copyright (c) 2012年 suning. All rights reserved.
//

#import "NetRequestAlert.h"
#import "RegexKitLite.h"

@implementation NetRequestAlert

#pragma mark-
#pragma mark Init & Dealloc


#pragma mark-
#pragma mark TextField Content
//是否为空
+ (BOOL)isStringNull:(NSString *)tmpString
{
    BOOL bFlag = ( (tmpString == nil) || ([tmpString isEqualToString:@""]) );
    return  bFlag;
}
//有空格
+ (BOOL)isHaveSpace:(NSString *)tmpString
{
    BOOL bFlag = [tmpString isMatchedByRegex:@"[\\s]+"];
    return  bFlag;
}
//有中文
+ (BOOL)isHaveChinese:(NSString *)tmpString
{
    BOOL bFlag = [tmpString isMatchedByRegex:@"[\u2E80-\u9FFF]+"];
    return  bFlag;
}
//连续相同字符
+ (BOOL)isAllSameChars:(NSString *)tmpString
{
    unichar fir = [tmpString characterAtIndex:0];
    for (int i = 1; i < tmpString.length; i++)
    {
        unichar c = [tmpString characterAtIndex:i];
        if (c != fir)
        {
            return NO;
        }
    }
    return YES;
}
//联系递增字符
+ (BOOL)hasAllIncreaseChars:(NSString *)tmpString
{
    int l = tmpString.length;
    unichar top = [tmpString characterAtIndex:0];
    int j = 1;
    for (int i = 1; i < tmpString.length; i++)
    {
        unichar c = [tmpString characterAtIndex:i];
        if (c == top+1)
        {
            j++;
        }
        else
        {
            j = 1;
        }
        top = c;
    }
    
    if (j >= l)
    {
        return YES;
    }
    else
    {
        return NO;
    }
}
//连续递减字符
+ (BOOL)hasAllDecreaseChars:(NSString *)tmpString
{
    int l = tmpString.length;
    unichar top = [tmpString characterAtIndex:0];
    int j = 1;
    for (int i = 1; i < tmpString.length; i++)
    {
        unichar c = [tmpString characterAtIndex:i];
        if (c == top-1)
        {
            j++;
        }
        else
        {
            j = 1;
        }
        top = c;
    }
    
    if (j >= l) {
        return YES;
    }else{
        return NO;
    }
}
//有数字
+ (BOOL)isHaveNum:(NSString *)tmpString
{
    BOOL bFlag = [tmpString isMatchedByRegex:@"[\\d]+"];
    return  bFlag;
}
//有字母
+ (BOOL)isHaveWord:(NSString *)tmpString
{
    BOOL bFlag = [tmpString isMatchedByRegex:@"[A-Za-z]+"];
    return  bFlag;
}
//有特殊符号
+ (BOOL)isHaveCharacter:(NSString *)tmpString
{
    BOOL bFlag = [tmpString isMatchedByRegex:@"[:`'-,;.!@#$%^&*(){}+?></]+"];
    return  bFlag;
}
//长度超过
+ (BOOL)isLengthOverGivenLength:(NSString *)tmpString length:(int)length
{
    BOOL bFlag = ([tmpString length] > length);
    return  bFlag;
}
//长度小于
+ (BOOL)isLengthUnderGivenLength:(NSString *)tmpString length:(int)length
{
    BOOL bFlag = ([tmpString length] < length);
    return  bFlag;
}
#pragma UserName
//判断是否是几种组合
+ (BOOL)isRightUserPassword:(NSString *)tmpString
{
    int num = 0;
    
    if ([NetRequestAlert isHaveWord:tmpString])
    {
        num = num + 1;
    }
    if ([NetRequestAlert isHaveNum:tmpString])
    {
        num = num + 1;
    }
    if ([NetRequestAlert isHaveCharacter:tmpString])
    {
        num = num + 1;
    }
    
    return  (num > 1);
}
//第一个是否为数字1
+ (BOOL)isFirstIsNumOne:(NSString *)tmpString
{    
    BOOL bFlag = [[tmpString substringWithRange:NSMakeRange(0, 1)] isEqualToString:@"1"];
    return  bFlag;
}
//手机号码
+ (BOOL)isRightPhone:(NSString *)tmpString
{
    BOOL bFlag = ( [tmpString isMatchedByRegex:@"1[0-9]{10}"] && [NetRequestAlert isLengthUnderGivenLength:tmpString length:12] );
    return  bFlag;
}
//邮箱
+ (BOOL)isEmail:(NSString *)tmpString
{
    BOOL bFlag = [tmpString isMatchedByRegex:@"\\b([a-zA-Z0-9%_.+\\-]+)@([a-zA-Z0-9.\\-]+?\\.[a-zA-Z]{2,6})\\b"];
    return  bFlag;
}
#pragma UserPassword
#pragma mark Net AlertView
+ (void)loginAlertView:(int)errorCode
{
    DLog(@"msg_lyy:errorCode %d", errorCode);
    NSString *tmpString;
    switch (errorCode)
    {
        case 2000:
        case 2001:
        case 2010:
            tmpString = L(@"Error User Name");
            break;
        case 2002:
            tmpString = L(@"First Login");
            break;
        case 2110:
            tmpString = L(@"Login Lock");
            break;
        case 2020:
        case 2030:
            tmpString = L(@"Error Password");
            break;
        case 2300:
            tmpString = L(@"Login for waiting");
            break;
        case 2400:
            tmpString = L(@"Group Lock");
            break;
        case 2420:
            tmpString = L(@"Verify Your Register");
            break;
        case 5350:
            tmpString = L(@"Error Login, Please Use Other Way");
            break;
        case 12050:
        case 5310:
            tmpString = L(@"Network Request Error");
            break;
        default:
            tmpString = L(@"Please Try later");
            break;
    }
    
    BBTipView *tipView = [[BBTipView alloc] initWithView:[AppDelegate currentAppDelegate].window message:tmpString posY:30];
    [tipView show];
    TT_RELEASE_SAFELY(tipView);
}

+ (void)registAlertView:(int)errorCode
{
    DLog(@"msg_lyy:errorCode %d", errorCode);
    NSString *tmpString;
    switch (errorCode)
    {
        case 1001:
            tmpString = L(@"Phone Have Been Registed or Used");
            break;
        case 1005:
            tmpString = L(@"Error Phone Number");
            break;
        case 2030:
        case 2031:
            tmpString = L(@"Phone & Email Have Been Registed");
            break;
        case 2080:
            tmpString = L(@"Passwords do not match");
            break;
        case 2200:
            tmpString = L(@"Passwords Not Match");
            break;
        case 101011:
        case 101012:
            tmpString = L(@"Error VerificationCode");
            break;
        case 9050:
            tmpString = L(@"User Have Been Logined");
            break;
        case 12050:
            tmpString = L(@"Network Request Error");
            break;
        default:
            tmpString = L(@"Please Try later");
            break;
    }
    
    BBTipView *tipView = [[BBTipView alloc] initWithView:[AppDelegate currentAppDelegate].window message:tmpString posY:30];
    [tipView show];
    TT_RELEASE_SAFELY(tipView);
}

+ (void)findPasswordsAlertView:(NSString *)errorMsg
{
    DLog(@"msg_lyy:errorMsg %@", errorMsg);
    BBTipView *tipView = [[BBTipView alloc] initWithView:[AppDelegate currentAppDelegate].window message:errorMsg posY:30];
    [tipView show];
    TT_RELEASE_SAFELY(tipView);
}

//以下3个函数没有详细的errorCode解析
+ (void)logoutAlertView:(int)errorCode
{
    DLog(@"msg_lyy:errorCode %d", errorCode);
    NSString *tmpString = L(@"Network Request Error");
    BBTipView *tipView = [[BBTipView alloc] initWithView:[AppDelegate currentAppDelegate].window message:tmpString posY:30];
    [tipView show];
    TT_RELEASE_SAFELY(tipView);
}

+ (void)resetPasswordsAlertView:(int)errorCode
{
    DLog(@"msg_lyy:errorCode %d", errorCode);
    NSString *tmpString = L(@"Network Request Error");
    BBTipView *tipView = [[BBTipView alloc] initWithView:[AppDelegate currentAppDelegate].window message:tmpString posY:30];
    [tipView show];
    TT_RELEASE_SAFELY(tipView);
}

+ (void)registCodeAlertView:(int)errorCode
{
    DLog(@"msg_lyy:errorCode %d", errorCode);
    NSString *tmpString = L(@"Network Request Error");
    BBTipView *tipView = [[BBTipView alloc] initWithView:[AppDelegate currentAppDelegate].window message:tmpString posY:30];
    [tipView show];
    TT_RELEASE_SAFELY(tipView);
}

+ (void)findPasswordsCodeAlertView:(int)errorCode
{
    DLog(@"msg_lyy:errorCode %d", errorCode);
    NSString *tmpString = L(@"Network Request Error");
    BBTipView *tipView = [[BBTipView alloc] initWithView:[AppDelegate currentAppDelegate].window message:tmpString posY:30];
    [tipView show];
    TT_RELEASE_SAFELY(tipView);
}

@end
