//
//  ErrorAnalyzeUtil.h
//  SuningPan
//
//  Created by shasha on 13-5-12.
//  Copyright (c) 2013年 suning. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ErrorAnalyzeUtil : NSObject

+ (BOOL)isSessionFailed:(NSString *)SNRetCode;

+ (NSString *)getErrorMsg:(E_CMDCODE)cmdCode errorCode:(int)errorCode;

@end
