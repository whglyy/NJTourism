//
//  BusInfoListViewController.m
//  NJTourism
//
//  Created by lyywhg on 13-6-22.
//
//

#import "BusLineInfoListViewController.h"
#import "BusLineInfoViewController.h"

@interface BusLineInfoListViewController ()

@end

@implementation BusLineInfoListViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (NSMutableArray *)busLineInfoArray
{
    if (!_busLineInfoArray)
    {
        _busLineInfoArray = [[NSMutableArray alloc] init];
    }
    return _busLineInfoArray;
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.busLineInfoArray count];
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
    customCell.textLabel.text = [self.busLineInfoArray[indexPath.row] objectForKey:@"name"];
        
    return customCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self gotoBusLineInfoView:self.busLineInfoArray[indexPath.row]];
    
}
- (void)gotoBusLineInfoView:(NSDictionary *)dict
{
    @autoreleasepool
    {
        BusLineInfoViewController *busLineInfoVC = [[BusLineInfoViewController alloc] init];
        DLog(@"msg_lyywhg:busdict%@", dict);
        busLineInfoVC.busInfoDict = dict;
        [self.navigationController pushViewController:busLineInfoVC animated:YES];
    }
}
@end
