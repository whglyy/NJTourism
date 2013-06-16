
#import "RearViewController.h"

#import "RevealController.h"
#import "BusListViewController.h"
#import "TaxiViewController.h"
#import "SettingViewController.h"

#import "FeedbackViewController.h"
#import "AboutUsViewController.h"
#import "RuleViewController.h"

#import "MobClick.h"

@interface RearViewController()
@end

@implementation RearViewController

@synthesize rearTableView = _rearTableView;

#pragma mark-
#pragma mark Init & Add
- (NSArray *)sectionTitleList
{
    if (!_sectionTitleList)
    {
        _sectionTitleList = [[NSArray alloc] initWithObjects:L(@"常用"), L(@"设置"), nil];
    }
    return _sectionTitleList;
}
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
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return 4;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [self.sectionTitleList objectAtIndex:section];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString *cellIdentifier = @"Cell";
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
	
	if (nil == cell)
	{
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
	}
	
	cell.textLabel.text = [self.tableList objectAtIndex:(indexPath.section * 4 + indexPath.row)];
	
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section)
    {
        case 0:
            break;
        case 1:
            [self settingControllers:indexPath.row];
            return;
        default:
            break;
    }
	RevealController *revealController = [self.parentViewController isKindOfClass:[RevealController class]] ? (RevealController *)self.parentViewController : nil;
	
	if (indexPath.row == 0)
	{
		if (![revealController.frontViewController isKindOfClass:[BusListViewController class]])
		{
			BusListViewController *frontViewController;
			
			
            frontViewController = [[BusListViewController alloc] initWithNibName:@"BusListViewController" bundle:nil];
			
			
			UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:frontViewController];
			[revealController setFrontViewController:navigationController animated:NO];
		}
	}

}
#pragma mark-
#pragma mark Method
- (void)settingControllers:(NSInteger)index
{
    switch (index)
    {
        case 0:
            [self checkVersion];
            break;
        case 1:
            [self feedBack];
            break;
        case 2:
            [self aboutUs];
            break;
        case 3:
            [self readRule];
            break;
        default:
            break;
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