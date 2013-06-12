//
//  ContactListViewController.m
//  SuningIM
//
//  Created by shasha on 13-6-4.
//
//

#import "ContactListViewController.h"
#import "ContactDTO.h"


@interface ContactListViewController (){
    ABAddressBook *__addressBook;
}

@property (nonatomic, strong) NSArray  *recordsArray;
@property (nonatomic, strong) NSArray  *recordsStatusArray;
@property (nonatomic, strong) VerifyService  *service;

@end

@implementation ContactListViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _service = [[VerifyService alloc]init];
        _service.delegate = self;
        __addressBook =  [ABAddressBook sharedAddressBook];
        __addressBook.delegate = self;
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    CGRect frame = self.view.frame;
    frame.origin.y = 0;
    frame.size.height = frame.size.height - UITABBAR_HEIGHT - UINAVIGATIONBAR_HEIGHT;
    self.tableView.frame = frame;
    [self.view addSubview:self.tableView];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSArray *allPeople = [__addressBook allPeople];
    self.recordsArray = [self getContactArr:allPeople];
    [self.service readRequestWithPhoneNos:self.recordsArray];
}

- (NSArray *)getContactArr:(NSArray *)arr{
    NSMutableArray *contactArr = [[NSMutableArray alloc] init];
    for (ABPerson *person in arr) {
        NSArray *phoneArr = person.phoneNumArr;
        if (IsArrEmpty(phoneArr)) {
            continue;
        }else{
            for (NSString *num in phoneArr) {
                ContactDTO *dto = [[ContactDTO alloc] init];
                [dto encodeFromABPerson:person];
                dto.phoneNum = num;
                [contactArr addObject:dto];
            }
        }        
    }
    return contactArr;
}

- (void)getContactConfig{

    SNXmppFriends * friends = [XmppManager shareInstance].xmppFriends;
    
    
}

- (void)addressBookDidChange:(ABAddressBook *)addressBook{
   //do something neccesary when addressbook changed
}

- (void)talkFriends:(ContactDTO *)dto{
    DLog(@"takl to frends : %@",dto.userName);
}

- (void)addFriends:(ContactDTO *)dto{
    SNXmppFriends *friend = [XmppManager shareInstance].xmppFriends;
    [friend addDelegate:self delegateQueue:dispatch_get_main_queue()];
    [friend addFriends:dto.jid
              callback:^(BOOL isSuccess, NSString *errorMsg, id result)
    {
        
    }];
}


- (void)ReadPhoneCompletedWithResult:(BOOL)isSuccess Service:(VerifyService *)service{
    self.recordsArray = service.recordArray;
    [self.tableView reloadData];
}

#pragma mark - TableView Delegate Datasource Methods
#pragma mark   TableView 的代理以及数据源方法。
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (IsArrEmpty(self.recordsArray)) {
        return 0;
    }else{
        return [self.recordsArray count];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [ContactCell Height];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"ContactCellIdentifier";
    ContactCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        UIViewController *temporaryController = [[UIViewController alloc] initWithNibName:@"ContactCell" bundle:nil];
        cell = (ContactCell *)temporaryController.view;
        
        cell.delegate = self;
    }
    
    ContactDTO *record = [self.recordsArray objectAtIndex:indexPath.row];
    [cell setContactDTO:record];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}


@end
