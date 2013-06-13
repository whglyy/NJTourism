//
//
//  FatFist
//
//  Created by lyywhg on 13-5-24.
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
