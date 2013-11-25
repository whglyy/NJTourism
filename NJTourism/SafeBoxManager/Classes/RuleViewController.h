//
//  RuleViewController.h
//  FatFish
//
//  Created by lyywhg on 12-12-28.
//  Copyright 2012年 FatFish. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommonViewController.h"

@interface RuleViewController : CommonViewController<UIScrollViewDelegate>

@property (nonatomic, retain) UIScrollView *ruleScrollView;
@property (nonatomic, retain) UILabel *ruleLabel;

@property (nonatomic, retain) UILabel *titleL;

@end
