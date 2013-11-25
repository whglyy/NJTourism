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
#import "QueryBusInfoViewController.h"
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
	QueryBusInfoViewController *busListViewController = [[QueryBusInfoViewController alloc] initWithNibName:@"QueryBusInfoViewController" bundle:nil];
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
    
    BTClient *btClient = [[BTClient alloc] initWithAppID:@"58C40548A812ED699C35664525D8A8104D3006D2"];
    btClient.delegate = self;
    
    [btClient translateText:@"中国" fromLanguage:@"zh-CHS" toLanguage:@"en"];
}
- (void) bingTranslateClient:(BTClient *)client translatedText:(NSString *)text translation:(NSString *)translation
{
}
- (void) bingTranslateClient:(BTClient *)client translatedArray:(NSArray *)array translations:(NSArray *)translations
{
}
- (void) bingTranslateClient:(BTClient *)client addedSuggestion:(NSString *)suggestion forText:(NSString *)text fromLanguage:(NSString *)from toLanguage:(NSString *)to userName:(NSString *)user
{
}
- (void) bingTranslateClient:(BTClient *)client addedSuggestions:(NSArray *)suggestions forArray:(NSArray *)array fromLanguage:(NSString *)from toLanguage:(NSString *)to userName:(NSString *)user
{
}
- (void) bingTranslateClient:(BTClient *)client willStartSpeakingText:(NSString *)text inLanguage:(NSString *)language
{
}
- (void) bingTranslateClientFinishedSpeaking:(BTClient *)client
{
}
- (void) bingTranslateClient:(BTClient *)client detectedLanguage:(NSString *)language ofText:(NSString *)text
{
}
- (void) bingTranslateClient:(BTClient *)client detectedLanguages:(NSArray *)languages ofArray:(NSArray *)array
{
}
- (void) bingTranslateClient:(BTClient *)client receivedTranslationLanguages:(NSArray *)languages
{
}
- (void) bingTranslateClient:(BTClient *)client receivedSpeechLanguages:(NSArray *)languages
{
}
- (void) bingTranslateClient:(BTClient *)client errorOccurred:(NSError *)error
{
}

@end
