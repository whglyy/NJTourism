//
//  LoginViewController.h
//  SuningEBuy
//
//  Created by 刘坤 on 12-8-16.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

/*!
 
 @header   LoginViewController
 @abstract 登录
 @author   刘坤
 @version  4.3  2012/8/16 Creation
 
 */
#import "CommonViewController.h"
#import "LoginService.h"
@interface LoginViewEXController:CommonViewController <LoginServiceDelegate, UITextFieldDelegate>
{
}

@property (nonatomic, retain) LoginService  *service;

@property (nonatomic, retain)  UINavigationController  *nextNavigationController;
@property (nonatomic, retain)  UIViewController        *nextController;

@property (nonatomic, assign) id                loginDelegate;
@property (nonatomic, assign) SEL               loginDidOkSelector;
@property (nonatomic, assign) SEL               loginDidCancelSelector;

@property (nonatomic, retain) UITableView *keyTableView;

@property (nonatomic, retain) UILabel *titleLabel;

@property (nonatomic, retain) UIImageView *nameBackImage;

@property (nonatomic, retain) UITextField *accountField;
@property (nonatomic, retain) UITextField *pwdField;

@property (nonatomic, retain) UIButton *confirmBtn;
@property (nonatomic, retain) UILabel *confirmLabel;

@property (nonatomic, retain) UIButton *regBtn;
@property (nonatomic, retain) UIButton *logBtn;



- (void)login:(id)sender;
@end
