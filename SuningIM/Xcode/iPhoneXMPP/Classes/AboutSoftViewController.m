//
//  NextViewController.m
//  SuningIM
//
//  Created by wangbao on 13-5-28.
//
//

#import "AboutSoftViewController.h"
#import "ModulePluginManager.h"

@interface AboutSoftViewController ()

@end

@implementation AboutSoftViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"关于";
        _manager = [ModulePluginManager currentManager];
    }
    return self;
}
- (IBAction)updateVersion:(id)sender {
    ModulePlugin *versionUpdatePlugin = [[ModulePluginManager currentManager]
                                         getModuleByName:kManulVersionUpdateModuleName];
    
    [versionUpdatePlugin excuteWithCompleteBlock:^(BOOL isSuccess, NSString *errorMsg, id result) {
        if (!isSuccess) {
        [self presentFailLogoSheet:L(errorMsg)];
        }
    }];

}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setUpdateVersion:nil];
    [super viewDidUnload];
}
@end
