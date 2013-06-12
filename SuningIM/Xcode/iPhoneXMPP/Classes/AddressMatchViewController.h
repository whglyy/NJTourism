//
//  AddressMatchViewController.h
//  SuningIM
//
//  Created by wangbao on 13-6-3.
//
//

#import <UIKit/UIKit.h>
#import "VerifyService.h"

@interface AddressMatchViewController : CommonViewController<VerifyServiceDelegate>

@property (strong, nonatomic) IBOutlet UITextField *phoneNo;
@property (nonatomic, retain) NSString *jid;
@property (strong, nonatomic) UITextField *tmp;

@property (nonatomic, strong) VerifyService  *service;

- (IBAction)next:(id)sender;

@end
