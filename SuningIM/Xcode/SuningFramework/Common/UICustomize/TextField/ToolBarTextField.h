//
//  ToolBarTextField.h
//  FatFist
//
//  Created by lyywhg on 11-11-2.
//  Copyright (c) 2011年 FatFist. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ToolBarTextFieldDelegate <UITextFieldDelegate>

- (void)doneButtonClicked:(id)sender;

- (void)cancelButtonClicked:(id)sender;



@end

@interface ToolBarTextField : UITextField
{
    UIToolbar  *_keyboardDoneButtonBar;
    
    id <ToolBarTextFieldDelegate> toolBarDelegate_;
}

@property (nonatomic, retain) UIToolbar *keyboardDoneButtonBar;

@property (nonatomic, assign) id <ToolBarTextFieldDelegate> toolBarDelegate;

@end
