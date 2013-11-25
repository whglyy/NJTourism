//
//  RuleViewController.m
//  FatFish
//
//  Created by lyywhg on 12-12-28.
//  Copyright 2012年 FatFish. All rights reserved.
//

#import "RuleViewController.h"

#define VIEWHEIGTH 700

@interface RuleViewController()

@end

@implementation RuleViewController

#pragma mark
#pragma mark Init & Dealloc
- (id)init
{
    self = [super init];
    if (self)
    {
        self.title = L(@"免责声明");
    }
    return self;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark Init & Add
- (UILabel *)titleL
{
    if (!_titleL)
    {
        _titleL = [[UILabel alloc] init];
        _titleL.frame = CGRectMake(110, 0, 100, 40);
        _titleL.backgroundColor = [UIColor clearColor];
        _titleL.textAlignment = UITextAlignmentCenter;
        _titleL.text = L(@"免责声明");
        _titleL.font = [UIFont boldSystemFontOfSize:25];
        _titleL.textColor = [UIColor whiteColor];
    }
    return _titleL;
}
- (UIScrollView *)ruleScrollView
{
    if (!_ruleScrollView)
    {
        _ruleScrollView = [[UIScrollView alloc] init];
        _ruleScrollView.frame = CGRectMake(10, 10, 300, self.view.height - 40);
        _ruleScrollView.contentSize = CGSizeMake(300, VIEWHEIGTH);
        _ruleScrollView.delegate = self;
		_ruleScrollView.backgroundColor = [UIColor clearColor];
		_ruleScrollView.showsVerticalScrollIndicator = YES;
		_ruleScrollView.bounces = YES;
        _ruleScrollView.scrollsToTop = NO;
        _ruleScrollView.bounces = NO;
		_ruleScrollView.userInteractionEnabled = YES;
        [_ruleScrollView addSubview:self.ruleLabel];
    }
    return _ruleScrollView;
}

- (UILabel *)ruleLabel
{
    if (!_ruleLabel)
    {
        _ruleLabel = [[UILabel alloc] init];
        _ruleLabel.frame = CGRectMake(0, 0, 300, VIEWHEIGTH);
        _ruleLabel.backgroundColor = [UIColor whiteColor];
        _ruleLabel.font = [UIFont systemFontOfSize:18.0f];
        _ruleLabel.numberOfLines = 34;
        _ruleLabel.textColor = RGBACOLOR(14, 48, 134, 1);
        NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"MyRule" ofType:@"plist"];
        NSArray *ruleArray = [[NSArray alloc] initWithContentsOfFile:plistPath];
        _ruleLabel.text = [ruleArray objectAtIndex:0];
    }
    return _ruleLabel;
}

- (void)addAll
{
    [self.view addSubview:self.titleL];
    [self.view addSubview:self.ruleScrollView];
}

#pragma mark-
#pragma mark
- (void)backToMoreMethod
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark-
#pragma mark Other Method
- (void)loadView
{
    [super loadView];
    [self canPush];
    [self addAll];
    UIImage *bgImage = [UIImage imageNamed:@""];
    self.view.layer.contents = (id)bgImage.CGImage;
    self.view.backgroundColor = [UIColor whiteColor];
	// Do any additional setup after loading the view.
}

@end
