//
//  BusLineInfoViewController.m
//  NJTourism
//
//  Created by lyywhg on 13-6-22.
//
//

#import "BusLineInfoViewController.h"

@interface BusLineInfoViewController ()
@property (strong, nonatomic) NSArray *busLineInfoArray;
@end

@implementation BusLineInfoViewController

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
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSArray *)busLineInfoArray
{
    if (!_busLineInfoArray)
    {
        _busLineInfoArray = [[NSArray alloc] init];
    }
    return _busLineInfoArray;
}
- (NSDictionary *)busInfoDict
{
    if (!_busInfoDict)
    {
        _busInfoDict = [[NSDictionary alloc] init];
    }
    return _busInfoDict;
}

@end
