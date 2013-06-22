//
//  BusInfoViewController.m
//  NJTourism
//
//  Created by lyywhg on 13-6-22.
//
//

#import "BusLineInfoViewController.h"

#import "DropDownCell.h"

#define FONTSIZE 12
#define CELLHEIGTH 50

@interface BusLineInfoViewController ()

@end

@implementation BusLineInfoViewController

- (id)init
{
    self = [super init];
    if (self)
    {
		self.navigationController.navigationBarHidden = NO;
    }
    return self;
}
#pragma mark-
#pragma mark 
- (NSArray *)busesArray
{
    if (!_busesArray)
    {
        _busesArray = [[NSArray alloc] init];
    }
    return _busesArray;
}
- (NSMutableArray *)busesLineArray
{
    if (!_busesLineArray)
    {
        _busesLineArray = [[NSMutableArray alloc] init];
        @autoreleasepool
        {
            for (NSDictionary *tmpDict in self.busesArray)
            {
                NSMutableString *tmpMutableString = [[NSMutableString alloc] init];
                NSString *tmpString = [[NSString alloc] init];
                NSArray *tmpArray = [[NSArray alloc] initWithArray:[[tmpDict  objectForKey:@"segments"] objectForKey:@"segment"]];
                
                for (NSDictionary *tmpBusDict in tmpArray)
                {
                    tmpString = [tmpBusDict objectForKey:@"line_name"];
                    NSInteger i = ((NSRange)[tmpString rangeOfString:@"("]).location;
                    tmpString = [tmpString substringToIndex:i];
                    
                    [tmpMutableString appendString:tmpString];
                    
                    [tmpMutableString appendString:@"->"];
                }
                tmpString = [tmpMutableString substringToIndex:([tmpMutableString length]-2)];
                [_busesLineArray addObject:tmpString];
            }
        }
    
    }
    return _busesLineArray;
}

- (void)loadView
{
    [super loadView];
    
    UIImage *bgImage = [UIImage imageNamed:@""];
    self.view.layer.contents = (id)bgImage.CGImage;
    
    self.tableView.frame = self.view.bounds;
    [self.view addSubview:self.tableView];
    
    self.tableView.height = self.view.height - self.tableView.top - 8;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.busesLineArray count];
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
        DropDownCell *customCell = [tableView dequeueReusableCellWithIdentifier:QuestionCellIdentifier];
        customCell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (customCell == nil)
        {
            customCell = [[DropDownCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:QuestionCellIdentifier];
            customCell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        customCell.topTextLabel.text = [self.busesLineArray objectAtIndex:[indexPath section]];
        
        return customCell;
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([indexPath row] == 0)
    {
        return CELLHEIGTH;
    }
    return 0;
}

@end
