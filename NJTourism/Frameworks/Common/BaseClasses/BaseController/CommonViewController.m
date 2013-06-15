//
//  CommonViewController.m
//  FatFist
//
//  Copyright 2011 FatFish. All rights reserved.
//
//
#import "TPKeyboardAvoidingTableView.h"
#import "CommonViewController.h"
#import "MBProgressHUD.h"
@implementation CommonViewController
@synthesize  tableView = _tableView;
@synthesize  groupTableView = _groupTableView;
@synthesize tpTableView = _tpTableView;
@synthesize  dlgTimer = _dlgTimer;
@synthesize pageInTime = _pageInTime;
+ (id)controller
{
    return [[self alloc] init];
}
- (id)init{
	
    self = [super init];
	
    if (self) {
		
    }
    return self;
}

- (void)dealloc
{
    [_dlgTimer invalidate];
    [self dismissAllCustomAlerts];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}
- (void)loadView
{
	[super loadView];
    self.view.backgroundColor = [UIColor clearColor];
}
- (void)setDlgTimer:(NSTimerHelper *)dlgTimer
{
    if (dlgTimer != _dlgTimer) {
        [_dlgTimer invalidate];
        _dlgTimer = dlgTimer;
    }
}
- (void)displayOverFlowActivityView:(NSString*)indiTitle{
	
	[self.view showHUDIndicatorViewAtCenter:indiTitle];
	
	self.dlgTimer = [NSTimerHelper scheduledTimerWithTimeInterval:HTTP_TIMEOUT 
                                                           target:self 
                                                         selector:@selector(timeOutRemoveHUDView)
                                                         userInfo:nil 
                                                          repeats:NO];
	
	return;
	
}
- (void)displayOverFlowActivityView:(NSString *)indiTitle maxShowTime:(CGFloat)time
{
    [self.view showHUDIndicatorViewAtCenter:indiTitle];
	
	if (time > 0.0f) {
        self.dlgTimer = [NSTimerHelper scheduledTimerWithTimeInterval:time 
                                                               target:self 
                                                             selector:@selector(timeOutRemoveHUDView)
                                                             userInfo:nil 
                                                              repeats:NO];
    }else{
        self.dlgTimer = nil;
    }
	
	return;
}

- (void)displayOverFlowActivityView{
	
	[self.view showHUDIndicatorViewAtCenter:L(@"loading...")];
    
	self.dlgTimer = [NSTimerHelper scheduledTimerWithTimeInterval:HTTP_TIMEOUT 
                                                           target:self 
                                                         selector:@selector(timeOutRemoveHUDView)
                                                         userInfo:nil 
                                                          repeats:NO];
	
	return;
	
}
- (void)displayOverFlowActivityView:(NSString*)indiTitle yOffset:(CGFloat)y{
	
	[self.view showHUDIndicatorViewAtCenter:indiTitle yOffset:y];
	
	self.dlgTimer = [NSTimerHelper scheduledTimerWithTimeInterval:HTTP_TIMEOUT 
                                                           target:self 
                                                         selector:@selector(timeOutRemoveHUDView)
                                                         userInfo:nil 
                                                          repeats:NO];
	
	return;
	
}
- (void)timeOutRemoveHUDView
{
    [self.view hideHUDIndicatorViewAtCenter];
}

- (void)timerOutRemoveOverFlowActivityView
{
	
	[self.view hideActivityViewAtCenter ];
	
	return;
	
	
}
- (void)removeOverFlowActivityView
{
    [self.view hideHUDIndicatorViewAtCenter];
    
    [_dlgTimer invalidate];
	
}
- (void)presentSheet:(NSString*)indiTitle
{
	
    [self.view showTipViewAtCenter:indiTitle];
}
- (void)presentSuccessLogoSheet:(NSString*)indiTitle{
	
    [self.view showSuccessTipViewAtCenter:indiTitle];
}
- (void)presentFailLogoSheet:(NSString*)indiTitle{
	
    [self.view showFailTipViewAtCenter:indiTitle];
}

