//
//  UIView+firstResponder.m
//  FatFist
//
//  Copyright 2011 FatFish. All rights reserved.
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
