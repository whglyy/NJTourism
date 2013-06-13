//
//  NSDate+Helper.h
//  FatFist
//
//  Created by lyywhg on 13-5-24.
//
//

#import <Foundation/Foundation.h>

@interface NSDate (Helper)

/*tools*/

+ (NSDate *)dateFromString:(NSString *)string withFormat:(NSString *)formatString;

+ (NSString *)stringFromDate:(NSDate *)date withFormat:(NSString *)formatString;


@end
