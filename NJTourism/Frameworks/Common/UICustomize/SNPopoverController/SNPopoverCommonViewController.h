//
//  SNPopoverCommonViewController.h
//  FatFist
//
//  Copyright 2011 FatFish. All rights reserved.
//
//
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
