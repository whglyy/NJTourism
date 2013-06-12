//
//  FriendsSearchViewController.m
//  SuningIM
//
//  Created by shasha on 13-5-31.
//
//

#import "FriendsSearchViewController.h"
#import "FriendsAddListCell.h"
#import "SNXmppFriends.h"
#import "AddressBook.h"
#import "FriendsSearchResultCell.h"

@interface FriendsSearchViewController (){
    SNXmppFriends *__searchFriends;
}

@property (nonatomic, strong) NSArray  *searchResultArr;
@end

@implementation FriendsSearchViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        __searchFriends = [XmppManager shareInstance].xmppFriends;
        [__searchFriends addDelegate:self delegateQueue:dispatch_get_main_queue()];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    CGRect frame = self.view.frame;
    frame.origin.y = self.searchBar.bottom;
    frame.size.height = frame.size.height - UINAVIGATIONBAR_HEIGHT - UITABBAR_HEIGHT - self.searchBar.height;
    self.tableView.frame = frame;
    [self.view addSubview:self.tableView];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setSearchBar:nil];
    [super viewDidUnload];
}

-(void)dealloc{
   [__searchFriends removeDelegate:self delegateQueue:dispatch_get_main_queue()];
}

#pragma mark - SearchBar Delegate Methods
#pragma mark  
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    NSString *searchKeyWord = searchBar.text;
    if (IsStrEmpty(searchKeyWord)) {
        [self presentSheet:L(@"请输入搜索关键字")];
        return;
    }
    SearchCondtion *con =  [[SearchCondtion alloc] init];
    con.searchKeyWord = searchKeyWord;
    con.index = @"1";
    con.max = @"10";
    [__searchFriends sendAccurateSearch:con
                               callback:^(BOOL isSuccess, NSString *errorMsg, id result)
    {
        if (isSuccess) {
            self.searchResultArr = (NSArray *)result;
            [self.tableView reloadData];
            
        }else{
        
        }
    }];
}


#pragma mark - TableView Delegate Datasource Methods
#pragma mark   TableView 的代理以及数据源方法。
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (IsArrEmpty(self.searchResultArr)) {
        return 0;
    }else{
        return [self.searchResultArr count];
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [FriendsSearchResultCell Height];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identify = @"SearchResultCellIdentifier";
    
    FriendsSearchResultCell *cell = (FriendsSearchResultCell *)[tableView dequeueReusableCellWithIdentifier:identify];
    
    if (!cell) {
        UIViewController *temporaryController = [[UIViewController alloc] initWithNibName:@"FriendsSearchResultCell" bundle:nil];
        cell = (FriendsSearchResultCell *)temporaryController.view;
    }
    
    SNXMPPvCard *vcard = [self.searchResultArr objectAtIndex:indexPath.row];
    
    [cell setVcard:vcard];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        FriendsSearchViewController *vc = [[FriendsSearchViewController alloc] initWithNibName:@"FriendsSearchViewController" bundle:nil];
        [self.navigationController pushViewController:vc animated:YES];
    }else{
      
    }
    
}
@end
