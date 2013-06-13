//
//  UIView+Appear.m
//  FatFist
//
//  Created by lyywhg on 13-5-24.
//
//

#import "UIView+Appear.h"

#define kSTARTING_SCALE 0.3f
#define kEND_SCALE 1.0f
#define kDURATION 0.4f

@interface UIView (Private)

@end


@implementation UIView (Appear)


- (void)appear {
	[self setTransform: CGAffineTransformMakeScale(kSTARTING_SCALE, kSTARTING_SCALE)];
	[UIView beginAnimations: nil context: nil];
	[UIView setAnimationDuration: kDURATION];
	[self setTransform: CGAffineTransformMakeScale(kEND_SCALE, kEND_SCALE)];
	[UIView commitAnimations];
}

-(void)disappearWithCallback:(SEL)aSelector {
	[self setTransform: CGAffineTransformMakeScale(kEND_SCALE, kEND_SCALE)];
	[UIView beginAnimations: nil context: nil];
	[UIView setAnimationDuration: kDURATION];
	[UIView setAnimationDelegate: self] ;
	[UIView setAnimationDidStopSelector: aSelector] ;
	[self setTransform: CGAffineTransformMakeScale(0.001, 0.001)];
	[UIView commitAnimations];
}
	

@end