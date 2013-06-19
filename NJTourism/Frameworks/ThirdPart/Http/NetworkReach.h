//
//  NetworkReach.h
//  Dtouching
//
//  Created by 刘坤 on 12-5-12.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Reachability;

@interface NetworkReach : NSObject

@property (nonatomic, readonly) BOOL      isNetReachable;
@property (nonatomic, readonly) BOOL      isHostReach;
@property (nonatomic, readonly) BOOL      isInternetReach;
@property (nonatomic, readonly) BOOL      isWifiReach;
@property (nonatomic, readonly) NSInteger reachableCount;

- (void)initNetwork;
- (void)showNetworkAlertMessage;

@end
