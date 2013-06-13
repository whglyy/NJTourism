//
//  SNPopoverCommonViewController.h
//  FatFist
//
//  Created by lyywhg on 12-8-30.
//  Copyright (c) 2012年 FatFist. All rights reserved.
//
/*!
 @header      SNPopoverCommonViewController
 @abstract    用于在SNPopoverController中展示的viewController的父类
 @author      lyywhg
 @version     v1.0.002  12-9-3
 */

#import <UIKit/UIKit.h>
#import "SNPopoverController.h"

@interface SNPopoverCommonViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, assign) SNPopoverController *snpopoverController;
@property (nonatomic, retain) UITableView *tableView;
@property (nonatomic, retain) UILabel *titleLabel;


/*!
 @abstract      消失，取消展示
 @param         animated  是否展示动画
 */
- (void)dismissPopover:(BOOL)animated;

@end
