//
//  BusSelectScrollView.m
//  NJTourism
//
//  Created by lyywhg on 13-6-17.
//
//

#import "BusSelectScrollView.h"

@implementation BusSelectScrollView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        // Initialization code
    }
    return self;
}
#pragma mark-
#pragma mark Init & Add
- (ChangeBusView *)changeBusView
{
    if (!_changeBusView)
    {
        _changeBusView = [[ChangeBusView alloc] init];
    }
    return _changeBusView;
}
- (BusLineView *)busLineView
{
    if (!_busLineView)
    {
        _busLineView = [[BusLineView alloc] init];
    }
    return _busLineView;
}
- (BusStationView *)busStationView
{
    if (!_busStationView)
    {
        _busStationView = [[BusStationView alloc] init];
    }
    return _busStationView;
}

@end
