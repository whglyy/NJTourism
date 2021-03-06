//
//  NSTimerHelper.m
//  FatFist
//
//  Copyright 2011 FatFish. All rights reserved.
//
//
#import "NSTimerHelper.h"
@interface NSTimerHelper()
{
    id __weak delegate_;
    SEL action_;
}
@property (nonatomic, retain) NSTimer *timer;
@property (nonatomic, assign) id delegate;
@property (nonatomic, assign) SEL action;
@end
/*********************************************************************/
@implementation NSTimerHelper
@synthesize timer = timer_;
- (void)dealloc {
    [self invalidate];
   
}
+ (NSTimerHelper *)scheduledTimerWithTimeInterval:(NSTimeInterval)ti target:(id)aTarget selector:(SEL)aSelector userInfo:(id)userInfo repeats:(BOOL)yesOrNo
{
    NSTimerHelper *helper = [[NSTimerHelper alloc] init];
    
    [helper invalidate];
    
    helper.delegate = aTarget;
    helper.action = aSelector;
    
    helper.timer = [NSTimer scheduledTimerWithTimeInterval:ti target:helper selector:@selector(doSomething) userInfo:userInfo repeats:yesOrNo];
    
    return helper ;
}
- (void)invalidate
{
    [timer_ invalidate];
    timer_ = nil;
}
- (void)doSomething
{
    if (self.delegate && [self.delegate respondsToSelector:self.action]) {
        [self.delegate performSelector:self.action];
    }
}
@end
