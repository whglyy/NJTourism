//
//
//  FatFist
//
//  Copyright 2011 FatFish. All rights reserved.
//
//

#import "RevealController.h"

#import "RearViewController.h"

@implementation RevealController

#pragma mark - Initialization

- (id)initWithFrontViewController:(UIViewController *)aFrontViewController rearViewController:(UIViewController *)aBackViewController
{
	self = [super initWithFrontViewController:aFrontViewController rearViewController:aBackViewController];
	
	if (nil != self)
	{
		self.delegate = self;
	}
	
	return self;
}

#pragma - ZUUIRevealControllerDelegate Protocol.
- (BOOL)revealController:(ZUUIRevealController *)revealController shouldRevealRearViewController:(UIViewController *)rearViewController
{
	return YES;
}

- (BOOL)revealController:(ZUUIRevealController *)revealController shouldHideRearViewController:(UIViewController *)rearViewController 
{
	return YES;
}

- (void)revealController:(ZUUIRevealController *)revealController willRevealRearViewController:(UIViewController *)rearViewController 
{
	DLog(@"%@", NSStringFromSelector(_cmd));
}

- (void)revealController:(ZUUIRevealController *)revealController didRevealRearViewController:(UIViewController *)rearViewController
{
	DLog(@"%@", NSStringFromSelector(_cmd));
}

- (void)revealController:(ZUUIRevealController *)revealController willHideRearViewController:(UIViewController *)rearViewController
{
	DLog(@"%@", NSStringFromSelector(_cmd));
}

- (void)revealController:(ZUUIRevealController *)revealController didHideRearViewController:(UIViewController *)rearViewController 
{
	DLog(@"%@", NSStringFromSelector(_cmd));
}


@end