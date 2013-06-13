//
//  ToolBarTextField.h
//  FatFist
//
//  Created by lyywhg on 13-5-24.
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
