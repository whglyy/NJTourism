//
//  ToolBarCell.h
//  SuningEBuy
//
//  Created by 刘坤 on 11-11-3.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ToolBarButton.h"

@protocol ToolBarCellDelegate <NSObject>

@optional
- (void)doneClicked:(UITableViewCell *)cell;

- (void)cancelClicked:(UITableViewCell *)cell;

- (void)singleSelectCell:(UITableViewCell *)cell;

@end

@interface ToolBarCell : UITableViewCell
{
    
    id <ToolBarCellDelegate>__weak  _toolBarDelegate;
    
    UIView    *_inputView;
    
    UIView    *_inputAccessoryView;
    
    UIToolbar *_keyboardDoneButtonBar;
    
    BOOL    canBecomeFirstRes_;
}

@property (nonatomic, weak) id <ToolBarCellDelegate> toolBarDelegate;

@property (readwrite, retain) UIView *inputView;

@property (readwrite, retain) UIView *inputAccessoryView;

@property (nonatomic, retain) UIToolbar *keyboardDoneButtonBar;

@property (nonatomic, assign) BOOL canBecomeFirstRes;   //default is YES

@property (nonatomic, retain) UILabel *customLabel;

- (id)initWithStyle:(UITableViewCellStyle)style
    reuseIdentifier:(NSString *)reuseIdentifier 
          inputView:(UIView *)aInputView;

@end
