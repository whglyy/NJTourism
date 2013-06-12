//
//  UserAgreementViewController.m
//  SuningPan
//
//  Created by wangman on 13-4-29.
//  Copyright (c) 2013年 suning. All rights reserved.
//

#import "UserAgreementViewController.h"

@interface UserAgreementViewController ()
@property (nonatomic ,retain) UITextView *agreementTextView;

@end

@implementation UserAgreementViewController



- (id)init{
    self = [super init];
    if (self) {
        self.title = L(@"user agreement");
    }
    return self;
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
}

- (UITextView *)agreementTextView{
    if (!_agreementTextView) {
        _agreementTextView = [[UITextView alloc]init];
        _agreementTextView.frame = CGRectMake(0, 0, 320, self.view.bounds.size.height - UINAVIGATIONBAR_HEIGHT);
        _agreementTextView.backgroundColor = RGBCOLOR(236, 236, 236);
        NSError *error;
        NSString *agreementContent = [NSString stringWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"userAgreement" ofType:@"txt" ] encoding:NSUTF8StringEncoding error:&error];
        _agreementTextView.text = agreementContent;
        _agreementTextView.editable = NO;
    }
    return _agreementTextView;
}


- (void)loadView{
    [super loadView];
    [self.view addSubview:self.agreementTextView];
}



- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
