/**
    UpgradeService.h
    UpgradeService.h
    Created by wangman on 13-5-4.
      Copyright (c) 2013年 suning. All rights reserved.
 */

#import "DataService.h"
#import "DataService.h"

@protocol VersionUpgradeServiceDelegate <NSObject>
@optional

- (void)versionUpgradeCompletedWithResult:(BOOL)isSuccess
                               errorMsg:(NSString *)errorMsg;

@end


@interface VersionUpgradeService : DataService
@property (nonatomic, assign) id<VersionUpgradeServiceDelegate>  delegate;

- (void)beginVersionUpgradeRequest;

@end
