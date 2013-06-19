//
//  TaxiViewController.m
//  NJTourism
//
//  Created by lyywhg on 13-6-14.
//
//

#import "TaxiViewController.h"

#import "FindNearbyTaxi.h"

@interface TaxiViewController ()

@end

@implementation TaxiViewController

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
    
    FindNearbyTaxi *findTaxi = [[FindNearbyTaxi alloc] init];
    [findTaxi createFolderWithFolderInfo:nil];
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
