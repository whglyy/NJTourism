//
//  LoginViewController.m
//  SuningEBuy
//
//  Created by 王漫 on 12-8-16.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "LoginViewEXController.h"
#import "RegisterViewController.h"
//#import "RetrievePasswordViewController.h"
#import "AuthManagerNavViewController.h"
//#import "AccountValidateViewController.h"
#import "AppDelegate.h"
#import "UserCenter.h"
#import "LogOutCommand.h"
#import "NetRequestAlert.h"

@interface LoginViewEXController()

- (void)userRegister:(id)sender;

@end

/*********************************************************************/

@implementation LoginViewEXController

@synthesize service = _service;

@synthesize nextNavigationController = _nextNavigationController;
@synthesize nextController = _nextController;

@synthesize loginDelegate = _loginDelegate;
@synthesize loginDidOkSelector = _loginDidOkSelector;
@synthesize loginDidCancelSelector = _loginDidCancelSelector;

- (void)dealloc {
 

    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}



- (id)init {
    self = [super init];
    if (self) {
        self.title = L(@"User Login");
//        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshUserName:) name:POPUP_MESSAGE object:nil];
//        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(logout:) name:BACK_HOME object:nil];
   }
    return self;
}

- (void)logout:(NSNotification *)notification{
    self.pwdField.text = nil;
    [self.pwdField becomeFirstResponder];
    [Config currentConfig].autoLogin = [NSNumber numberWithBool:NO];
    [self.confirmBtn setImage:[UIImage streImageNamed:@"sncloud_disk_bt_grey_pressed.png"]
                     forState:UIControlStateNormal];

    
}


- (UITableView*)keyTableView
{
    if(nil == _keyTableView)
    {
		_keyTableView = [[TPKeyboardAvoidingTableView alloc] initWithFrame:CGRectZero
                                                                     style:UITableViewStylePlain];
		[_keyTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
		[_keyTableView setIndicatorStyle:UIScrollViewIndicatorStyleWhite];
		_keyTableView.scrollEnabled = YES;
		_keyTableView.userInteractionEnabled = YES;
		_keyTableView.delegate =self;
		_keyTableView.dataSource =self;
		_keyTableView.backgroundColor =[UIColor clearColor];
	}
	return _keyTableView;
}
- (UILabel *)titleLabel
{
    if (!_titleLabel)
    {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.text = L(@"登录苏宁云盘");
        _titleLabel.frame = CGRectMake(0, 35, self.view.frame.size.width, 30);
        _titleLabel.font = [UIFont systemFontOfSize:25];
        _titleLabel.backgroundColor =[UIColor clearColor];
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.shadowColor = RGBCOLOR(160, 170, 202);
        _titleLabel.shadowOffset = CGSizeMake(0.5, 0.5);
        _titleLabel.textAlignment = UITextAlignmentCenter;
    }
    return _titleLabel;
}
- (UIImageView*)nameBackImage
{
    if (nil == _nameBackImage)
    {
        _nameBackImage = [[UIImageView alloc] initWithFrame:CGRectMake(35, self.titleLabel.bottom +30, 250, 72)];
        _nameBackImage.backgroundColor = [UIColor whiteColor];
        _nameBackImage.layer.cornerRadius = 3;
        _nameBackImage.userInteractionEnabled = YES;
        [_nameBackImage addSubview:self.accountField];
        [_nameBackImage addSubview:self.pwdField];
        
        UILabel *tmpLabel = [[UILabel alloc] init];
        tmpLabel.backgroundColor = RGBCOLOR(218.0, 218.0, 218.0);
        tmpLabel.frame = CGRectMake(0, 35, 250, 2);
        [_nameBackImage addSubview:tmpLabel];
        TT_RELEASE_SAFELY(tmpLabel);
        
        UIImageView *userIV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"sncloud_disk_ic_input_username.png"]];
        userIV.frame =CGRectMake(3, 8, 19, 19);
        UIImageView *pwdIV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"sncloud_disk_ic_input_key"]];
        pwdIV.frame = CGRectMake(3, 44, 19, 19);
        [_nameBackImage addSubview:userIV];
        [_nameBackImage addSubview:pwdIV];
        TT_RELEASE_SAFELY(userIV);
        TT_RELEASE_SAFELY(pwdIV);
    }
    return _nameBackImage;
}

