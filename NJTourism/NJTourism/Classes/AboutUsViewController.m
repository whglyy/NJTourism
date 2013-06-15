//
//  AboutUsViewController.m
//  FatFish
//
//  Created by lyywhg on 12-12-28.
//  Copyright 2012年 FatFish. All rights reserved.
//

#import "AboutUsViewController.h"

@interface AboutUsViewController ()
@property (nonatomic, retain) UIWebView *callWebView;
@end

@implementation AboutUsViewController

#pragma mark-
#pragma mark Init & Dealloc
- (id)init
{
    if (self = [super init]) 
    {
    }
    return self;
}

- (void)dealloc
{
    TT_RELEASE_SAFELY(_titleL);
    TT_RELEASE_SAFELY(_logoImageView);
    TT_RELEASE_SAFELY(_versionLabel);
    TT_RELEASE_SAFELY(_textLabel);
    
    [super dealloc];
}

- (UILabel *)titleL
{
    if (!_titleL)
    {
        _titleL = [[UILabel alloc] init];
        _titleL.frame = CGRectMake(110, 0, 100, 40);
        _titleL.backgroundColor = [UIColor clearColor];
        _titleL.textAlignment = UITextAlignmentCenter;
        _titleL.text = @"关于我们";
        _titleL.font = [UIFont boldSystemFontOfSize:25];
        _titleL.textColor = [UIColor whiteColor];
    }
    return _titleL;
}
- (UIButton *)backBtn
{
    if (!_backBtn)
    {
        _backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _backBtn.backgroundColor = [UIColor clearColor];
        [_backBtn setBackgroundImage:[UIImage imageNamed:@"sys_back_btn.png"] forState:UIControlStateNormal];
        _backBtn.frame = CGRectMake(5, 2.5, 35, 35);
        [_backBtn addTarget:self action:@selector(backMethod) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backBtn;
}
-(UIImageView *)logoImageView
{
    if (!_logoImageView)
    {
        _logoImageView = [[UIImageView alloc]initWithFrame:CGRectMake(94, 65, 132, 71)];
        _logoImageView.backgroundColor = [UIColor clearColor];
        _logoImageView.image = [UIImage imageNamed:@"FatFish_Logo_bg.png"];
        
    }
    return _logoImageView;
}

-(UILabel *)versionLabel
{
    if (!_versionLabel)
    {
        _versionLabel = [[UILabel alloc] initWithFrame:CGRectMake(110, 140, 160, 35)];
        _versionLabel.text = [NSString stringWithFormat:@"版本号:Version %@", [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"]];
        _versionLabel.font = [UIFont systemFontOfSize:13.f];
        //[versionLabel setText:L(@"VersionCode")];
        _versionLabel.backgroundColor = [UIColor clearColor];
        _versionLabel.textColor = [UIColor grayColor];
    }
    return _versionLabel;
}

-(UILabel *)textLabel
{
    if (!_textLabel)
    {
        _textLabel = [[UILabel alloc] initWithFrame:CGRectMake(25, 180, 280, 160)];
        _textLabel.backgroundColor = [UIColor clearColor];
        _textLabel.numberOfLines = 7;
        _textLabel.textColor = [UIColor blackColor];
        _textLabel.textAlignment = UITextAlignmentCenter;
        _textLabel.text = L(@"DBookIntro");
    }
    return _textLabel;
}

- (UILabel *)allRightLabel
{
    if (!_allRightLabel)
    {
        _allRightLabel = [[UILabel alloc] initWithFrame:CGRectMake(25, 340, 280, 160)];
        _allRightLabel.backgroundColor = [UIColor clearColor];
        _allRightLabel.numberOfLines = 2;
        _allRightLabel.textColor = [UIColor grayColor];
        _allRightLabel.textAlignment = UITextAlignmentCenter;
        _allRightLabel.text = @"FatFish 版权所有\nAll Rights Rserved ";
    }
    return _allRightLabel;
}

- (UIButton *)ruleBtn
{
    if (!_ruleBtn)
    {
        _ruleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _ruleBtn.backgroundColor = [UIColor clearColor];
        [_ruleBtn setBackgroundImage:[UIImage imageNamed:@"sys_rule_btn.png"] forState:UIControlStateNormal];
        _ruleBtn.frame = CGRectMake(115, 170, 90, 43);
        [_ruleBtn addTarget:self action:@selector(ruleViewMethod) forControlEvents:UIControlEventTouchUpInside];
    }
    return _ruleBtn;
}

- (UIButton *)fullBtn
{
    if (!_fullBtn)
    {
        _fullBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _fullBtn.backgroundColor = [UIColor clearColor];
        [_fullBtn setBackgroundImage:[UIImage imageNamed:@"sys_full_btn.png"] forState:UIControlStateNormal];
        _fullBtn.frame = CGRectMake(115, 315, 90, 43);
        [_fullBtn addTarget:self action:@selector(fullMethod) forControlEvents:UIControlEventTouchUpInside];
    }
    return _fullBtn;
}

- (void)addAll
{
    UIImageView *tmpTitleIV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 44)];
    tmpTitleIV.image = [UIImage imageNamed:@"sys_navbar_bg.png"];
    [self.view addSubview:tmpTitleIV];
    TT_RELEASE_SAFELY(tmpTitleIV);
    
    [self.view addSubview:self.titleL];
    [self.view addSubview:self.backBtn];
    
#if UnFullApp
    [self.view addSubview:self.fullBtn];
#endif
    
    [self.view addSubview:self.ruleBtn];
    
    [self.view addSubview:self.logoImageView];
    [self.view addSubview:self.versionLabel];
    [self.view addSubview:self.textLabel];
    [self.view addSubview:self.allRightLabel];
}

#pragma mark-
#pragma mark View Method
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self addAll];
}

- (void)backMethod
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)ruleViewMethod
{
    RuleViewController *ruleVC = [[RuleViewController alloc] init];
    [self.navigationController pushViewController:ruleVC animated:YES];
    TT_RELEASE_SAFELY(ruleVC);
}
- (void)fullMethod
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:AppFullUrl]];
}

@end
