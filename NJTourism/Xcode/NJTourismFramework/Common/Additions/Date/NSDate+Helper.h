//
//  NSDate+Helper.h
//  FatFist
//
//  Created by lyywhg on 12-8-30.
//  Copyright (c) 2012年 FatFist. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Helper)

/*tools*/

+ (NSDate *)dateFromString:(NSString *)string withFormat:(NSString *)formatString;

+ (NSString *)stringFromDate:(NSDate *)date withFormat:(NSString *)formatString;


@end
