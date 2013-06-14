//
//  SNPopoverNavController.h
//  FatFist
//
//  Copyright 2011 FatFish. All rights reserved.
//
//

#import <UIKit/UIKit.h>

@class SNPopoverController;

@interface SNPopoverNavController : UINavigationController


- (id)initWithRootViewController:(UIViewController *)rootViewController 
                  homeController:(SNPopoverController *)homeController;

@end
