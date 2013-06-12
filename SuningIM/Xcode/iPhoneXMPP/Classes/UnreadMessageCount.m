//
//  UnreadMessageCount.m
//  SuningIM
//
//  Created by lyywhg on 13-5-27.
//
//

#import "UnreadMessageCount.h"

@implementation UnreadMessageCount

+ (NSString *)displayUnreadMessage:(NSInteger )unreadMessage
{
    if (unreadMessage == 0)
    {
        return @"0";
    }
    else if (unreadMessage < 100)
    {
        return [NSString stringWithFormat:@"%d", unreadMessage];
    }
    else
    {
        return @"99+";
    }
    return @"0";
}

@end