- (UITextField*)accountField
{
    if (nil == _accountField)
    {
        _accountField = [[UITextField alloc] initWithFrame:CGRectMake(25, 0, 220, 35)];
        _accountField.placeholder = L(@"请输入用户名");
        _accountField.backgroundColor = [UIColor clearColor];
        _accountField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        _accountField.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        _accountField.borderStyle = UIKeyboardTypeEmailAddress;
        _accountField.autocapitalizationType = UITextAutocapitalizationTypeNone;
        _accountField.delegate = self;
        _accountField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _accountField.returnKeyType = UIReturnKeyDone;
        _accountField.textAlignment = UITextAlignmentLeft;
    }
    return _accountField;
}

- (UITextField*)pwdField
{
    if (nil == _pwdField)
    {
        _pwdField = [[UITextField alloc] initWithFrame:CGRectMake(25, 37, 220, 35)];
        _pwdField.placeholder = L(@"请输入密码");
        _pwdField.backgroundColor = [UIColor clearColor];
        _pwdField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        _pwdField.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        _pwdField.borderStyle = UIKeyboardTypeEmailAddress;
        _pwdField.autocapitalizationType = UITextAutocapitalizationTypeNone;
        _pwdField.secureTextEntry = YES;
        _pwdField.delegate = self;
        _pwdField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _pwdField.returnKeyType = UIReturnKeyDone;
        _pwdField.textAlignment = UITextAlignmentLeft;
    }
    return _pwdField;
}

- (UIButton*)confirmBtn
{
    if (!_confirmBtn)
    {
        _confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _confirmBtn.frame = CGRectMake(35, self.nameBackImage.bottom+10, 20, 20);
        [_confirmBtn addTarget:self action:@selector(confirmAction)
              forControlEvents:UIControlEventTouchUpInside];
        if ([[Config currentConfig].autoLogin boolValue]) {
             [_confirmBtn setImage:[UIImage streImageNamed:@"sncloud_disk_bt_grey_selected.png"]
                          forState:UIControlStateNormal];
        }else{
               [_confirmBtn setImage:[UIImage streImageNamed:@"sncloud_disk_bt_grey_pressed.png"]
                            forState:UIControlStateNormal];
        }
     
        _confirmBtn.backgroundColor = [UIColor clearColor];
    }
    return _confirmBtn;
}

- (UILabel *)confirmLabel
{
    if (!_confirmLabel)
    {
        _confirmLabel = [[UILabel alloc] initWithFrame:
                         CGRectMake(80, self.nameBackImage.bottom+10, 240, 20)];
        _confirmLabel.text = L(@"自动登录");
        _confirmLabel.font = [UIFont systemFontOfSize:14.0];
        _confirmLabel.backgroundColor = [UIColor clearColor];
        _confirmLabel.textColor = [UIColor whiteColor];
        _confirmLabel.userInteractionEnabled = YES;
    }
    return _confirmLabel;
}


- (void)confirmAction
{
    BOOL flag = ! [[Config currentConfig].autoLogin boolValue];
    [Config currentConfig].autoLogin = [NSNumber numberWithBool:flag];
    
    if ([[Config currentConfig].autoLogin boolValue] == TRUE)
    {
        [self.confirmBtn setImage:[UIImage streImageNamed:@"sncloud_disk_bt_grey_selected.png"]
                         forState:UIControlStateNormal];
    }
    else
    {
        [self.confirmBtn setImage:[UIImage streImageNamed:@"sncloud_disk_bt_grey_pressed.png"]
                         forState:UIControlStateNormal];
    }
}



