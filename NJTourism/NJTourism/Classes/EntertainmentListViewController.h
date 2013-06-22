//
//  EntertainmentListViewController.h
//  NJTourism
//
//  Created by lyywhg on 13-6-23.
//
//

#import "CommonViewController.h"

@interface EntertainmentListViewController : CommonViewController<AibangApiDelegate>

@property (strong, nonatomic) NSArray *entertainmentList;

@end
