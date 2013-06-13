//
//  PlaceholderTextView.h
//  FatFist
//
//  Created by lyywhg on 13-5-24.
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
