//
//
//  FatFist
//
//  Copyright 2011 FatFish. All rights reserved.
//
//
#import "CPMotionRecognizingWindow.h"
@implementation CPMotionRecognizingWindow
- (void) motionEnded:(UIEventSubtype)motion withEvent:(UIEvent*)event {
	if (event.type == UIEventTypeMotion && event.subtype == UIEventSubtypeMotionShake) {
		[[NSNotificationCenter defaultCenter] postNotificationName:@"CPDeviceShaken" object:self];
	}
}
@end
