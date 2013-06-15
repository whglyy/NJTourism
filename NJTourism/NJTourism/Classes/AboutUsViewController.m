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
        self.title = L(@"关于我们");
    }
    return self;
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
    self.view.backgroundColor = [UIColor whiteColor];
    [self canPush];
    [self addAll];
}

- (void)backMethod
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
