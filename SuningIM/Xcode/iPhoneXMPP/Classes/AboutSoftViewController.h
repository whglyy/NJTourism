//
//  NextViewController.h
//  SuningIM
//
//  Created by wangbao on 13-5-28.
//
//

#import <UIKit/UIKit.h>
#import "VersionUpgradeService.h"
#import "AppDelegate.h"
#import "TabBarViewController.h"
#import "CommonViewController.h"
#import "ModulePluginManager.h"
@interface AboutSoftViewController : CommonViewController<UITableViewDelegate,VersionUpgradeServiceDelegate>
@property (strong, nonatomic) IBOutlet UIButton *updateVersion;

@property (nonatomic, retain) ModulePluginManager *manager;


@end
