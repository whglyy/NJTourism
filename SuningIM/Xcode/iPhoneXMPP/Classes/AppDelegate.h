#import "TabBarViewController.h"
#import "XmppManager.h"


@class JIDSettingsViewController;


@interface AppDelegate : NSObject <UIApplicationDelegate>
{
	UIWindow *window;
}

@property (nonatomic, strong) IBOutlet UIWindow *window;
@property (nonatomic, strong) IBOutlet TabBarViewController *rootViewController;

@property (nonatomic, strong) XmppManager *xmppManager;

+ (AppDelegate *)currentAppDelegate;

@end
