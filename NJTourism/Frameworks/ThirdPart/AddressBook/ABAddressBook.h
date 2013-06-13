//
//  ABAddressBook.h
//  FatFist
//
//  Created by lyywhg on 13-5-24.
//
//

#import <Foundation/Foundation.h>
#import <AddressBook/ABAddressBook.h>
#import "ABRefInitialization.h"

@class ABRecord, ABPerson, ABGroup, ABSource;
@protocol ABAddressBookDelegate;

extern NSString *ABAddressBookDidChangeNotification;

enum
{
    ABOperationNotPermittedByStoreError = kABOperationNotPermittedByStoreError
    
};

@interface ABAddressBook : NSObject <ABRefInitialization>
{
    ABAddressBookRef            _ref;
    id<ABAddressBookDelegate>   _delegate;
}

+ (ABAddressBook *) sharedAddressBook;

@property (nonatomic, readonly, getter=getAddressBookRef) ABAddressBookRef addressBookRef;

@property (nonatomic, assign) id<ABAddressBookDelegate> delegate;

- (BOOL) save: (NSError **) error;
@property (nonatomic, readonly) BOOL hasUnsavedChanges;

- (BOOL) addRecord: (ABRecord *) record error: (NSError **) error;
- (BOOL) removeRecord: (ABRecord *) record error: (NSError **) error;

- (NSString *) localizedStringForLabel: (NSString *) labelName;

- (void) revert;

@end

@interface ABAddressBook (People)

@property (nonatomic, readonly) NSUInteger personCount;

- (ABPerson *) personWithRecordID: (ABRecordID) recordID;
- (ABPerson *) personWithRecordRef:(ABRecordRef) recordRef;
- (NSArray *) allPeople;
- (NSArray *) allPeopleSorted;
- (NSArray *) allPeopleWithName: (NSString *) name;

@end

@interface ABAddressBook (Groups)

@property (nonatomic, readonly) NSUInteger groupCount;

- (ABGroup *) groupWithRecordID: (ABRecordID) recordID;
- (NSArray *) allGroups;

@end

@interface ABAddressBook (Sources)

- (ABSource *) sourceWithRecordID: (ABRecordID) recordID;
- (ABSource *) defaultSource;
- (NSArray *) allSources;

@end

@protocol ABAddressBookDelegate <NSObject>
- (void) addressBookDidChange: (ABAddressBook *) addressBook;
@end
