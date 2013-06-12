//
//  ContactListViewController.h
//  SuningIM
//
//  Created by shasha on 13-6-4.
//
//

#import "CommonViewController.h"
#import "AddressBook.h"
#import "VerifyService.h"
#import "ContactCell.h"



@interface ContactListViewController : CommonViewController
<ABAddressBookDelegate,VerifyServiceDelegate,ContactCellDelegate>

@end
