//
//  FriendsAddViewController.m
//  SuningIM
//
//  Created by shasha on 13-5-24.
//
//

#import "FriendsAddViewController.h"
#import "AddressMatchViewController.h"
#import "FriendsSearchViewController.h"
#import "ContactListViewController.h"

@interface FriendsAddViewController ()

@end

@implementation FriendsAddViewController

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
    UIView *contentView = self.view;
    CGRect frame = contentView.frame;
    frame.origin.y = 0;
    frame.size.height = frame.size.height  - UINAVIGATIONBAR_HEIGHT - UITABBAR_HEIGHT;
    self.tableView.frame = frame;
    [self.view addSubview:self.tableView];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - TableView Delegate Datasource Methods
#pragma mark   TableView 的代理以及数据源方法。
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 45;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identify = @"FriendsAddCellIdnetify";

    FriendsAddListCell *cell = (FriendsAddListCell *)[tableView dequeueReusableCellWithIdentifier:identify];
    
    if (!cell) {
        UIViewController *temporaryController = [[UIViewController alloc] initWithNibName:@"FriendsAddListCell" bundle:nil];
        cell = (FriendsAddListCell *)temporaryController.view;
            
    }
    if (indexPath.row == 0) {
        cell.IconImageView.image = [UIImage imageNamed:@"snim_icon_people.png"];
        cell.InfoLabel.text = L(@"搜好友添加");
    }
    
    if (indexPath.row ==1 ) {
        cell.IconImageView.image = [UIImage imageNamed:@"snim_icon_add_friend.png"];
        cell.InfoLabel.text = L(@"从手机通讯录添加");
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    [tableView deselectRowAtIndexPath:[tableView indexPathForSelectedRow] animated:YES];

    if (indexPath.row == 0) {
        FriendsSearchViewController *vc = [[FriendsSearchViewController alloc] initWithNibName:@"FriendsSearchViewController" bundle:nil];
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (indexPath.row == 1) {
#warning waiting for Test
        ContactListViewController *vc = [[ContactListViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
        /*
         if (![UserCenter defaultCenter].isBindPhone) {
         AddressMatchViewController *addressmatchViewController = [[AddressMatchViewController alloc] initWithNibName:@"AddressMatchViewController" bundle:nil];
         [self.navigationController pushViewController:addressmatchViewController animated:YES];
         }else{
         AddressMatchViewController *vc = [[AddressMatchViewController alloc] init];
         [self.navigationController pushViewController:vc animated:YES];
         }
         */
        
        
    }    
}

@end
