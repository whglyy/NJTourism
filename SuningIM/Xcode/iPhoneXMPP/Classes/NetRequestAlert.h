//
//  NetRequestAlert.h
//  SuningCS
//
//  Created by lyywhg on 12-12-10.
//  Copyright (c) 2012年 suning. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetRequestAlert : NSObject

+ (BOOL)isStringNull:(NSString *)tmpString;
+ (BOOL)isHaveSpace:(NSString *)tmpString;
+ (BOOL)isHaveChinese:(NSString *)tmpString;
+ (BOOL)isAllSameChars:(NSString *)tmpString;
+ (BOOL)hasAllIncreaseChars:(NSString *)tmpString;
+ (BOOL)hasAllDecreaseChars:(NSString *)tmpString;
+ (BOOL)isHaveNum:(NSString *)tmpString;
+ (BOOL)isHaveWord:(NSString *)tmpString;
+ (BOOL)isHaveCharacter:(NSString *)tmpString;
//+ (BOOL)isAllSpaceChars:(NSString *)tmpString;
+ (BOOL)isLengthOverGivenLength:(NSString *)tmpString length:(int)length;
+ (BOOL)isLengthUnderGivenLength:(NSString *)tmpString length:(int)length;
+ (BOOL)isRightUserPassword:(NSString *)tmpString;
+ (BOOL)isFirstIsNumOne:(NSString *)tmpString;
+ (BOOL)isRightPhone:(NSString *)tmpString;
+ (BOOL)isEmail:(NSString *)tmpString;


+ (void)loginAlertView:(int)errorCode;
+ (void)logoutAlertView:(int)errorCode;
+ (void)registAlertView:(int)errorCode;
+ (void)findPasswordsAlertView:(NSString *)errorMsg;
+ (void)resetPasswordsAlertView:(int)errorCode;

+ (void)registCodeAlertView:(int)errorCode;
+ (void)findPasswordsCodeAlertView:(int)errorCode;

@end
