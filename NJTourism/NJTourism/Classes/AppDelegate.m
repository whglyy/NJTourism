//
//  AppDelegate.m
//  FatFist
//
//  Copyright 2011 FatFish. All rights reserved.
//
//
#import "AppDelegate.h"

#import "RevealController.h"
#import "BusListViewController.h"
#import "RearViewController.h"

@implementation AppDelegate

@synthesize window = _window;
@synthesize viewController = _viewController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
	self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
	
	BusListViewController *frontViewController;
	RearViewController *rearViewController;
	
	
    frontViewController = [[BusListViewController alloc] initWithNibName:@"BusListViewController" bundle:nil];
    rearViewController = [[RearViewController alloc] initWithNibName:@"RearViewController" bundle:nil];
    
	
	UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:frontViewController];
	
	RevealController *revealController = [[RevealController alloc] initWithFrontViewController:navigationController rearViewController:rearViewController];
	
	self.window.rootViewController = revealController;
	[self.window makeKeyAndVisible];
	return YES;
}

+ (AppDelegate *)currentAppDelegate
{
	return (AppDelegate *)[[UIApplication sharedApplication] delegate];
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
	// Use this method to release shared resources, save user data, invalidate timers, and store
	// enough application state information to restore your application to its current state in case
	// it is terminated later.
	//
	// If your application supports background execution,
	// called instead of applicationWillTerminate: when the user quits.
	
    
	if ([application respondsToSelector:@selector(setKeepAliveTimeout:handler:)])
	{
		[application setKeepAliveTimeout:600 handler:^{
						
			// Do other keep alive stuff here.
		}];
	}
}
- (void)applicationWillEnterForeground:(UIApplication *)application
{
}


@end
