//
//  DAO.h
//  FatFist
//
//  Created by lyywhg on 13-5-24.
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

