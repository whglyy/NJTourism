//
//  PlaceholderTextView.h
//  FatFist
//
//  Copyright 2011 FatFish. All rights reserved.
//
//

#import <UIKit/UIKit.h>

@interface PlaceholderTextView : UITextView 
{
    NSString    *_placeholder;
    
    UIColor     *_placeholderColor;
    
    UILabel     *_placeHolderLabel;
}

@property(nonatomic,retain) UILabel     *placeHolderLabel;
@property(nonatomic,retain) NSString    *placeholder;
@property(nonatomic,retain) UIColor     *placeholderColor;

- (void)textChanged:(NSNotification*)notification;

@end
