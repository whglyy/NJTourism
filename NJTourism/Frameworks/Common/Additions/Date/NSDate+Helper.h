//
//  NSDate+Helper.h
//  FatFist
//
//  Copyright 2011 FatFish. All rights reserved.
//
//
#import <Foundation/Foundation.h>
@interface NSDate (Helper)
/*tools*/
+ (NSDate *)dateFromString:(NSString *)string withFormat:(NSString *)formatString;
+ (NSString *)stringFromDate:(NSDate *)date withFormat:(NSString *)formatString;

@end
