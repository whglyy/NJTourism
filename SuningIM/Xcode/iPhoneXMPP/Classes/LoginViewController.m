//
//  LoginViewController.m
//  SuningIM
//
//  Created by zhaojw on 5/8/13.
//
//

#import "LoginViewController.h"
#import "RegisterViewController.h"
#import "TabBarViewController.h"
#import "AppDelegate.h"
#import "NetRequestAlert.h"
@interface LoginViewController ()

@end

@implementation LoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        _service = [[LoginService alloc]init];
        _service.delegate = self;
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}

- (IBAction)loginBtnClicked:(id)sender {
    //点击登陆按钮后切换到storyboard界面
    
    NSString *username =self.userNameTextField.text;
    
    if (([NetRequestAlert isStringNull:username])) {
        [self presentSheet:L(@"please input username")];        
        return;
    }
    
//    //用户名正确
//    if (![NetRequestAlert isRightPhone:username] && ![NetRequestAlert isEmail:username])
//    {
//        [self presentSheet:L(@"input correct username")];
//        return;
//    }
    NSString *password = self.passwordTextField.text;
    if (([NetRequestAlert isStringNull:password]))
    {
        [self presentSheet:L(@"please input pasword")];
        return;
    }
//    if ( ([NetRequestAlert isHaveChinese:password] || [NetRequestAlert isHaveSpace:password] ||[NetRequestAlert isHaveCharacter:password]) )
//    {
//        [self presentSheet:L(@"illeagal chars") ];
//        return;
//    }
//    if ([NetRequestAlert isAllSameChars:password] || [NetRequestAlert hasAllIncreaseChars:password] || [NetRequestAlert hasAllDecreaseChars:password])
//    {
//        [self presentSheet:L(@"passwd cannot be one num")];
//        return;
//    }
    
    self.navigationItem.rightBarButtonItem.enabled = NO;
    [self displayOverFlowActivityView];
    [self removeOverFlowActivityView];
    [self.service beginLoginRequestWithUserName:self.userNameTextField.text passWord:self.passwordTextField.text];
    
}

- (void)LoginCompletedWithResult:(BOOL)isSuccess errorMsg:(NSString *)errorMsg
{
    if (isSuccess)
    {
        [self dismissModalViewControllerAnimated:YES];
        
        //建表
        [DAO createTablesNeeded];
        
        [[AppDelegate currentAppDelegate].xmppManager.xmppStream addDelegate:self delegateQueue:dispatch_get_current_queue()];
    }
    else
    {
        self.passwordTextField.text = @"";
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == self.userNameTextField){
    // Move input focus to the password field.
    [self.passwordTextField becomeFirstResponder];
    }
   else{
    // Simulate clicking the Submit button.
  //  [self loginBtnClicked:nil];
    }
   return YES;
}

- (IBAction)registerBtnClicked:(id)sender{
    RegisterViewController *registerController = [[RegisterViewController alloc] initWithNibName:@"RegisterViewController" bundle:nil];
	[self presentModalViewController:registerController animated:YES];
    TT_RELEASE_SAFELY(registerController);
}

- (IBAction)hideKeyboard:(id)sender{
    [sender resignFirstResponder];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setUserNameTextField:nil];
    [self setPasswordTextField:nil];
    [super viewDidUnload];
}

@end
