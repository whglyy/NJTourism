//
//  BusLineInfoViewController.m
//  NJTourism
//
//  Created by lyywhg on 13-6-22.
//
//

#import "BusLineInfoViewController.h"

@interface BusLineInfoViewController ()
@property (strong, nonatomic) NSArray *busLineInfoArray;
@end

@implementation BusLineInfoViewController

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

- (NSArray *)busLineInfoArray
{
    if (!_busLineInfoArray)
    {
        NSString *tmpString = [self.busInfoDict objectForKey:@"stats"];
        DLog(@"msg_lyywhg:tmpstring%@", tmpString);
        _busLineInfoArray = [[NSArray alloc] initWithArray:[tmpString componentsSeparatedByString:@";"]];
    }
    return _busLineInfoArray;
}
- (NSDictionary *)busInfoDict
{
    if (!_busInfoDict)
    {
        _busInfoDict = [[NSDictionary alloc] init];
    }
    return _busInfoDict;
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
    DLog(@"msg_lyywhg:%@", self.busLineInfoArray[indexPath.row]);
    customCell.textLabel.text = self.busLineInfoArray[indexPath.row];
    
    return customCell;
}

@end
