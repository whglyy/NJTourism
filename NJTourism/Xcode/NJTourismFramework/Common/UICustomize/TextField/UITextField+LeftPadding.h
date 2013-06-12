//
//  UITextField+LeftPadding.h
//  FatFist
//
//  Created by lyywhg on 11/1/11.
//  Copyright 2011 FatFist. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LeftPaddingTextFieldDelegate;

@interface LeftPaddingField : UITextField

@property (nonatomic, retain)  UIToolbar        *keyboardDoneButtonView;

@property (nonatomic, assign)  id<LeftPaddingTextFieldDelegate> leftPaddingDelegate;

- (CGRect)textRectForBounds:(CGRect)bounds;

- (CGRect)editingRectForBounds:(CGRect)bounds;

- (void)displayBorder:(BOOL)visible;

- (void)displayToolBar:(BOOL)visible;

@end

@protocol LeftPaddingTextFieldDelegate <NSObject>

- (void)doneButtonClicked:(id)sender;

- (void)cancelButtonClicked:(id)sender;

@end
