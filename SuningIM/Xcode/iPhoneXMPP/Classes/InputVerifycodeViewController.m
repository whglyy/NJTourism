//
//  InputVerifycodeViewController.m
//  SuningIM
//
//  Created by wangbao on 13-6-3.
//
//

#import "InputVerifycodeViewController.h"
#import "VerifyService.h"
#import "ContactListViewController.h"

@interface InputVerifycodeViewController ()

@end

@implementation InputVerifycodeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"填写验证码";
        _service = [[VerifyService alloc]init];
        _service.delegate = self;
    }
    return self;
}

- (IBAction)Verify:(id)sender {
    [self.service beginVerifyRequestWithVerifyCode:(NSString *)self.verifyCode.text JID:(NSString *)self.jid Password:(NSString *)self.password];    
}

- (void)VerifyCompletedWithResult:(BOOL)isSuccess Service:(VerifyService *)service{

    if (isSuccess) {
        ContactListViewController *vc = [[ContactListViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }else{
    
    }
}

- (IBAction)stop:(id)sender {
    [self.service stopVerifyRequestWithJID:(NSString *)self.jid];
}

- (IBAction)readaddresslist:(id)sender {
    ContactListViewController *vc = [[ContactListViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)hideKey:(id)sender {
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
    [super viewDidUnload];
}

@end
