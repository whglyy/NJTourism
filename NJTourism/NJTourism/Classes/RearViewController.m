/* 
 
 Copyright (c) 2011, Philip Kluz (Philip.Kluz@zuui.org)
 All rights reserved.
 
 Redistribution and use in source and binary forms, with or without
 modification, are permitted provided that the following conditions are met:
 
 * Redistributions of source code must retain the above copyright
 notice, this list of conditions and the following disclaimer.
 
 * Redistributions in binary form must reproduce the above copyright
 notice, this list of conditions and the following disclaimer in the
 documentation and/or other materials provided with the distribution.
 
 * Neither the name of Philip Kluz, 'zuui.org' nor the names of its contributors may 
 be used to endorse or promote products derived from this software 
 without specific prior written permission.
 
 THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
 ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
 WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 DISCLAIMED. IN NO EVENT SHALL PHILIP KLUZ BE LIABLE FOR ANY DIRECT, 
 INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
 (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
 LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
 ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 
 */

#import "RearViewController.h"

#import "RevealController.h"
#import "BusListViewController.h"
#import "TaxiViewController.h"
#import "WeatherViewController.h"
#import "SettingViewController.h"

#import "RuleViewController.h"

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
            break;
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
            break;
        case 1:
            break;
        case 2:
            break;
        case 3:
            [self readRule];
            break;
        default:
            break;
    }
}

- (void)readRule
{
    @autoreleasepool
    {
        RevealController *revealController = [self.parentViewController isKindOfClass:[RevealController class]] ? (RevealController *)self.parentViewController : nil;
        
        RuleViewController *ruleVC = [[RuleViewController alloc] init];
        UINavigationController *ruleNaviController = [[UINavigationController alloc] initWithRootViewController:ruleVC];
        [revealController setFrontViewController:ruleNaviController animated:NO];
    }
}


@end