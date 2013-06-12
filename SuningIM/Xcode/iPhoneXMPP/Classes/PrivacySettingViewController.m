//
//  PrivacySettingViewController.m
//  SuningIM
//
//  Created by wangbao on 13-6-7.
//
//

#import "PrivacySettingViewController.h"

@interface PrivacySettingViewController ()

@end

@implementation PrivacySettingViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
    }
    return self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    self.title = @"隐私设置";
    
    NSString *actionTableViewCellIdentifier = @"actionTableViewCellIdentifier";
    
    PersonalDataViewCell *tSettingSetCell = (PersonalDataViewCell *)[tableView dequeueReusableCellWithIdentifier:actionTableViewCellIdentifier];
    
    if (!tSettingSetCell) {
        UIViewController *temporaryController = [[UIViewController alloc] initWithNibName:@"PersonalDataViewCell" bundle:nil];
        tSettingSetCell = (PersonalDataViewCell *)temporaryController.view;
    }
    switch (indexPath.row)
    {
       case 0:
        {
      tSettingSetCell.InfoLabel.text = @"通讯录黑名单";
      return tSettingSetCell;
        }
       case 1:
        {
            tSettingSetCell.InfoLabel.text = @"加我好友时需要验证";
            UISwitch *switchView = [[UISwitch alloc] init];
            [switchView setOn:YES];
            tSettingSetCell.accessoryView = switchView;
            return tSettingSetCell;
        }
    default:
    break;
}
    return  nil;

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

@end
