//
//  AppDelegate.m
//  FatFist
//
//  Copyright 2011 FatFish. All rights reserved.
//
//
#import "AppDelegate.h"

#import "GetLocalLanguage.h"

#import "RevealController.h"
#import "BusListViewController.h"
#import "RearViewController.h"

@implementation AppDelegate

- (UIWindow *)window
{
    if (!_window)
    {
        _window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    }
    return _window;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{	
	BusListViewController *busListViewController = [[BusListViewController alloc] initWithNibName:@"BusListViewController" bundle:nil];
	RearViewController *rearViewController = [[RearViewController alloc] initWithNibName:@"RearViewController" bundle:nil];
    
	UINavigationController *firstNavController = [[UINavigationController alloc] initWithRootViewController:busListViewController];
	
	RevealController *revealController = [[RevealController alloc] initWithFrontViewController:firstNavController rearViewController:rearViewController];
    revealController.view.backgroundColor = [UIColor orangeColor];
	
	self.window.rootViewController = revealController;
	[self.window makeKeyAndVisible];
    
    [self getLocalLanguage];
    
	return YES;
}

+ (AppDelegate *)currentAppDelegate
{
	return (AppDelegate *)[[UIApplication sharedApplication] delegate];
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
}
- (void)applicationWillEnterForeground:(UIApplication *)application
{
}

- (void)getLocalLanguage
{
    [Config currentConfig].localLanguage = [NSNumber numberWithInteger:[GetLocalLanguage getLocalLanguage]];
}


@end
