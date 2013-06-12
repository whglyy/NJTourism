#import "AppDelegate.h"

#import "DAO.h"

@interface AppDelegate()

@end

@implementation AppDelegate

@synthesize window;
@synthesize rootViewController;

#pragma mark-
#pragma mark Init & Add
- (XmppManager *)xmppManager
{
    if (!_xmppManager)
    {
        _xmppManager = [[XmppManager alloc] init];
    }
    return _xmppManager;
}
#pragma mark-
#pragma mark
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
   
    self.window.rootViewController = self.rootViewController;
        
    [self.window makeKeyAndVisible];
    
    [self registerPlugins];
    
    [DDLog addLogger:[DDTTYLogger sharedInstance]];
    
    [[XmppManager shareInstance] registerToApp];
        
    return YES;
}


- (void)registerPlugins{
    
    ModulePluginManager *pluginManager = [ModulePluginManager currentManager];
    [pluginManager registerModulesWithName:[NSArray arrayWithObjects:
                                            kTrafficStaticModuleName,
                                            kLocalCacheModuleName,
                                            kFeedBackModuleName,
                                            kAutoVersionUpdateModuleName,
                                            kManulVersionUpdateModuleName,
                                            klocalCacheClearModuleName,
                                            kHelperGuidModuleName,
                                            nil]];
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
	
	DDLogVerbose(@"%@: %@", THIS_FILE, THIS_METHOD);
    
#if TARGET_IPHONE_SIMULATOR
	DDLogError(@"The iPhone simulator does not process background network traffic. "
			   @"Inbound traffic is queued until the keepAliveTimeout:handler: fires.");
#endif
    
	if ([application respondsToSelector:@selector(setKeepAliveTimeout:handler:)])
	{
		[application setKeepAliveTimeout:600 handler:^{
			
			DDLogVerbose(@"KeepAliveHandler");
			
			// Do other keep alive stuff here.
		}];
	}
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
	DDLogVerbose(@"%@: %@", THIS_FILE, THIS_METHOD);
}




@end
