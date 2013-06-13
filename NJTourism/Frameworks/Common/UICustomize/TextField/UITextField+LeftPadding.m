//
//  UITextField+LeftPadding.m
//  FatFist
//
//  Created by lyywhg on 13-5-24.
//
//

#import "UITextField+LeftPadding.h"


@implementation LeftPaddingField
@synthesize keyboardDoneButtonView = _keyboardDoneButtonView;
@synthesize leftPaddingDelegate = _leftPaddingDelegate;



- (CGRect)textRectForBounds:(CGRect)bounds
{
    return  CGRectInset(bounds, 5, 0);
}

- (CGRect)editingRectForBounds:(CGRect)bounds
{
    return CGRectInset(bounds, 5, 0);
}

- (void)displayBorder:(BOOL)visible
{
    if (visible)
    {
        
        self.layer.borderWidth = 1.0f;
        self.layer.borderColor = [UIColor grayColor].CGColor;
        self.layer.cornerRadius = 6;
        self.layer.masksToBounds = YES;
    }
}

- (void)displayToolBar:(BOOL)visible
{
    
    if (visible)
    {
        self.inputAccessoryView = self.keyboardDoneButtonView;
    }
    
}

- (UIToolbar *)keyboardDoneButtonView
{
    if (!_keyboardDoneButtonView)
    {
        _keyboardDoneButtonView = [[UIToolbar alloc] init];
        
        _keyboardDoneButtonView.barStyle = UIBarStyleBlack;
        
        _keyboardDoneButtonView.translucent = YES;
        
        [_keyboardDoneButtonView sizeToFit];
        
        
        UIBarButtonItem *flexItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                                                                   target:nil
                                                                                   action:nil];
                        
        
        
        
//        UIBarButtonItem *cancelButton = [[[UIBarButtonItem alloc] initWithTitle:L(@"Cancel")
//                                                                          style:UIBarButtonItemStyleBordered
//                                                                         target:self
//                                                                         action:@selector(cancelClicked:)] 
//                                         autorelease];
        
//        cancelButton.tintColor = RGBCOLOR(33, 95, 221);
        
        UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:L(@"Ok")
                                                                        style:UIBarButtonItemStyleBordered
                                                                       target:self
                                                                       action:@selector(doneClicked:)] 
                                       ;
        
//        doneButton.tintColor = RGBCOLOR(33, 95, 221);
        
        [_keyboardDoneButtonView setItems:[NSArray arrayWithObjects:flexItem,doneButton, nil]];
        
        
    }
    
    return _keyboardDoneButtonView;
    
}

- (void)doneClicked:(id)sender
{
    if ([self.leftPaddingDelegate respondsToSelector:@selector(doneButtonClicked:)]) 
    {
        [self.leftPaddingDelegate doneButtonClicked:sender];
    }
    
    [self resignFirstResponder];
}

- (void)cancelClicked:(id)sender
{
    if ([self.leftPaddingDelegate respondsToSelector:@selector(cancelButtonClicked:)]) 
    {
        [self.leftPaddingDelegate cancelButtonClicked:sender];
    }
    
    [self resignFirstResponder];
}

@end


