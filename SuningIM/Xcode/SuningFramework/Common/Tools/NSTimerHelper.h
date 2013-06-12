//
//  NSTimerHelper.h
//  FatFist
//
//  Created by lyywhg on 12-9-4.
//  Copyright (c) 2012年 FatFist. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSTimerHelper : NSObject
{
    NSTimer *timer_;
}

+ (NSTimerHelper *)scheduledTimerWithTimeInterval:(NSTimeInterval)ti target:(id)aTarget selector:(SEL)aSelector userInfo:(id)userInfo repeats:(BOOL)yesOrNo;

- (void)invalidate;

@end
