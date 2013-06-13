//
//  NSTimerHelper.h
//  FatFist
//
//  Created by lyywhg on 13-5-24.
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
