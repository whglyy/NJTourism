//
//  EntertainmentListViewController.m
//  NJTourism
//
//  Created by lyywhg on 13-6-23.
//
//

#import "EntertainmentListViewController.h"

@interface EntertainmentListViewController ()
@property (strong, nonatomic) AibangApi *abApi;
@end

@implementation EntertainmentListViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIImage *bgImage = [UIImage imageNamed:@""];
    self.view.layer.contents = (id)bgImage.CGImage;
    
    self.tableView.frame = self.view.bounds;
    [self.view addSubview:self.tableView];
    
    self.tableView.height = self.view.height - self.tableView.top - 8;
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (AibangApi *)abApi
{
    if (!_abApi)
    {
        _abApi = [[AibangApi alloc] init];
        _abApi.delegate = self;
        [AibangApi setAppkey:@"f946549e05f316f49ba667d9629ea1e3"];
    }
    return _abApi;
}
- (NSArray *)entertainmentList
{
    if (!_entertainmentList)
    {
        _entertainmentList = [[NSArray alloc] init];
    }
    return _entertainmentList;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.entertainmentList count];
}

- (void)requestDidFinishWithDictionary:(NSDictionary *)dict aibangApi:(id)aibangApi
{
    [self removeOverFlowActivityView];
}
- (void)requestDidFailedWithError:(NSError*)error aibangApi:(id)aibangApi
{
    DLog(@"msg_lyywhg:r~error%@", error);
    [self removeOverFlowActivityView];
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *QuestionCellIdentifier = @"QuestionCellIdentifier";
    
    UITableViewCell *customCell = [tableView dequeueReusableCellWithIdentifier:QuestionCellIdentifier];
    if (customCell == nil)
    {
        customCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:QuestionCellIdentifier];
        
    }
    customCell.selectionStyle = UITableViewCellSelectionStyleNone;
    customCell.textLabel.text = [self.entertainmentList[indexPath.row] objectForKey:@"name"];
    
    return customCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.abApi bizWithBid:[self.entertainmentList[indexPath.row] objectForKey:@"id"]];
}

@end