- (void)presentSheet:(NSString*)indiTitle posY:(CGFloat)y{
	
    [self.view showTipViewAtCenter:indiTitle posY:y];
    
}
- (void)presentCustomDlg:(NSString*)indiTitle{
	
    BBAlertView *alert = [[BBAlertView alloc] initWithStyle:BBAlertViewStyleDefault
                                                      Title:L(@"system-info")
                                                    message:indiTitle
                                                 customView:nil
                                                   delegate:self
                                          cancelButtonTitle:L(@"Confirm")
                                          otherButtonTitles:nil];
    [alert show];

}

- (void)viewDidDisappear:(BOOL)animated{
        
    [super viewDidDisappear:animated];
    
}
- (UITableView *)tableView{
	
	if(!_tableView){
		
		_tableView = [[UITableView alloc] initWithFrame:CGRectZero
												  style:UITableViewStylePlain];    
		
		[_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
		
		[_tableView setIndicatorStyle:UIScrollViewIndicatorStyleWhite];
		
		_tableView.scrollEnabled = YES;
		
		_tableView.userInteractionEnabled = YES;
		
		_tableView.delegate =self;
		
		_tableView.dataSource =self;
		
		_tableView.backgroundColor =RGBCOLOR(225, 225, 225);
        
        _tableView.backgroundView = nil;
		
	}
	
	return _tableView;
}
- (UITableView *)groupTableView{
	
	if(!_groupTableView){
		
        _groupTableView = [[UITableView alloc] initWithFrame:CGRectZero
                                                       style:UITableViewStyleGrouped];    
		
		[_groupTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
		
		[_groupTableView setIndicatorStyle:UIScrollViewIndicatorStyleWhite];
		
		_groupTableView.scrollEnabled = YES;
		
		_groupTableView.userInteractionEnabled = YES;
		
		_groupTableView.delegate =self;
		
		_groupTableView.dataSource =self;
		
		_groupTableView.backgroundColor =[UIColor clearColor];
        
        _groupTableView.backgroundView = nil;
		
	}
	
	return _groupTableView;
}
- (TPKeyboardAvoidingTableView *)tpTableView
{
	if(!_tpTableView)
    {
		
		_tpTableView = [[TPKeyboardAvoidingTableView alloc] initWithFrame:CGRectZero
                                                                    style:UITableViewStyleGrouped];    
		
		[_tpTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
		
		[_tpTableView setIndicatorStyle:UIScrollViewIndicatorStyleWhite];
		
		_tpTableView.scrollEnabled = YES;
		
		_tpTableView.userInteractionEnabled = YES;
		
		_tpTableView.delegate =self;
		
		_tpTableView.dataSource =self;
		
		_tpTableView.backgroundColor =[UIColor clearColor];
		
        _tpTableView.backgroundView = nil;
	}
	return _tpTableView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
	return 0;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	
	return 0;	
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return nil;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    DLog(@"Commmon didReceiveMemoryWarning \n");
    
    // Release any cached data, images, etc. that aren't in use.
}
- (void)presentModalViewController:(UIViewController *)modalViewController animated:(BOOL)animated
{
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 5.0) {
        [super presentViewController:modalViewController animated:animated completion:NULL];
    }else{
        [super presentModalViewController:modalViewController animated:animated];
    }
}

- (void)canPush
{
    if ([self.navigationController.parentViewController respondsToSelector:@selector(revealGesture:)] && [self.navigationController.parentViewController respondsToSelector:@selector(revealToggle:)])
	{
		// Check if a UIPanGestureRecognizer already sits atop our NavigationBar.
		if (![[self.navigationController.navigationBar gestureRecognizers] containsObject:self.navigationBarPanGestureRecognizer])
		{
			// If not, allocate one and add it.
			UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self.navigationController.parentViewController action:@selector(revealGesture:)];
			self.navigationBarPanGestureRecognizer = panGestureRecognizer;
			
			[self.navigationController.navigationBar addGestureRecognizer:self.navigationBarPanGestureRecognizer];
		}
		
		// Check if we have a revealButton already.
		if (![self.navigationItem leftBarButtonItem])
		{
			// If not, allocate one and add it.
			UIBarButtonItem *revealButton = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Reveal", @"Reveal") style:UIBarButtonItemStylePlain target:self.navigationController.parentViewController action:@selector(revealToggle:)];
			self.navigationItem.leftBarButtonItem = revealButton;
		}
	}
}
@end
