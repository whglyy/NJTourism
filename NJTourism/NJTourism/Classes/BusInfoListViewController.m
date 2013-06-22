//
//  BusInfoListViewController.m
//  NJTourism
//
//  Created by lyywhg on 13-6-22.
//
//

#import "BusInfoListViewController.h"

@interface BusInfoListViewController ()

@end

@implementation BusInfoListViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (NSMutableArray *)busLineArray
{
    if (!_busLineArray)
    {
        _busLineArray = [[NSMutableArray alloc] init];
    }
    return _busLineArray;
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
    return [self.busLineArray count];
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
    customCell.textLabel.text = [self.busLineArray[indexPath.row] objectForKey:@"name"];
        
    return customCell;
}

@end
