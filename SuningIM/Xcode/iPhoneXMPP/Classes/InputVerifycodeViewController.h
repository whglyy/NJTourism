//
//  InputVerifycodeViewController.h
//  SuningIM
//
//  Created by wangbao on 13-6-3.
//
//

#import <UIKit/UIKit.h>
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>
#import "VerifyService.h"
@interface InputVerifycodeViewController : UIViewController<VerifyServiceDelegate>
{
}
@property (retain, nonatomic)VerifyService *service;

@property (strong, nonatomic) IBOutlet UITextField *verifyCode;
@property (nonatomic, retain) NSString *jid;
@property (nonatomic, retain) NSString *password;
@property (nonatomic, retain) NSString *phoneNos;

@end
