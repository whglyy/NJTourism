//
//  keyboardNumberPadReturnTextField.h
//  FatFist
//
//  Created by lyywhg on 11-11-2.
//  Copyright (c) 2011年 FatFist. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol KeyboardDoneTappedDelegate <NSObject>

@optional
- (void)doneTapped:(id)sender;

@end

@interface keyboardNumberPadReturnTextField : UITextField
{
    UIButton *_doneButton;
    
    id <KeyboardDoneTappedDelegate> __weak _doneButtonDelegate;
}

@property (nonatomic, retain) UIButton *doneButton;

@property (nonatomic, weak) id <KeyboardDoneTappedDelegate> doneButtonDelegate;

@end

