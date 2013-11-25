//
//  BusInfoViewController.h
//  NJTourism
//
//  Created by lyywhg on 13-6-22.
//
//

#import "CommonViewController.h"

@interface ChangeBusLineListViewController : CommonViewController

@property (strong, nonatomic) NSArray *busesArray;
@property (strong, nonatomic) NSMutableArray *busesLineArray;

@property (strong, nonatomic) NSString *startString;
@property (strong, nonatomic) NSString *endString;

@end
