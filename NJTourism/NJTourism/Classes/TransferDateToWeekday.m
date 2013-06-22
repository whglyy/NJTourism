//
//  TransferDateToWeekday.m
//  NJTourism
//
//  Created by lyywhg on 13-6-22.
//
//

#import "TransferDateToWeekday.h"

@implementation TransferDateToWeekday

+ (NSString *)getLocalTodayDate
{
    NSDate *todayDate = [NSDate date];
    NSDateFormatter *todayDateFormatter = [[NSDateFormatter alloc] init];
    [todayDateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *todayDataString = [todayDateFormatter stringFromDate:todayDate];
    return todayDataString;
}

//对星期进行数据解析翻译
+ (NSString *)getWeek:(NSString *)date
{
    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
    [inputFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *formatterDate = [inputFormatter dateFromString:date];
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setDateFormat:@"EEEE"];
    NSString *newDateString = [outputFormatter stringFromDate:formatterDate];
    //    NSLog(@"%@",newDateString);
    if ([newDateString isEqualToString:@"Monday"])
    {
        return L(@"星期一");
    }
    else if([newDateString isEqualToString:@"Tuesday"])
    {
        return L(@"星期二");
    }
    else if([newDateString isEqualToString:@"Wednesday"])
    {
        return L(@"星期三");
    }
    else if([newDateString isEqualToString:@"Thursday"])
    {
        return L(@"星期四");
    }
    else if([newDateString isEqualToString:@"Friday"])
    {
        return L(@"星期五");
    }
    else if([newDateString isEqualToString:@"Saturday"])
    {
        return L(@"星期六");
    }
    else if([newDateString isEqualToString:@"Sunday"])
    {
        return L(@"星期日");
    }
    else
    {
        return newDateString;
    }
}


@end
