//
//  FeedBackModulePlugin.m
//  SuningPan
//
//  Created by shasha on 13-4-3.
//  Copyright (c) 2013年 suning. All rights reserved.
//

#import "FeedBackModulePlugin.h"

@interface FeedBackModulePlugin(){
    UINavigationController *__navController;
    UIViewController       *__parentViewControlelr;
}
@end

@implementation FeedBackModulePlugin


- (id)init
{
    self = [super init];
    if (self) {
        self.isViewController = YES;
        self.moduleId = 0;
        self.moduleType = eTypeFeedBackModule;
        self.moduleName = kFeedBackModuleName;
    }
    return self;
}

- (id)initWithModuleType:(E_ModuleType)type{
    
    self = [super init];
    if (self) {
        self.isViewController = YES;
        self.moduleId = 0;
        self.moduleType = type;
        self.moduleName = kFeedBackModuleName;
    }
    return self;
}

- (id)initWithModuleName:(NSString *)name{
    
    self = [super init];
    if (self) {
        self.isViewController = YES;
        self.moduleId = 0;
        self.moduleType = eTypeFeedBackModule;
        self.moduleName = name;
    }
    return self;
}


- (void)bePushedViewController:(UINavigationController *)navVC{
    __navController = navVC;
    UIViewController *feedBackViewController = [[UIViewController alloc] init];
    feedBackViewController.view.backgroundColor = [UIColor redColor];
    [navVC pushViewController:feedBackViewController animated:YES];
    
}

- (void)bePresentedViewController:(UIViewController *)parentVC{
    __parentViewControlelr = parentVC;
    
    Class mailClass = (NSClassFromString(@"MFMailComposeViewController"));
    
    if (mailClass != nil)
    {
        if ([mailClass canSendMail])
        {
            [self sendMail];
        }
        else
        {
            [self launchMailAppOnDevice];
        }
    }
    else
    {
        [self launchMailAppOnDevice];
    }
}

#pragma mark -  UserFadeBack Methods
#pragma mark    用户反馈的方法实现

- (void)sendMail{
    
    MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
    
    picker.mailComposeDelegate = self;
    
    NSString *appVersion =  [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
    
    NSString *iosVersion = [SystemInfo iosVersion];
    
    NSString *platformString = [SystemInfo platformString];
    
    NSString *subject  = [[NSString alloc ]initWithFormat:@"苏宁云盘%@(%@: %@)",appVersion,platformString,iosVersion ];
    
    [picker setSubject:subject];
    
   
    
    [picker setToRecipients:[NSArray arrayWithObject:@"suningios@cnsuning.com"]];
    
    if ([picker.navigationBar respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)])
    {
        [picker.navigationBar setBackgroundImage:[UIImage imageNamed:@"system_nav_bg.png"] forBarMetrics:UIBarMetricsDefault];
        
    }else{
        object_setClass(picker.navigationBar, [UINavigationBar class]);
    }
    
    picker.navigationBar.tintColor = [UIColor navTintColor];
    
    [__parentViewControlelr presentModalViewController:picker animated:YES];
    
   
    
}

- (void)launchMailAppOnDevice
{
    UIActionSheet *action = [[UIActionSheet alloc]
                             initWithTitle:L(@"Please Go to Mail App Config your Mail account")
                             delegate:self
                             cancelButtonTitle:L(@"Cancel")
                             destructiveButtonTitle:L(@"Now go to Mail")
                             otherButtonTitles:nil];
    
    [action showInView:__parentViewControlelr.view.superview];
    
 
}


- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (buttonIndex != actionSheet.cancelButtonIndex)
    {
        NSString *appVersion =  [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
        
        NSString *iosVersion = [SystemInfo iosVersion];
        
        NSString *platformString = [SystemInfo platformString];
        
        NSString *subject  = [[NSString alloc ]initWithFormat:@"苏宁云盘%@(%@: %@)",appVersion,platformString,iosVersion ];
        
        NSString *recipients = [NSString stringWithFormat:@"mailto:suningios@cnsuning.com?subject=%@", subject];
        NSString *email = [NSString stringWithFormat:@"%@", recipients];
        email = [email stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:email]];
        
       
    }
}

- (void) mailComposeController: (MFMailComposeViewController*)controller didFinishWithResult: (MFMailComposeResult)result error:(NSError*)error
{
	// Notifies users about errors associated with the interface
	switch (result)
	{
		case MFMailComposeResultCancelled:
			break;
		case MFMailComposeResultSaved:
            [self presentCustomDlg:L(@"Save success")];
			break;
		case MFMailComposeResultSent:
            [self presentCustomDlg:L(@"Send success, thank for your feedback")];
			break;
		case MFMailComposeResultFailed:
            [self presentCustomDlg:L(@"Send failed")];
			break;
		default:
		{
			[self presentCustomDlg:@"Sending Failed – Unknown Error  "];
			break;
        }
	}
	
	[__parentViewControlelr dismissModalViewControllerAnimated:YES];
	
}

- (void)presentCustomDlg:(NSString*)indiTitle{
	
    BBAlertView *alert = [[BBAlertView alloc] initWithStyle:BBAlertViewStyleDefault
                                                      Title:L(@"system-info")
                                                    message:indiTitle
                                                 customView:nil
                                                   delegate:self
                                          cancelButtonTitle:L(@"Confirm")
                                          otherButtonTitles:nil];
    [alert show];

    
}
@end
