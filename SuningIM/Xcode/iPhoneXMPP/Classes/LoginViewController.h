//
//  LoginViewController.h
//  SuningIM
//
//  Created by zhaojw on 5/8/13.
//
//

#import <UIKit/UIKit.h>
#import "CommonViewController.h"
#import "TabBarViewController.h"
#import "LoginService.h"
#import "AppDelegate.h"

@interface LoginViewController:CommonViewController <UITextFieldDelegate,LoginServiceDelegate>
@property (retain, nonatomic)LoginService *service;
@property (weak, nonatomic) IBOutlet UITextField *userNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

- (IBAction)loginBtnClicked:(id)sender;
- (IBAction)registerBtnClicked:(id)sender;
- (IBAction)hideKeyboard:(id)sender;
@end
