//
//  ContactDTO.m
//  SuningIM
//
//  Created by shasha on 13-6-6.
//
//

#import "ContactDTO.h"
#import "PhoneNumberFormatter.h"
#import "FriendListDao.h"

@interface ContactDTO (Private){
}

@end

@implementation ContactDTO

- (id)init
{
    self = [super init];
    if (self) {
        _status = eStatusInvited;
    }
    return self;
}

- (void)encodeFromABPerson:(ABPerson*)person{
    NSString *firName =  [person valueForProperty:kABPersonFirstNameProperty];
    firName = IsStrEmpty(firName)?@"":firName;
    NSString *secName =  [person valueForProperty:kABPersonMiddleNameProperty];
    secName = IsStrEmpty(secName)?@"":secName;
    NSString *lastName =  [person valueForProperty:kABPersonLastNameProperty];
    lastName = IsStrEmpty(lastName)?@"":lastName;
    NSString *name = [NSString stringWithFormat:@"%@%@%@",firName,secName,lastName];
    self.userName = name;
}

- (void)setJid:(NSString *)jid{
    if (_jid != jid) {
        _jid = nil;
        _jid = jid;
        
        if (IsStrEmpty(_jid)) {
            _status = eStatusInvited;
             FriendListDao *dao = [[FriendListDao alloc] init];
            FriendInfoDTO *dto = [[FriendInfoDTO alloc ] init];
            dto.userId = jid;
            BOOL *isExist = [[dao  OperateFriendInfoDB:dto
                                            operateIndex:IsFriendInfoExistedType] boolValue];
            if (!isExist) {
                _status = eStatusUnAdd;
            }else{
                _status = eStatusAdded;
            }
        
        }        
    }
}

@end
