//
//  PasswordVerifyUtil.m
//  SuningEBuy
//
//  Created by  liukun on 13-1-7.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "PasswordVerifyUtil.h"
#import "RegexKitLite.h"

@interface PasswordVerifyUtil()

//是否全是相同的字符
+ (BOOL)isAllSameChars:(NSString *)password;

//是否是连续递增的字符
+ (BOOL)hasAllIncreaseChars:(NSString *)password;

//是否是连续递减的字符
+ (BOOL)hasAllDecreaseChars:(NSString *)password;

//是否为纯数字
+ (BOOL)isAllNum:(NSString *)password;

//是否为纯字母
+ (BOOL)isAllLetter:(NSString *)password;

//是否为纯字符
+ (BOOL)isAllSymbol:(NSString *)password;

//是否含有非法字符
+ (BOOL)hasIllegalSymbol:(NSString *)password;

@end

/*********************************************************************/

@implementation PasswordVerifyUtil

+ (BOOL)verifyRegistePassword:(NSString *)password error:(NSString **)errorMsg
{
    //检查字符位数
    if (password == nil || password.length < 6 || password.length > 20) {
        *errorMsg = @"请输入6-20位密码！";
        return NO;
    }
    
    //检查是否为相同字符
    if ([self isAllSameChars:password]) {
        *errorMsg = @"密码不能为同一字符！";
        return NO;
    }
    
    //检查是否为连续字符
    if ([self hasAllIncreaseChars:password] || [self hasAllDecreaseChars:password]) {
        *errorMsg = @"密码不能输入连续字符！";
        return NO;
    }
    
    //检查是否为纯数字、字母、或符号
    if ([self isAllNum:password] || [self isAllLetter:password] || [self isAllSymbol:password])
    {
        *errorMsg = @"密码不能为纯粹的数字，字母或者符号！";
        return NO;
    }
    
    //是否有非法字符
    if ([self hasIllegalSymbol:password]) {
        *errorMsg = @"密码只能由英文、数字以及符号组成！";
        return NO;
    }
    
    return YES;
}

+ (BOOL)isAllSameChars:(NSString *)password
{
    unichar fir = [password characterAtIndex:0];
    for (int i = 1; i < password.length; i++) {
        unichar c = [password characterAtIndex:i];
        if (c != fir) {
            return NO;
        }
    }
    return YES;
}

+ (BOOL)hasAllIncreaseChars:(NSString *)password
{
    int l = password.length;
    unichar top = [password characterAtIndex:0];
    int j = 1;
    for (int i = 1; i < password.length; i++) {
        unichar c = [password characterAtIndex:i];
        if (c == top+1) {
            j++;
        }else{
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

+ (BOOL)hasAllDecreaseChars:(NSString *)password
{
    int l = password.length;
    unichar top = [password characterAtIndex:0];
    int j = 1;
    for (int i = 1; i < password.length; i++) {
        unichar c = [password characterAtIndex:i];
        if (c == top-1) {
            j++;
        }else{
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

+ (BOOL)isAllNum:(NSString *)password
{
    NSString *regex = @"^\\d+$";
    if ([password isMatchedByRegex:regex]) {
        return YES;
    }
    return NO;
}

+ (BOOL)isAllLetter:(NSString *)password
{
    NSString *regex = @"^[a-zA-Z]+$";
    if ([password isMatchedByRegex:regex]) {
        return YES;
    }
    return NO;
}

+ (BOOL)isAllSymbol:(NSString *)password
{
    NSString *regex = @"^[^0-9a-zA-Z\\s<>;'\\\\]+$";
    if ([password isMatchedByRegex:regex]) {
        return YES;
    }
    return NO;
}

+ (BOOL)hasIllegalSymbol:(NSString *)password
{
    NSString *regex = @"[\\s<>;'\\\\]";
    if ([password isMatchedByRegex:regex]) {
        return YES;
    }
    return NO;
}

@end
