//
//  ContactDTO.h
//  SuningIM
//
//  Created by shasha on 13-6-6.
//
//

#import "BaseHttpDTO.h"
#import "AddressBook.h"

typedef enum{

    eStatusUnAdd,
    eStatusAdded,
    eStatusInvited,
    
} E_PhoneStatus;

@interface ContactDTO : BaseHttpDTO

@property (nonatomic, strong) NSString          *userName;
@property (nonatomic, strong) NSString          *phoneNum;
@property (nonatomic, strong) NSString          *jid;
@property (nonatomic, assign ,readonly)         E_PhoneStatus   status;

- (void)encodeFromABPerson:(ABPerson*)person;

- (void)setJid:(NSString *)jid;

@end
