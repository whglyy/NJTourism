//
//  DAO.h
//  FatFist
//
//  Copyright 2011 FatFish. All rights reserved.
//
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"
#import "FMDatabaseAdditions.h"
#import "FMDatabaseQueue.h"

@interface DAO : NSObject {
@protected
    FMDatabaseQueue	*_databaseQueue;
}
       
@end

@interface DAO()

@property (nonatomic,retain) FMDatabaseQueue *databaseQueue;

+ (void)createTablesNeeded;

@end

