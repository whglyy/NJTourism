//
//  RegisterViewController.m
//  SuningIM
//
//  Created by wangbao on 13-5-27.
//
//

#import "RegisterViewController.h"

@interface RegisterViewController ()

@end
static NSInteger seconds = 120;
@implementation RegisterViewController

- (id)init
{
    self = [super init];
    if (self)
    {
        // Custom initialization
        
        self.title = L(@"Registration");
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (IBAction)getVerificationCode:(id)sender {
    //用户名为空
    if ([NetRequestAlert isStringNull:self.nameField.text])
    {
        [self presentSheet:L(@"please input 11 correct phonenum")];
        return;
    }
    //用户名正确
    if (![NetRequestAlert isRightPhone:self.nameField.text] )
    {
        [self presentSheet:L(@"please input 11 correct phonenum")];
        return;
    }
    
    {
        if (!self.backgroundTimerIdentifier || self.backgroundTimerIdentifier == UIBackgroundTaskInvalid)
        {
            self.backgroundTimerIdentifier = [[UIApplication sharedApplication] beginBackgroundTaskWithExpirationHandler:^{
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    TT_INVALIDATE_TIMER(_counterTimer);
                    
                    if (self.backgroundTimerIdentifier != UIBackgroundTaskInvalid)
                    {
                        [[UIApplication sharedApplication] endBackgroundTask:self.backgroundTimerIdentifier];
                        
                        self.backgroundTimerIdentifier = UIBackgroundTaskInvalid;
                    }
                    
                });
                
            }];
        }
    }
    
    self.counterTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerHandler) userInfo:nil repeats:YES];
    
    [self.registerService beginVerCodeRequest:self.nameField.text phoneNum:self.nameField.text];

}
- (IBAction)register:(id)sender {
    //用户名为空
    if ([NetRequestAlert isStringNull:self.nameField.text])
    {
        [self presentSheet:L(@"please input 11 correct phonenum")];
        return;
    }
    //用户名正确
    if (![NetRequestAlert isRightPhone:self.nameField.text])
    {
        [self presentSheet:L(@"please input 11 correct phonenum")];
        return;
    }
    //第一次密码
    //密码为空
    if ([NetRequestAlert isStringNull:self.passwordField.text])
    {
        [self presentSheet:L(@"input User PassWord") ];
        return;
    }
    if ([NetRequestAlert isLengthOverGivenLength:self.passwordField.text length:20] || [NetRequestAlert isLengthUnderGivenLength:self.passwordField.text length:6])
    {
        [self presentSheet:L(@"passwd cannot be less than 6, please input again")];
        return;
    }
    //密码格式正确
    if ( ([NetRequestAlert isHaveChinese:self.passwordField.text] || [NetRequestAlert isHaveSpace:self.passwordField.text]) || ![NetRequestAlert isRightUserPassword:self.passwordField.text])
    {
        [self presentSheet:L(@"passwd  length must be 6 to 20, please try again") ];
        return;
    }
    if ([NetRequestAlert isAllSameChars:self.passwordField.text] || [NetRequestAlert hasAllIncreaseChars:self.passwordField.text] || [NetRequestAlert hasAllDecreaseChars:self.passwordField.text])
    {
        [self presentSheet:L(@"passwd cannot be one num")];
        return;
    }
    //验证码为空
    if ([NetRequestAlert isStringNull:self.verificationCode.text])
    {
        [self presentSheet:L(@"please input verify code")];
        return;
    }
    {
        [self.registerService beginRegisterRequest:self.nameField.text password:self.passwordField.text passwordVerify:self.passwordField.text smsCheck:self.verificationCode.text regType:@"1"];
    }

}


- (void)timerHandler
{
        
    if (seconds == 0)
    {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            TT_INVALIDATE_TIMER(_counterTimer);
            
            if (self.backgroundTimerIdentifier != UIBackgroundTaskInvalid)
            {
                [[UIApplication sharedApplication] endBackgroundTask:self.backgroundTimerIdentifier];
                
                self.backgroundTimerIdentifier = UIBackgroundTaskInvalid;
            }
            
        });
        
//        [self initSeconds];
    }
    else
    {
        seconds--;
    }
    
}

#pragma mark - Control Achieve

- (void)getVerCodeCompletedWithResult:(BOOL)isSuccess errorMsg:(NSString *)errorMsg
{
    [self removeOverFlowActivityView];
    if (isSuccess == NO)
    {
        [self presentSheet:errorMsg];
        return;
    }
}
- (void)registerCompletedWithResult:(BOOL)isSuccess errorMsg:(NSString *)errorMsg
{
    [self removeOverFlowActivityView];
    if (isSuccess == NO)
    {
        [self presentSheet:errorMsg];
        return;
    }
    
    [self dismissModalViewControllerAnimated:YES];
}

- (RegisterService *)registerService
{
    if (!_registerService)
    {
        _registerService = [[RegisterService alloc] init];
        _registerService.delegate = self;
    }
    return _registerService;
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

- (IBAction)hideKeyboard:(id)sender{
    [sender resignFirstResponder];
}


- (void)viewDidUnload {
    [self setNameField:nil];
    [self setPasswordField:nil];
    [self setGetvcode:nil];
    [self setDoregister:nil];
    [self setVerificationCode:nil];
    [super viewDidUnload];
}
@end
