//
//  SearchEntertainmentViewController.m
//  NJTourism
//
//  Created by lyywhg on 13-6-22.
//
//

#import "SearchEntertainmentViewController.h"

#import "AibangApi.h"

@interface SearchEntertainmentViewController ()
@property (strong, nonatomic) AibangApi *abApi;
@end

@implementation SearchEntertainmentViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self canPush];
    [self searchEnter];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (AibangApi *)abApi
{
    if (!_abApi)
    {
        _abApi = [[AibangApi alloc] init];
        _abApi.delegate = self;
        [AibangApi setAppkey:@"f946549e05f316f49ba667d9629ea1e3"];
    }
    return _abApi;
}
- (void)requestDidFinishWithDictionary:(NSDictionary *)dict aibangApi:(id)aibangApi
{
    [self removeOverFlowActivityView];
    
}
- (void)requestDidFailedWithError:(NSError*)error aibangApi:(id)aibangApi
{
    DLog(@"msg_lyywhg:r~error%@", error);
    [self removeOverFlowActivityView];
}

- (void)searchEnter
{
    [self.abApi searchBizWithCity:@"南京"
                            Query:@"饭店"
                          Address:@"珠江路"
                         Category:nil
                              Lng:nil
                              Lat:nil
                           Radius:@"5000"
                         Rankcode:@"0"
                             From:@"1"
                               To:@"10"];
}

@end
