//
//  ToolBarCell.m
//  FatFist
//
//  Copyright 2011 FatFish. All rights reserved.
//
//
#import "ToolBarCell.h"
@implementation ToolBarCell

@synthesize canBecomeFirstRes = canBecomeFirstRes_;


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier inputView:(UIView *)aInputView
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self)
    {
        self.inputView = aInputView;
        
        self.inputAccessoryView = self.keyboardDoneButtonBar;
        
        self.canBecomeFirstRes = YES;
    }
    return self;
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self)
    {
        self.inputAccessoryView = self.keyboardDoneButtonBar;
        
        self.canBecomeFirstRes = YES;
    }
    return self;
}

- (UIToolbar*)keyboardDoneButtonBar{
    
    if(!_keyboardDoneButtonBar){
        
        _keyboardDoneButtonBar= [[UIToolbar alloc] init];
        
        _keyboardDoneButtonBar.barStyle = UIBarStyleBlackTranslucent;
        
        _keyboardDoneButtonBar.tintColor = nil;
        
        [_keyboardDoneButtonBar sizeToFit];
        
        
        UIBarButtonItem *flexItem = [[UIBarButtonItem alloc] 
                                      initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace 
                                      target:nil
                                      action:nil] ;
        
        
        
        UIBarButtonItem* cancelButton = [[UIBarButtonItem alloc] 
                                          initWithTitle:L(@"Cancel")
                                          style:UIBarButtonItemStyleBordered 
                                          target:self
                                          action:@selector(cancelButtonClicked:)] ;
        
        UIBarButtonItem* doneButton = [[UIBarButtonItem alloc] 
                                        initWithTitle:L(@"Ok")
                                        style:UIBarButtonItemStyleBordered 
                                        target:self
                                        action:@selector(doneButtonClicked:)] ;
        
        [_keyboardDoneButtonBar setItems:[NSArray arrayWithObjects:cancelButton,flexItem,doneButton, nil]];
        
    }
    
    return _keyboardDoneButtonBar;
}
- (UILabel *)customLabel
{
    if (!_customLabel) {
        _customLabel = [[UILabel alloc] initWithFrame:CGRectMake(110, 4, 100, 36)];
        _customLabel.font = [UIFont systemFontOfSize:16.0f];
        _customLabel.textColor = [UIColor darkGrayColor];
        _customLabel.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:_customLabel];
    }
    return _customLabel;
}
- (BOOL)canBecomeFirstResponder
{
    return self.canBecomeFirstRes;
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    
    
}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    if (canBecomeFirstRes_)
    {
        [self becomeFirstResponder];
    }
    else
    {
        if ([_toolBarDelegate conformsToProtocol:@protocol(ToolBarCellDelegate)])
        {
            if ([_toolBarDelegate respondsToSelector:@selector(singleSelectCell:)])
            {
                [_toolBarDelegate singleSelectCell:self];
            }
        }
    }
    
}

#pragma mark -
#pragma mark Tool Bar Button Delegate Methods
- (void)doneButtonClicked:(id)sender
{
    if ([_toolBarDelegate conformsToProtocol:@protocol(ToolBarCellDelegate)])
    {
        if ([_toolBarDelegate respondsToSelector:@selector(doneClicked:)])
        {
            [_toolBarDelegate doneClicked:self];
        }
    }else{
        [self resignFirstResponder];
    }
}
- (void)cancelButtonClicked:(id)sender
{
    if ([_toolBarDelegate conformsToProtocol:@protocol(ToolBarCellDelegate)])
    {
        if ([_toolBarDelegate respondsToSelector:@selector(cancelClicked:)])
        {
            [_toolBarDelegate cancelClicked:(id)sender];
        }
    }
    [self resignFirstResponder];
}

@end
