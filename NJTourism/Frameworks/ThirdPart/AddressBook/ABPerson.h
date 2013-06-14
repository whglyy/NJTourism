//
//  ABPerson.h
//  FatFist
//
//  Copyright 2011 FatFish. All rights reserved.
//
//

#import <Foundation/Foundation.h>
#import <AddressBook/ABPerson.h>
#import "ABRecord.h"

@interface ABPerson : ABRecord

// use -init to create a new person
@property (readonly, getter = getFirstName) NSString * firstName;
@property (readonly, getter = getLastName) NSString * lastName;

/*
 Notes：
 added by lyywhg
 */
@property (nonatomic, readonly) NSArray  *phoneNumArr;

+ (ABPropertyType) typeOfProperty: (ABPropertyID) property;
+ (NSString *) localizedNameOfProperty: (ABPropertyID) property;
+ (ABPersonSortOrdering) sortOrdering;
+ (ABPersonCompositeNameFormat) compositeNameFormat;

- (BOOL) setImageData: (NSData *) imageData error: (NSError **) error;
- (NSData *) imageData;
- (NSData *) thumbnailImageData;
@property (nonatomic, readonly) BOOL hasImageData;
- (BOOL) removeImageData: (NSError **) error;

- (NSComparisonResult) compare: (ABPerson *) otherPerson;
- (NSComparisonResult) compare: (ABPerson *) otherPerson sortOrdering: (ABPersonSortOrdering) order;


@end
