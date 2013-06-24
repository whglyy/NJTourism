//
//  BusInfoViewController.m
//  NJTourism
//
//  Created by lyywhg on 13-6-22.
//
//

#import "ChangeBusLineListViewController.h"

#import "ChangeBusLineInfoViewController.h"

#import "DropDownCell.h"

#define FONTSIZE 12
#define CELLHEIGTH 50

@interface ChangeBusLineListViewController ()

@end

@implementation ChangeBusLineListViewController

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
- (NSString *)startString
{
    if (!_startString)
    {
        _startString = [[NSString alloc] init];
    }
    return _startString;
}
- (NSString *)endString
{
    if (!_endString)
    {
        _endString = [[NSString alloc] init];
    }
    return _endString;
}
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
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.busesLineArray count];
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *QuestionCellIdentifier = @"QuestionCellIdentifier";
    
    DropDownCell *customCell = [tableView dequeueReusableCellWithIdentifier:QuestionCellIdentifier];
    customCell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (customCell == nil)
    {
        customCell = [[DropDownCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:QuestionCellIdentifier];
        customCell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
        
    customCell.topTextLabel.text = self.busesLineArray[indexPath.row];
        
    return customCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self getBusLineInfo:self.busesArray[indexPath.row]];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark-
#pragma mark
- (void)getBusLineInfo:(NSDictionary *)dict
{
    @autoreleasepool
    {
        ChangeBusLineInfoViewController *busInfoVC = [[ChangeBusLineInfoViewController alloc] init];
        busInfoVC.busInfoArray = [self transferBusInfo:dict];
        [self.navigationController pushViewController:busInfoVC animated:YES];
    }
}
- (NSMutableArray *)transferBusInfo:(NSDictionary *)dict
{
    NSMutableArray *tmpArray = [[NSMutableArray alloc] init];

    @autoreleasepool
    {
        [tmpArray addObject:self.startString];
        
        NSArray *busSegment = [[dict objectForKey:@"segments"] objectForKey:@"segment"];
        for (NSDictionary *tmpDict in busSegment)
        {
            NSString *footDistString = [tmpDict objectForKey:@"foot_dist"];
            
            NSInteger i = ((NSRange)[[tmpDict objectForKey:@"line_name"] rangeOfString:@"("]).location;
            NSString *busNameString  = [[tmpDict objectForKey:@"line_name"] substringToIndex:i];
            NSString *startStatString = [tmpDict objectForKey:@"start_stat"];
            NSString *endStatString = [tmpDict objectForKey:@"end_stat"];
            NSString *statsString = [tmpDict objectForKey:@"stats"];
            NSArray *statsArray = [statsString componentsSeparatedByString:@";"];
            DLog(@"msg_lyywhg:%@", statsArray);
            int iFootDist = [footDistString integerValue];
            int statCount = [statsArray count];
        
            if (iFootDist > 0)
            {
                NSString *tmpFootString = [[NSString alloc] initWithFormat:@"%@%@%@%@", L(@"步行"), footDistString, L(@"米到"), startStatString];
                
                [tmpArray addObject:tmpFootString];
            }
            
            NSString *tmpBusNameString = [[NSString alloc] initWithFormat:@"%@%@%@%d%@%@%@", L(@"乘坐"), busNameString, L(@"经"), statCount, L(@"站，在"), endStatString, L(@"下")];
            [tmpArray addObject:tmpBusNameString];
        }
        
        NSString *lastFootString = [dict objectForKey:@"last_foot_dist"];
        int iLastFoot = [lastFootString integerValue];
        if (iLastFoot > 0)
        {
            NSString *tmpFootString = [[NSString alloc] initWithFormat:@"%@%@%@%@", L(@"步行"), lastFootString, L(@"米到"), self.endString];
            
            [tmpArray addObject:tmpFootString];
        }
        
        [tmpArray addObject:self.endString];
    }
    return tmpArray;
}
@end
