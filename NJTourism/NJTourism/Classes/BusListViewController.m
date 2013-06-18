//
//  BusListViewController.m
//  NJTourism
//
//  Created by lyywhg on 13-6-14.
//
//

#import "BusListViewController.h"

#import "BusSelectScrollView.h"

@interface BusListViewController ()

@property (strong, nonatomic) BusSelectScrollView *busSelectScrollView;
@property (strong, nonatomic, readonly) AibangApi *abApi;

@end

@implementation BusListViewController
#pragma mark-
#pragma mark Init & Dealloc
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        // Custom initialization
    }
    return self;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark-
#pragma mark Init & Add
- (BusSelectScrollView *)busSelectScrollView
{
    if (!_busSelectScrollView)
    {
        _busSelectScrollView = [[BusSelectScrollView alloc] init];
        _busSelectScrollView.backgroundColor = [UIColor clearColor];
        _busSelectScrollView.frame = CGRectMake(0, 80, 960, 240);
        [self.view addSubview:_busSelectScrollView];
    }
    return _busSelectScrollView;
}
#pragma mark-
#pragma mark View Method
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self canPush];
    
    self.busSelectScrollView.contentSize = CGSizeMake(0, 0);
    [self.busSelectScrollView setAllFrames];
    
    _abApi = [[AibangApi alloc] init];
    [AibangApi setAppkey:@"f41c8afccc586de03a99c86097e98ccb"];
    _abApi.delegate = self;
    [_abApi busStatsWithCity:@"南京" Keyword:@"珠江路"];
}
#pragma mark-
#pragma mark Delegate
-(void) requestDidFinishWithDictionary:(NSDictionary *)dict aibangApi:(id)aibangApi
{
    DLog(@"msg_lyywhg:r~data%@", dict);
}
-(void) requestDidFailedWithError:(NSError*)error aibangApi:(id)aibangApi
{
    DLog(@"msg_lyywhg:r~error%@", error);
}
- (void)viewDidUnload
{
    [super viewDidUnload];
}
@end