- (UIButton*)regBtn
{
    if (!_regBtn)
    {
        _regBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _regBtn.frame = CGRectMake(35, self.confirmBtn.bottom+10, 115, 38);
        [_regBtn setTitleColor:RGBCOLOR(8, 40, 121) forState:UIControlStateNormal];
        _regBtn.titleLabel.shadowColor = [UIColor whiteColor];
        _regBtn.titleLabel.shadowOffset = CGSizeMake(0, 0);
        [_regBtn setBackgroundImage:[UIImage streImageNamed:@"sncloud_grey_normal.png"] forState:UIControlStateNormal];
        [_regBtn setTitle:@"注     册" forState:UIControlStateNormal];
        [_regBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:18.0f]];
        _regBtn.backgroundColor = [UIColor clearColor];
        _regBtn.layer.cornerRadius = 4.0;
        [_regBtn addTarget:self action:@selector(userRegister:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _regBtn;
}
- (UIButton*)logBtn
{
    if (!_logBtn)
    {
        _logBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _logBtn.frame = CGRectMake(self.regBtn.right +20, self.regBtn.top, 115, 38);
        [_logBtn setTitleColor:RGBCOLOR(8, 40, 121) forState:UIControlStateNormal];
        _logBtn.titleLabel.shadowColor = [UIColor whiteColor];
        _logBtn.titleLabel.shadowOffset = CGSizeMake(0, 0);
        [_logBtn setBackgroundImage:[UIImage streImageNamed:@"sncloud_grey_normal.png"]
                           forState:UIControlStateNormal];
        [_logBtn setTitle:@"登     录" forState:UIControlStateNormal];
        [_logBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:18.0f]];
        _logBtn.backgroundColor = [UIColor clearColor];
        _logBtn.layer.cornerRadius = 4.0;
        [_logBtn addTarget:self action:@selector(login:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _logBtn;
}



- (void)refreshUserName:(NSNotification *)notification
{
    NSDictionary *userInfo = [notification object];
    
    self.accountField.text = [userInfo objectForKey:@"username"];
    
  self.pwdField.text = [userInfo objectForKey:@"password"];
    
}

- (void)registerOKHeadler
{
    LogOutCommand *manage =
    [[LogOutCommand alloc]init];;
    [manage excute];
    
    if(_nextController && _nextNavigationController)
    {
        [_nextNavigationController pushViewController:self.nextController animated:YES];
    }
    
    if (self.loginDelegate && [self.loginDelegate respondsToSelector:self.loginDidOkSelector]) {
        [self.loginDelegate performSelector:self.loginDidOkSelector];
    }
    
    [self dismissModalViewControllerAnimated:YES];
    
}

#pragma mark -
#pragma mark view life cycle

- (void)loadView
{
    [super loadView];
    
    self.keyTableView.frame = CGRectMake(0, 0, 320, 440);
    [self.view addSubview:self.keyTableView];
    
    
}

- (void)viewWillAppear:(BOOL)animated
{
    
    NSString *username = [Config currentConfig].lastUserId;
    self.accountField.text = username;
    if ([[Config currentConfig].autoLogin boolValue]) {
        self.pwdField.text = [Config currentConfig].password;
    }
    
	self.navigationItem.hidesBackButton = NO;
    self.navigationController.navigationBarHidden = YES;
	[super viewWillAppear:animated];
    
}

- (void)autoLogin
{
    if ([[Config currentConfig].autoLogin boolValue]) {
        [self displayOverFlowActivityView];
        [self.service beginLoginRequestWithUserName:[Config currentConfig].userId passWord:[Config currentConfig].password];
    }
    
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self autoLogin];
}


#pragma mark -
#pragma mark action

- (void)login:(id)sender
{
    
    if ([Config currentConfig].autoLogin)
    {
        [Config currentConfig].userId = self.accountField.text;
        [Config currentConfig].password = self.pwdField.text;
    }
    [Config currentConfig].savePassword = [NSNumber numberWithBool:YES];//记住密码
    
    NSString *username =self.accountField.text;
	
	NSString *errMessage = nil;
	
    if (!username || [username isEmptyOrWhitespace])
    {
        [self.accountField becomeFirstResponder];
        
        errMessage = kLoginStatusMessageRequireUserName;
		
		[self presentSheet:errMessage];
		
        return;
	}
    //用户名正确
    if (![NetRequestAlert isRightPhone:username] && ![NetRequestAlert isEmail:username])
    {
        [self presentSheet:L(@"请输入正确的用户名")];
        return;
    }
    
    NSString *password = self.pwdField.text;
	
    if (!password || [password isEmptyOrWhitespace])
    {
		
        [self.pwdField becomeFirstResponder];
        
		errMessage = kLoginStatusMessageRequirePassword;
		
	    [self presentSheet:errMessage];
		
        return;
	}
    if ([NetRequestAlert isHaveSpace:password])
    {
	     [self presentSheet:L(@"请输入正确的密码")];
        return;
    }
    
    [self.accountField resignFirstResponder];
    [self.pwdField resignFirstResponder];
    
    [self displayOverFlowActivityView:kLoginStatusMessageStartHttp yOffset:-80.0f];
    self.navigationItem.rightBarButtonItem.enabled = NO;
    [self displayOverFlowActivityView];
    [self.service beginLoginRequestWithUserName:self.accountField.text passWord:self.pwdField.text];
}

#pragma mark -
#pragma mark service method

- (LoginService *)service
{
    if (!_service) {
        _service = [[LoginService alloc] init];
        _service.delegate = self;
    }
    return _service;
}

-  (void)LoginCompletedWithResult:(BOOL)isSuccess errorMsg:(NSString *)errorMsg
{
    [self removeOverFlowActivityView];
    
    if (isSuccess) {
        

        
        //[[NSNotificationCenter defaultCenter] postNotificationName:LOGIN_OK_MESSAGE object:nil];
        
        if (self.loginDelegate && [self.loginDelegate respondsToSelector:self.loginDidOkSelector]) {
            [self.loginDelegate performSelector:self.loginDidOkSelector];
        }
        
        //用户切换
//        if ([UserCenter defaultCenter].lastUserId &&
//            ![[UserCenter defaultCenter].userInfoDTO.userId
//              isEqualToString:[UserCenter defaultCenter].lastUserId])
//        {
//            [UserCenter defaultCenter].lastUserId = nil;
//            [[NSNotificationCenter defaultCenter] postNotificationName:LOGIN_USER_CHANGE_MESSAGE
//                                                                object:nil];
//        }
        
        [self dismissModalViewControllerAnimated:YES ];
        
        /*HomeViewController *homeVC = [[HomeViewController alloc]init];
        [self.navigationController pushViewController:homeVC animated:YES];
        TT_RELEASE_SAFELY(homeVC);*/
        
        
    }else{
		[self presentSheet:errorMsg];
    }
    
    self.navigationItem.rightBarButtonItem.enabled = YES;
}

#pragma mark -
#pragma mark

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    if (textField == self.accountField)
    {
        // Move input focus to the password field.
        [self.pwdField becomeFirstResponder];
    }
    else
    {
        // Simulate clicking the Submit button.
        [self login:nil];
    }
    
    return YES;
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (self.pwdField == textField)  //判断是否时我们想要限定的那个输入框
    {
        NSString * toBeString = [self.pwdField.text stringByReplacingCharactersInRange:range withString:string];
        
        if ([toBeString length] > 20)
        {
            return NO;
        } 
    }
    return YES;
}

#pragma mark -
#pragma mark table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
	
    return self.keyTableView.frame.size.height;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return 1;
}

- (NSInteger)tableView:(UITableView *)table numberOfRowsInSection:(NSInteger)section
{
    return  1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	
    
    static NSString *identifer = @"identifer";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    
    if (nil == cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
    }
    
    cell.contentView.userInteractionEnabled = YES;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    [cell.contentView addSubview:self.titleLabel];
    [cell.contentView addSubview:self.nameBackImage];
    //    [cell.contentView addSubview:self.verificationLab];
    
    [cell.contentView addSubview:self.confirmBtn];
    [cell.contentView addSubview:self.confirmLabel];
    [cell.contentView addSubview:self.logBtn];
    [cell.contentView addSubview:self.regBtn];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 1) {
        switch (indexPath.row) {
            case 0:
            {
                [self userRegister:nil];
                break;
            }
                
            case 1:
            {
                
                [self forgetPwdAction: nil];
                break;
            }
            default:
                break;
        }
    }
	
    
}

#pragma mark - Actions

- (void)userRegister:(id)sender
{
    RegisterViewController *registViewController = [[RegisterViewController alloc] init];
//    registViewController.registerDelegate = self;
//    registViewController.registerOkSelector = @selector(registerOKHeadler);
    AuthManagerNavViewController *navController = [[AuthManagerNavViewController alloc] initWithRootViewController:registViewController];
	TT_RELEASE_SAFELY(registViewController);
    [self presentModalViewController:navController animated:YES];
    TT_RELEASE_SAFELY(navController);
    
}

- (void)forgetPwdAction:(id)sender{
    
}




@end
