//
//  ErrorAnalyzeUtil.h
//  FatFist
//
//  Created by lyywhg on 13-5-24.
//
//

#import <Foundation/Foundation.h>

@interface ErrorAnalyzeUtil : NSObject

+ (BOOL)isSessionFailed:(NSString *)SNRetCode;

+ (NSString *)getErrorMsg:(E_CMDCODE)cmdCode errorCode:(int)errorCode;

@end
