//
//  AddressMatchViewController.m
//  SuningIM
//
//  Created by wangbao on 13-6-3.
//
//

#import "AddressMatchViewController.h"
#import "InputVerifycodeViewController.h"

@interface AddressMatchViewController ()

@end

@implementation AddressMatchViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"验证手机号";
        _service = [[VerifyService alloc] init];
        _service.delegate = self;
    }
    return self;
}



- (IBAction)next:(id)sender {
    self.jid = [UserCenter defaultCenter].userInfoDTO.jid;
    [self.service getVerifyRequestWithPhoneNo:self.phoneNo.text JID:self.jid];
}


- (void)getVerifyCompletedWithResult:(BOOL)isSuccess Service:(VerifyService *)service{
    if (isSuccess) {
        InputVerifycodeViewController *inputverifycodeViewController = [[InputVerifycodeViewController alloc] initWithNibName:@"InputVerifycodeViewController" bundle:nil];
        [self.navigationController pushViewController:inputverifycodeViewController animated:YES];
    }else{
    
    }
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)hideKeyboard:(id)sender {
    [sender resignFirstResponder];

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
