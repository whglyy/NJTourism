//
//  RegulateChatRecordsTime.m
//  SuningIM
//
//  Created by lyywhg on 13-5-24.
//
//

#import "RegulateChatRecordsTime.h"

@implementation RegulateChatRecordsTime

- (NSString *)regulateChatRecordsTime:(NSDate *)chatRecordsTime
{
    return nil;
}

//获取到东八区的当前时间
- (NSDate *)getCurrentChineseTime
{
    NSDate *sysDate = [NSDate date];
    NSTimeZone *ChinaZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    NSInteger timeInterval = [ChinaZone secondsFromGMTForDate:sysDate];
    return [sysDate dateByAddingTimeInterval:timeInterval];
}

/*
 时间间隔为210s内就不在
 若发生在当天则只显示小时和分钟；
 若发生在前一天则提示“昨天/小时/分钟”；
 若发生在昨天以前则提示“月/日/小时/分钟”;
 若会话发生在上一个年份则提示“年/月/日/小时/分钟”；
 */

//CompareTimes
- (int)compareTimes:(NSDate *)currentTime earlierTime:(NSDate *)earlierTimer
{
    return 0;
}

- (NSString *)getYear:(NSDate *)date
{
    return nil;
}
- (NSString *)getDay:(NSDate *)date
{
    return nil;
}
- (BOOL)isIntervalDayOver1Day:(NSDate *)currentTime earlierTime:(NSDate *)earlierTime
{
    return NO;
}
- (BOOL)isInterval210s:(NSDate *)currentTime earlierTime:(NSDate *)earlierTime
{
    return NO;
}



@end
