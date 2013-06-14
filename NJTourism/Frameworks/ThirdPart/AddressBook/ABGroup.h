//
//  ABGroup.h
//  FatFist
//
//  Copyright 2011 FatFish. All rights reserved.
//
//


#import <Foundation/Foundation.h>
#import <AddressBook/ABGroup.h>
#import "ABRecord.h"

@class ABPerson;
@class ABSource;

@interface ABGroup : ABRecord

// use -init to create a new group

@property (nonatomic, readonly) ABSource *source;

- (NSArray *) allMembers;
- (NSArray *) allMembersSortedInOrder: (ABPersonSortOrdering) order;

- (BOOL) addMember: (ABPerson *) person error: (NSError **) error;
- (BOOL) removeMember: (ABPerson *) person error: (NSError **) error;

- (NSIndexSet *) indexSetWithAllMemberRecordIDs;

@end
