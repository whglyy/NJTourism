//
//
//  FatFist
//
//  Copyright 2011 FatFish. All rights reserved.
//
//

#import "RevealController.h"
#import "BingTranslate.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate, BTClientDelegate>

@property (retain, nonatomic) UIWindow *window;
@property (retain, nonatomic) RevealController *revealVC;

+ (AppDelegate *)currentAppDelegate;

@end
