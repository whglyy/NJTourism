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
        [self addSubview:_changeBusView];
    }
    return _changeBusView;
}
- (BusLineView *)busLineView
{
    if (!_busLineView)
    {
        _busLineView = [[BusLineView alloc] init];
        [self addSubview:_busLineView];
    }
    return _busLineView;
}
- (BusStationView *)busStationView
{
    if (!_busStationView)
    {
        _busStationView = [[BusStationView alloc] init];
        [self addSubview:_busStationView];
    }
    return _busStationView;
}

- (void)setAllFrames
{
    self.changeBusView.frame = CGRectMake(40, 20, 260, 200);
    [self.changeBusView setAllFrame];
    self.busLineView.frame = CGRectMake(360, 20, 260, 150);
    [self.busLineView setAllFrame];
    self.busStationView.frame = CGRectMake(680, 20, 260, 150);
    [self.busStationView setAllFrame];
}

@end
