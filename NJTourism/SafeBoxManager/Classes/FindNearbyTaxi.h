//
//  FindNearbyTaxi.h
//  FatFish
//
//  Created by lyywhg on 13-4-1.
//  Copyright (c) 2013年 suning. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DataService.h"

@protocol FolderCreateDelegate <NSObject>

- (void)folderCreateCompletedWithResult:(BOOL)isSuccess
                         errorMsg:(NSString *)errorMsg;
@end

@interface FindNearbyTaxi : DataService

@property (nonatomic, weak) id<FolderCreateDelegate> folderCreateDelegate;

- (void)createFolderWithFolderInfo:(NSString *)folderDto;

@end
