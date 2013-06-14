//
//  ABPerson.m
//  FatFist
//
//  Copyright 2011 FatFish. All rights reserved.
//
//

#import "ABPerson.h"
/*
 Notes：
 added by lyywhg
 */
#import "PhoneNumberFormatter.h"
#import "ABMultiValue.h"

@implementation ABPerson

+ (ABPropertyType) typeOfProperty: (ABPropertyID) property
{
    return ( ABPersonGetTypeOfProperty(property) );
}

+ (NSString *) localizedNameOfProperty: (ABPropertyID) property
{
    NSString * name = (NSString *) ABPersonCopyLocalizedPropertyName(property);
    return ( [name autorelease] );
}

+ (ABPersonSortOrdering) sortOrdering
{
    return ( ABPersonGetSortOrdering() );
}

+ (ABPersonCompositeNameFormat) compositeNameFormat
{
    return ( ABPersonGetCompositeNameFormat() );
}

- (id) init
{
    ABRecordRef person = ABPersonCreate();
    if ( person == NULL )
    {
        [self release];
        return ( nil );
    }
    
    return ( [self initWithABRef: person] );
}

- (NSString*) description 
{
    return [NSString stringWithFormat: @"ABPerson %d - %@",[self recordID], [self compositeName]];
}

- (BOOL) setImageData: (NSData *) imageData error: (NSError **) error
{
    return ( (BOOL) ABPersonSetImageData(_ref, (CFDataRef)imageData, (CFErrorRef *)error) );
}

- (NSData *) imageData
{
    NSData * imageData = (NSData *) ABPersonCopyImageData( _ref );
    return ( [imageData autorelease] );
}

- (NSData *) thumbnailImageData
{
    NSData * imageData = (NSData *) ABPersonCopyImageDataWithFormat( _ref, kABPersonImageFormatThumbnail );
    return ( [imageData autorelease] );
}

- (BOOL) hasImageData
{
    return ( (BOOL) ABPersonHasImageData(_ref) );
}

- (BOOL) removeImageData: (NSError **) error
{
    return ( (BOOL) ABPersonRemoveImageData(_ref, (CFErrorRef *)error) );
}

- (NSComparisonResult) compare: (ABPerson *) otherPerson
{
    return ( [self compare: otherPerson sortOrdering: ABPersonGetSortOrdering()] );
}

- (NSComparisonResult) compare: (ABPerson *) otherPerson sortOrdering: (ABPersonSortOrdering) order
{
    return ( (NSComparisonResult) ABPersonComparePeopleByName(_ref, otherPerson->_ref, order) );
}

-(NSString*)getFirstName
{
	return [self valueForProperty:kABPersonFirstNameProperty];
}

-(NSString*)getLastName
{
	NSString * lastName = [self valueForProperty:kABPersonLastNameProperty];

	if(lastName == nil)
	{
		lastName = [self compositeName];
	}
	
	return lastName;
}

- (NSArray *)phoneNumArr{
    
    NSMutableArray *phoneArr = [[NSMutableArray alloc] init];
    
    ABMultiValue *phoneNumMultiValue = [self valueForProperty:kABPersonPhoneProperty];
    int count = [phoneNumMultiValue count];
    
    for (int i = 0; i < count; i++) {
        @autoreleasepool {
            NSString *phoneNumStr = (NSString *)[phoneNumMultiValue valueAtIndex:i];
            
            PhoneNumberFormatter *formatter = [[PhoneNumberFormatter alloc] init];
            id objectValue;
            [formatter getObjectValue:&objectValue forString:phoneNumStr
                     errorDescription:nil];
            phoneNumStr = (NSString *)objectValue;
            if (IsStrEmpty(phoneNumStr)) {
                continue;
            }
            
            [phoneArr addObject:phoneNumStr];
            
            TT_RELEASE_SAFELY(formatter);
        }
        
    }
    return phoneArr;
}

@end
