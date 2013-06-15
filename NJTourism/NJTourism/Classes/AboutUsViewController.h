//
//  AboutUsViewController.h
//  FatFish
//
//  Created by lyywhg on 12-12-28.
//  Copyright 2012年 FatFish. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RuleViewController.h"

@interface AboutUsViewController : BaseViewController
{
}

@property (nonatomic, retain) UILabel *versionLabel;
@property (nonatomic, retain) UILabel *textLabel;
@property (nonatomic, retain) UIImageView *logoImageView;
@property (nonatomic, retain) UILabel *allRightLabel;

@property (nonatomic, retain) UIButton *ruleBtn;
@property (nonatomic, retain) UIButton *fullBtn;
@property (nonatomic, retain) UIButton *backBtn;
@property (nonatomic, retain) UILabel *titleL;

@end

