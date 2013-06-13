//
//  ABGroup.m
//  FatFist
//
//  Created by lyywhg on 13-5-24.
//
//


#import "ABGroup.h"
#import "ABPerson.h"
#import "ABSource.h"

extern NSArray * WrappedArrayOfRecords( NSArray * records, Class<ABRefInitialization> class );

@implementation ABGroup

- (id) init
{
    ABRecordRef group = ABGroupCreate();
    if ( group == NULL )
    {
        [self release];
        return ( nil );
    }
    
    return ( [self initWithABRef: group] );
}

- (ABSource *) source
{
	ABRecordRef source = ABGroupCopySource( _ref );
	return ( [[[ABSource alloc] initWithABRef: source] autorelease] );
}

- (NSArray *) allMembers
{
    NSArray * members = (NSArray *) ABGroupCopyArrayOfAllMembers( _ref );
    if ( [members count] == 0 )
    {
        [members release];
        return ( nil );
    }
    
    NSArray * result = (NSArray *) WrappedArrayOfRecords( members, [ABPerson class] );
    [members release];
    
    return ( result );
}

- (NSArray *) allMembersSortedInOrder: (ABPersonSortOrdering) order
{
    NSArray * members = (NSArray *) ABGroupCopyArrayOfAllMembersWithSortOrdering( _ref, order );
    if ( [members count] == 0 )
    {
        [members release];
        return ( nil );
    }
    
    NSArray * result = (NSArray *) WrappedArrayOfRecords( members, [ABPerson class] );
    [members release];
    
    return ( result );
}

- (BOOL) addMember: (ABPerson *) person error: (NSError **) error
{
    return ( (BOOL) ABGroupAddMember(_ref, person.recordRef, (CFErrorRef *)error) );
}

- (BOOL) removeMember: (ABPerson *) person error: (NSError **) error
{
    return ( (BOOL) ABGroupRemoveMember(_ref, person.recordRef, (CFErrorRef *)error) );
}

- (NSIndexSet *) indexSetWithAllMemberRecordIDs
{
    NSArray * members = (NSArray *) ABGroupCopyArrayOfAllMembers( _ref );
    if ( [members count] == 0 )
    {
        [members release];
        return ( nil );
    }
    
    NSMutableIndexSet * mutable = [[NSMutableIndexSet alloc] init];
    for ( id person in members )
    {
        [mutable addIndex: (NSUInteger)ABRecordGetRecordID((ABRecordRef)person)];
    }
    
    [members release];
    
    NSIndexSet * result = [mutable copy];
    [mutable release];
    
    return ( [result autorelease] );
}

@end
