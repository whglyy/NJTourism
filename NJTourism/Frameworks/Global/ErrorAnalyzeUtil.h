//
//  ErrorAnalyzeUtil.h
//  FatFist
//
//  Copyright 2011 FatFish. All rights reserved.
//
//

#import <Foundation/Foundation.h>

@interface ErrorAnalyzeUtil : NSObject

+ (BOOL)isSessionFailed:(NSString *)SNRetCode;

+ (NSString *)getErrorMsg:(E_CMDCODE)cmdCode errorCode:(int)errorCode;

@end
