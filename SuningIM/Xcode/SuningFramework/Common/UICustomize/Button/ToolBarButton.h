//
//  ToolBarButton.h
//  FatFist
//
//  Created by lyywhg on 11/3/11.
//  Copyright 2011 FatFist. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ToolBarButtonDelegate;

@interface ToolBarButton : UIButton
{
    
    UIView                      *_inputView;
    
    UIView                      *_inputAccessoryView;
    
    UIToolbar                   *_aboveViewToolBar;
    
    id<ToolBarButtonDelegate>   __weak _delegate;
    
}

@property (nonatomic,retain) UIView                     *inputView;
@property (nonatomic,retain) UIView                     *inputAccessoryView;
@property (nonatomic,retain) UIToolbar                  *aboveViewToolBar;
@property (nonatomic,weak) id<ToolBarButtonDelegate>  delegate;

@property (nonatomic,retain) UIColor *nomalBgColor;     //正常的背景颜色
@property (nonatomic,retain) UIColor *activeBgColor;    //弹出键盘的时候的颜色

@end

@protocol ToolBarButtonDelegate <NSObject>

@optional
- (void)cancelButtonClicked:(id)sender;
- (void)doneButtonClicked:(id)sender;
- (void)singleClickButton:(id)sender;

@end
