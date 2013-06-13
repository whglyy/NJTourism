//
//  SNPopoverNavController.h
//  FatFist
//
//  Created by lyywhg on 12-8-30.
//  Copyright (c) 2012年 FatFist. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SNPopoverController;

@interface SNPopoverNavController : UINavigationController


- (id)initWithRootViewController:(UIViewController *)rootViewController 
                  homeController:(SNPopoverController *)homeController;

@end
