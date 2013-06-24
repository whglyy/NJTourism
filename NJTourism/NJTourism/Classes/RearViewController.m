
#import "RearViewController.h"

#import "RevealController.h"

#import "QueryBusInfoViewController.h"
#import "TaxiViewController.h"
#import "WeatherViewController.h"
#import "SearchEntertainmentViewController.h"

#import "SettingViewController.h"

#import "FeedbackViewController.h"
#import "AboutUsViewController.h"
#import "RuleViewController.h"

#import "RevealCell.h"

#import "MobClick.h"

@interface RearViewController()
@end

@implementation RearViewController

@synthesize rearTableView = _rearTableView;

#pragma mark-
#pragma mark Init & Add
- (NSArray *)tableList
{
    if (!_tableList)
    {
        _tableList = [[NSArray alloc] initWithObjects:L(@"附近公交"), L(@"附近出租"), L(@"当地天气"), L(@"附近趣事"), L(@"检查更新"), L(@"意见反馈"), L(@"关于我们"), L(@"免责申明"), nil];
    }
    return _tableList;
}
- (RevealController *)revealController
{
    if (!_revealController)
    {
        _revealController = [self.parentViewController isKindOfClass:[RevealController class]] ? (RevealController *)self.parentViewController : nil;
    }
    return _revealController;
}

#pragma mark-
#pragma mark TableView Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return 8;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString *RevealCellIdentifier = @"RevealCell";
	RevealCell *revealCell = [tableView dequeueReusableCellWithIdentifier:RevealCellIdentifier];
    if (revealCell == nil)
    {
        revealCell = [[[NSBundle mainBundle] loadNibNamed:RevealCellIdentifier owner:self options:nil] objectAtIndex:0];
    }
	revealCell.selectionStyle = UITableViewCellSelectionStyleNone;
	[revealCell setAllContent:self.tableList[indexPath.row]];
	
	return revealCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self getNJThing:indexPath.row];
}
#pragma mark-
#pragma mark Switch Method
- (void)getNJThing:(NSInteger)index
{
    switch (index)
    {
        case 0:
            [self getBusInfo];
            break;
        case 1:
            [self getTaxiInfo];
        case 2:
            [self getWeatherInfo];
        case 3:
            [self getNJEnter];
            break;
        case 4:
            [self checkVersion];
            break;
        case 5:
            [self feedBack];
            break;
        case 6:
            [self aboutUs];
            break;
        case 7:
            [self readRule];
            break;
        default:
            break;
    }
}
#pragma mark-
#pragma mark 
- (void)getBusInfo
{
    @autoreleasepool
    {
        QueryBusInfoViewController *busListVC = [[QueryBusInfoViewController alloc] initWithNibName:@"BusListViewController" bundle:nil];
        UINavigationController *busListNaviController = [[UINavigationController alloc] initWithRootViewController:busListVC];
        [self.revealController setFrontViewController:busListNaviController animated:NO];
    }
}
- (void)getTaxiInfo
{
    @autoreleasepool
    {
        TaxiViewController *taxiListVC = [[TaxiViewController alloc] initWithNibName:@"TaxiViewController" bundle:nil];
        UINavigationController *taxiListNaviController = [[UINavigationController alloc] initWithRootViewController:taxiListVC];
        [self.revealController setFrontViewController:taxiListNaviController animated:NO];
    }
}
- (void)getWeatherInfo
{
    @autoreleasepool
    {
        WeatherViewController *weatherListVC = [[WeatherViewController alloc] initWithNibName:@"WeatherViewController" bundle:nil];
        UINavigationController *weatherListNaviController = [[UINavigationController alloc] initWithRootViewController:weatherListVC];
        [self.revealController setFrontViewController:weatherListNaviController animated:NO];
    }
}
- (void)getNJEnter
{
    @autoreleasepool
    {
        SearchEntertainmentViewController *searchEnterListVC = [[SearchEntertainmentViewController alloc] init];
        UINavigationController *searchEnterListNaviController = [[UINavigationController alloc] initWithRootViewController:searchEnterListVC];
        [self.revealController setFrontViewController:searchEnterListNaviController animated:NO];
    }
}
- (void)checkVersion
{
    [MobClick startWithAppkey:UMENG_APPKEY];
    [MobClick checkUpdate];
}
- (void)feedBack
{
    @autoreleasepool
    {
        FeedbackViewController *feedbackVC = [[FeedbackViewController alloc] initWithNibName:@"FeedbackViewController" bundle:nil];
        UINavigationController *feedbackNaviController = [[UINavigationController alloc] initWithRootViewController:feedbackVC];
        [self.revealController setFrontViewController:feedbackNaviController animated:NO];
        
    }
}
- (void)aboutUs
{
    @autoreleasepool
    {
        AboutUsViewController *aboutusVC = [[AboutUsViewController alloc] init];
        UINavigationController *aboutusNaviController = [[UINavigationController alloc] initWithRootViewController:aboutusVC];
        [self.revealController setFrontViewController:aboutusNaviController animated:NO];

    }
}
- (void)readRule
{
    @autoreleasepool
    {
        RuleViewController *ruleVC = [[RuleViewController alloc] init];
        UINavigationController *ruleNaviController = [[UINavigationController alloc] initWithRootViewController:ruleVC];
        [self.revealController setFrontViewController:ruleNaviController animated:NO];
    }
}


@end