//
//  AuthManagerNavViewController.h
//  
//
//  Created by Hubert Ryan on 11-6-23.
//  Copyright 2011 FatFist. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AuthManagerNavViewController : UINavigationController {
		
}

@property (nonatomic,retain) UIView *backgroundView;

- (BOOL)needLogonAuth:(UIViewController *)viewController;

@end
