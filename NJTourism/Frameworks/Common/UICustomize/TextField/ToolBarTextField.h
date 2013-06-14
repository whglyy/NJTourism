//
//  ToolBarTextField.h
//  FatFist
//
//  Copyright 2011 FatFish. All rights reserved.
//
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
