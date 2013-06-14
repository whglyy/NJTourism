//
//  TimerCal.m
//  FatFist
//
//  Copyright 2011 FatFish. All rights reserved.
//
//

#import "TimerCal.h"

@implementation TimerCal

+ (NSString *)TimerString:(float)fTimer
{
    int iHour = fTimer / 3600;
    float fMinute = fTimer - (iHour * 3600);
    int iMinute = fMinute / 60;
    int iSecond = fMinute - (iMinute * 60);
    
    if (iHour != 0)
    {
        return [NSString stringWithFormat:@"%.2d:%.2d:%.2d", iHour, iMinute, iSecond];
    }
    else
    {
        return [NSString stringWithFormat:@"%.2d:%.2d", iMinute, iSecond];
    }
    return nil;
}

@end
