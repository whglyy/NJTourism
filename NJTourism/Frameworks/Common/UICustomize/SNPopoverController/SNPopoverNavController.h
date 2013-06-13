//
//  SNPopoverNavController.h
//  FatFist
//
//  Created by lyywhg on 13-5-24.
//
//

#import <UIKit/UIKit.h>

@class SNPopoverController;

@interface SNPopoverNavController : UINavigationController


- (id)initWithRootViewController:(UIViewController *)rootViewController 
                  homeController:(SNPopoverController *)homeController;

@end
