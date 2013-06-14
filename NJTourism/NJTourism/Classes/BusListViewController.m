//
//  BusListViewController.m
//  NJTourism
//
//  Created by lyywhg on 13-6-14.
//
//

#import "BusListViewController.h"

@interface BusListViewController ()

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
#pragma mark
- (void)viewDidLoad
{
    [super viewDidLoad];
    _abApi = [[AibangApi alloc] init];
    [AibangApi setAppkey:@"f41c8afccc586de03a99c86097e98ccb"];
    _abApi.delegate = self;
    [_abApi busStatsWithCity:@"南京" Keyword:@"珠江路"];
    
    // Do any additional setup after loading the view from its nib.
}

-(void) requestDidFinishWithData:(NSData*)data aibangApi:(id)aibangApi
{
    DLog(@"msg_lyywhg:r~data%@", data);
    NSString* result1 = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
}
-(void) requestDidFailedWithError:(NSError*)error aibangApi:(id)aibangApi
{
    DLog(@"msg_lyywhg:r~error%@", error);
}

@end