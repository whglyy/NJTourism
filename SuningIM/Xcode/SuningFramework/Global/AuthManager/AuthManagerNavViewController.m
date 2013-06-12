//
//  AuthManagerNavViewController.m
//  
//
//  Created by Hubert Ryan on 11-6-23.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "AuthManagerNavViewController.h"
#import "AuthNavigationBar.h"
#import <objc/runtime.h>
#import "UserCenter.h"
#import "LoginViewEXController.h"

//因只需要一个array就可以了，故使用一个static变量
//刘坤修改于12-10-31
static NSArray *loginAuthClassArray = nil;
 
@implementation AuthManagerNavViewController

@synthesize backgroundView = _backgroundView;

+ (void)initialize
{
    if (self == [AuthManagerNavViewController class]) {
        
        loginAuthClassArray = [[NSArray alloc]  initWithObjects:
                                                             nil];
    }
}


- (id)initWithRootViewController:(UIViewController *)rootViewController{
	self = [super initWithRootViewController:rootViewController];
    if (self) {
		
        if ([self.navigationBar respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)]) {
            UIImage *image = [UIImage imageNamed:kNavigationBarBackgroundImage];
            
            UIImage *streImage = [image stretchableImageWithLeftCapWidth:image.size.width/2 topCapHeight:0];
            [self.navigationBar setBackgroundImage:streImage forBarMetrics:UIBarMetricsDefault];          
        }
        else
        {
            object_setClass(self.navigationBar, [AuthNavigationBar class]);
        }
        //self.navigationBar.tintColor = RGBCOLOR(101, 141, 179);
        self.navigationBar.tintColor = [UIColor navTintColor];
    }
	
    return self;
	
}

- (void)loadView
{
    [super loadView];
    
    self.navigationBar.layer.shadowColor = [UIColor blackColor].CGColor;
    self.navigationBar.layer.shadowOffset = CGSizeMake(0, 1);
    self.navigationBar.layer.shadowOpacity = 0.6;
    self.navigationBar.layer.shadowRadius = 1;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.view addSubview:self.backgroundView];
    [self.view sendSubviewToBack:_backgroundView];
}

- (UIView *)backgroundView
{
    if (!_backgroundView) {
        _backgroundView = [UIView new];
        CGRect frame = [[UIScreen mainScreen] bounds];
        _backgroundView.frame = CGRectMake(0, 20, frame.size.width, frame.size.height);
        _backgroundView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:kNavControllerBackgroundImage]];
    }
    return _backgroundView;
}

#pragma mark -
#pragma mark logon auth

- (BOOL)needLogonAuth:(UIViewController *)viewController{
	BOOL need = NO;
	for (id class in loginAuthClassArray) {
		if ([[viewController class] isSubclassOfClass:class]) {
			need = YES;
			break;
		}
	}
	
	return need;
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
	
	if ([self needLogonAuth:viewController]) {
        
        if (![[UserCenter defaultCenter] isLogined]) {
            LoginViewEXController *loginVC = [[LoginViewEXController alloc] init];
            loginVC.nextController = viewController;
            loginVC.nextNavigationController = self;
            loginVC.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
            
            AuthManagerNavViewController *navController = [[AuthManagerNavViewController alloc] initWithRootViewController:loginVC];
            
            [self presentModalViewController:navController animated:YES];
           
            return;
        }
				
        if ([self.viewControllers containsObject:viewController]) {
            //[viewController viewWillAppear:animated];
            return;
        }
	}
	
	[super pushViewController:viewController animated:animated];
}

- (void)dismissModalViewControllerAnimated:(BOOL)animated{
	
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 5.0) {
        [super dismissViewControllerAnimated:animated completion:NULL];
    }else{
    	[super dismissModalViewControllerAnimated:animated];
    }
}

- (void)presentModalViewController:(UIViewController *)modalViewController animated:(BOOL)animated
{
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 5.0) {
        [super presentViewController:modalViewController animated:animated completion:NULL];
    }else{
        [super presentModalViewController:modalViewController animated:animated];
    }
}

@end
