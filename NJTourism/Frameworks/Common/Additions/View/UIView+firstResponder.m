//
//  UIView+firstResponder.m
//  FatFist
//
//  Created by lyywhg on 13-5-24.
//
//

#import "UIView+firstResponder.h"

@implementation UIView (firstResponder)

- (UIView *)findFirstResponder
{
	if ([self isFirstResponder]) {
		return self;
	}
	
	for (UIView *subview in [self subviews]) {
		UIView *firstResponder = [subview findFirstResponder];
		if (nil != firstResponder) {
			return firstResponder;
		}
	}
	
	return nil;
}


@end
