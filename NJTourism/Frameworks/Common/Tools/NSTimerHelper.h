//
//  NSTimerHelper.h
//  FatFist
//
//  Copyright 2011 FatFish. All rights reserved.
//
//

#import <Foundation/Foundation.h>

@interface NSTimerHelper : NSObject
{
    NSTimer *timer_;
}

+ (NSTimerHelper *)scheduledTimerWithTimeInterval:(NSTimeInterval)ti target:(id)aTarget selector:(SEL)aSelector userInfo:(id)userInfo repeats:(BOOL)yesOrNo;

- (void)invalidate;

@end
