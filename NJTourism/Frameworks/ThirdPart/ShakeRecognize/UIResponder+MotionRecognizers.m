//
//  
//  FatFist
//
//  Created by lyywhg on 13-5-24.
//
//

#import "UIResponder+MotionRecognizers.h"

@implementation UIResponder (MotionRecognizers)

- (void) addMotionRecognizerWithAction:(SEL)action {
	[[NSNotificationCenter defaultCenter] addObserver:self selector:action name:@"CPDeviceShaken" object:nil];
}

- (void) removeMotionRecognizer {
	[[NSNotificationCenter defaultCenter] removeObserver:self name:@"CPDeviceShaken" object:nil];
}

@end
