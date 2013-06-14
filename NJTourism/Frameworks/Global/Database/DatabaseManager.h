//
//  DatabaseManager.h
//  FatFist
//
//  Copyright 2011 FatFish. All rights reserved.
//
//

#import <Foundation/Foundation.h>

@class FMDatabaseQueue;
@interface DatabaseManager : NSObject 
{
	BOOL _isInitializeSuccess;
    
	BOOL _isDataBaseOpened;
	
	NSString *_writablePath;
    
    FMDatabaseQueue *_databaseQueue;
}

@property (nonatomic, copy) NSString *writablePath;

@property (nonatomic, retain) FMDatabaseQueue *databaseQueue;

+ (DatabaseManager*)currentManager;

- (BOOL)isDatabaseOpened;

- (void)openDataBase;

- (void)closeDataBase;


+ (void)releaseManager;


@end
