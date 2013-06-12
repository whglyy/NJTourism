//
//  RegisterViewController.h
//  SuningIM
//
//  Created by wangbao on 13-5-27.
//
//

#import <UIKit/UIKit.h>
#import "RegisterService.h"
#import "CommonViewController.h"
#import "NetRequestAlert.h"
#import "keyboardNumberPadReturnTextField.h"

@interface RegisterViewController : CommonViewController<RegisterServiceDelegate, UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet UITextField *nameField;
@property (strong, nonatomic) IBOutlet UITextField *passwordField;
@property (strong, nonatomic) IBOutlet UITextField *verificationCode;
@property (strong, nonatomic) IBOutlet UIButton *getvcode;
@property (strong, nonatomic) IBOutlet UIButton *doregister;

@property (nonatomic, retain) NSTimer *counterTimer;

@property (nonatomic, assign) UIBackgroundTaskIdentifier backgroundTimerIdentifier;
@property (nonatomic, retain) RegisterService *registerService;
@end
