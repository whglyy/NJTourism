//
//  SettingViewController.m
//  SuningIM
//
//  Created by shasha on 13-5-24.
//
//

#import "SettingViewController.h"
#import "LoginViewController.h"
#import "AboutSoftViewController.h"
#import "LogOutCommand.h"
#import "PersonalDataViewController.h"
#import "OfflineViewController.h"
#import "PrivacySettingViewController.h"


@interface SettingViewController ()

@end

@implementation SettingViewController

- (id)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

-(void)loadView{
    [super loadView];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *TableSampleIdentifier = @"TableSampleIdentifier";
    
    FriendsAddListCell *cell = (FriendsAddListCell *)[tableView dequeueReusableCellWithIdentifier:
                             TableSampleIdentifier];
    
    if (!cell) {
        UIViewController *temporaryController = [[UIViewController alloc] initWithNibName:@"FriendsAddListCell" bundle:nil];
        cell = (FriendsAddListCell *)temporaryController.view;
     }
    
    if (indexPath.row == 0) {
        cell.IconImageView.image = [UIImage imageNamed:@"snim_icon_people.png"];
        cell.InfoLabel.text = L(@"个人资料");
    }
    
    if (indexPath.row == 1 ) {
        cell.IconImageView.image = [UIImage imageNamed:@"snim_icon_add_friend.png"];
        cell.InfoLabel.text = L(@"隐私设置");
    }
    if (indexPath.row == 2 ) {
        cell.IconImageView.image = [UIImage imageNamed:@"snim_icon_add_friend.png"];
        cell.InfoLabel.text = L(@"清空聊天记录");
    }
    if (indexPath.row == 3 ) {
        cell.IconImageView.image = [UIImage imageNamed:@"snim_icon_add_friend.png"];
        cell.InfoLabel.text = L(@"关于软件");
    }

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger row = [indexPath row];
    [tableView deselectRowAtIndexPath:[tableView indexPathForSelectedRow] animated:YES];
    switch (row) {
        case 0:{
        PersonalDataViewController *personaldataViewController =[[PersonalDataViewController alloc] initWithNibName:nil bundle:nil];
        [self.navigationController pushViewController:personaldataViewController animated:YES];      
            
        }
        break;
            
        case 1:{
            PrivacySettingViewController *privacysettingViewController =[[PrivacySettingViewController alloc] initWithNibName:nil bundle:nil];
            [self.navigationController pushViewController:privacysettingViewController animated:YES];
        }
            break;
            
        case 2:{
            [self clearChat];

        }
            break;

        case 3:{
       AboutSoftViewController *aboutsoftViewController = [[AboutSoftViewController alloc] initWithNibName:@"AboutSoftViewController" bundle:nil];
       [self.navigationController pushViewController:aboutsoftViewController animated:YES];
        }
           break;
   }
}
- (IBAction)logout:(id)sender {
    if ([UserCenter defaultCenter].isLogined) {
        
        UIActionSheet *logoutActionSheet = [[UIActionSheet alloc]init];
        logoutActionSheet.delegate = self;
        logoutActionSheet.tag = 2001;

        [logoutActionSheet addButtonWithTitle:L(@"sure to logout")];
        [logoutActionSheet addButtonWithTitle:L(@"Cancel")];
        [logoutActionSheet setCancelButtonIndex:1];
        [logoutActionSheet showFromRect:CGRectMake(0, self.view.bottom, 320, 120)
                                 inView:self.view animated:YES];

    }else{
        LoginViewController *loginVC = [[LoginViewController alloc] init];
        
        loginVC.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
        
        AuthManagerNavViewController *authorController = [[AuthManagerNavViewController alloc] initWithRootViewController:loginVC];
        
        [self presentModalViewController:authorController animated:YES];
        
        TT_RELEASE_SAFELY(loginVC);
        
        TT_RELEASE_SAFELY(authorController);
    }

}

- (void)clearChat{
    UIActionSheet *clearLocalFilesSheet = [[UIActionSheet alloc]init];
    clearLocalFilesSheet.delegate = self;
    clearLocalFilesSheet.tag = 2002;
    clearLocalFilesSheet.title = L(@"sure to clear");
    [clearLocalFilesSheet addButtonWithTitle:L(@"Clear")];
    [clearLocalFilesSheet addButtonWithTitle:L(@"Cancel")];
    [clearLocalFilesSheet setCancelButtonIndex:1];
    [clearLocalFilesSheet showFromRect:CGRectMake(0, self.view.bottom, 320, 120)
                                inView:self.view animated:YES];

}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    switch (actionSheet.tag) {
        case 2001:
            if (buttonIndex == 0) {
                LogOutCommand *command = [[LogOutCommand alloc]init];
                [command excute];
                
            }
            break;
        case 2002:
            if (buttonIndex == 0) {

                
            }
        default:
            break;
    }
        }

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
