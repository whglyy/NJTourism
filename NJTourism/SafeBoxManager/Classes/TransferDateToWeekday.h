//
//  TransferDateToWeekday.h
//  NJTourism
//
//  Created by lyywhg on 13-6-22.
//
//

#import <Foundation/Foundation.h>

@interface TransferDateToWeekday : NSObject

+ (NSString *)getLocalTodayDate;
+ (NSString *)getWeek:(NSString *)date;

@end
