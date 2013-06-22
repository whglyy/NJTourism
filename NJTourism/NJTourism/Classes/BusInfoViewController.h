//
//  BusInfoViewController.h
//  NJTourism
//
//  Created by lyywhg on 13-6-22.
//
//

#import "CommonViewController.h"

@interface BusInfoViewController : CommonViewController

@property (strong, nonatomic) NSDictionary *busDict;

@property (nonatomic, retain) NSMutableArray *questionsArray;
@property (nonatomic, retain) NSArray *answerArray;

@end
