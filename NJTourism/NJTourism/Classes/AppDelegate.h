//
//
//  FatFist
//
//  Created by lyywhg on 13-5-24.
//
//

#import "TabBarViewController.h"

@class JIDSettingsViewController;


@interface AppDelegate : NSObject <UIApplicationDelegate>
{
	UIWindow *window;
}

@property (nonatomic, strong) IBOutlet UIWindow *window;
@property (nonatomic, strong) IBOutlet TabBarViewController *rootViewController;

+ (AppDelegate *)currentAppDelegate;

@end
