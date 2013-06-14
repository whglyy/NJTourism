//
//  AppDelegate.m
//  FatFist
//
//  Copyright 2011 FatFish. All rights reserved.
//
//
#import "AppDelegate.h"
#import "DAO.h"
@interface AppDelegate()
@end
@implementation AppDelegate
@synthesize window;
@synthesize rootViewController;
#pragma mark-
#pragma mark Init & Add
#pragma mark-
#pragma mark
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
   
    self.window.rootViewController = self.rootViewController;
        
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
