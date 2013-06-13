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
