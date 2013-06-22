//
//  BusInfoViewController.m
//  NJTourism
//
//  Created by lyywhg on 13-6-22.
//
//

#import "ChangeBusLineInfoViewController.h"

@interface ChangeBusLineInfoViewController ()

@end

@implementation ChangeBusLineInfoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

#pragma mark-
#pragma mark Init & Add
- (NSArray *)busInfoArray
{
    if (!_busInfoArray)
    {
        _busInfoArray = [[NSArray alloc] init];
    }
    return _busInfoArray;
}

- (void)loadView
{
    [super loadView];
    
    self.tableView.frame = self.view.bounds;
    [self.view addSubview:self.tableView];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.busInfoArray count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *QuestionCellIdentifier = @"QuestionCellIdentifier";
    if ([indexPath row] == 0)
    {
        UITableViewCell *customCell = [tableView dequeueReusableCellWithIdentifier:QuestionCellIdentifier];
        if (customCell == nil)
        {
            customCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:QuestionCellIdentifier];
            
        }
        customCell.selectionStyle = UITableViewCellSelectionStyleNone;
        customCell.textLabel.text = self.busInfoArray[indexPath.section];
        
        return customCell;
    }
    return nil;
}


@end
