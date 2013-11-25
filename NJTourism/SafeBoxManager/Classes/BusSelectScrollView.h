//
//  BusSelectScrollView.h
//  NJTourism
//
//  Created by lyywhg on 13-6-17.
//
//

#import <UIKit/UIKit.h>

#import "ChangeBusView.h"
#import "BusLineView.h"
#import "BusStationView.h"

@interface BusSelectScrollView : UIScrollView

@property (strong, nonatomic) ChangeBusView *changeBusView;
@property (strong, nonatomic) BusLineView *busLineView;
@property (strong, nonatomic) BusStationView *busStationView;

- (void)setAllFrames;

@end
