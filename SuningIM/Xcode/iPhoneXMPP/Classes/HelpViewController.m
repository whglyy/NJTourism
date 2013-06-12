//
//  HelpViewController.m
//  SuningPan
//
//  Created by lyywhg on 12-10-11.
//  Copyright (c) 2012年 sn. All rights reserved.
//

#import "HelpViewController.h"

@interface HelpViewController ()

@property (nonatomic, retain) UIScrollView *helperScrollView;

@end

@implementation HelpViewController


- (id)init
{
    self = [super init];
    if (self)
    {
		self.navigationController.navigationBarHidden = NO;
    }
    return self;
}

#pragma mark
- (void)helperViewDissmiss
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark Others
- (void)loadView
{
    [super loadView];
    
    self.helperScrollView.delegate = self;
    
}

- (void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = YES;
    [super viewWillAppear:animated];
}

- (UIScrollView *)helperScrollView
{
    if (!_helperScrollView)
    {
        
        _helperScrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
		_helperScrollView.backgroundColor = [UIColor clearColor];
		_helperScrollView.showsVerticalScrollIndicator = NO;
		_helperScrollView.showsHorizontalScrollIndicator = NO;
		_helperScrollView.pagingEnabled = YES;
        _helperScrollView.scrollsToTop = NO;
        _helperScrollView.bounces = NO;
		_helperScrollView.userInteractionEnabled = YES;
        
        for (int i = 0; i< 3; i++)
        {
            if (self.view.frame.size.height > 480)
            {
                NSString *imageName = [NSString stringWithFormat:@"sys_introduce%d.png",i+1];
                UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
                imageView.frame = CGRectMake(self.view.width * i, 0, self.view.width, self.view.height);
                
                [_helperScrollView addSubview:imageView];
                TT_RELEASE_SAFELY(imageView);
            }
            else
            {
                NSString *imageName = [NSString stringWithFormat:@"sys_introduce_%d.png",i+1];
                UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
                imageView.frame = CGRectMake(self.view.width * i, 0, self.view.width, self.view.height);
                if (i == 2)
                {
                    imageView.userInteractionEnabled = YES;
                }
                
                [_helperScrollView addSubview:imageView];
                TT_RELEASE_SAFELY(imageView);
            }
        }
        
        _helperScrollView.contentSize = CGSizeMake(self.view.width * 3, self.helperScrollView.height);
    
        [self.view addSubview:_helperScrollView];
    }
    
    return _helperScrollView;
}

- (void)dismissView
{
    CGContextRef contentext = UIGraphicsGetCurrentContext();
    
    [UIView beginAnimations:nil context:contentext];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    [UIView setAnimationDuration:0.4];
    
    self.view.transform = CGAffineTransformMakeTranslation(-320, 0);
    if (self.type == 1) {
        self.navigationController.navigationBarHidden = YES;
    }
    else{
        self.navigationController.navigationBarHidden = NO;
    }
    [self.navigationController popViewControllerAnimated:YES];
    [UIView setAnimationDelegate:self];
    [UIView commitAnimations];
}

#pragma mark
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    scrollView.bounces = YES;
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    CGPoint nowPoint = scrollView.contentOffset;
    CGFloat nowX = nowPoint.x;
    
    if ( ((int)nowX / 320 == 2) && ((int)nowX % 320 > 5) )
    {
        [self dismissView];
    }
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
