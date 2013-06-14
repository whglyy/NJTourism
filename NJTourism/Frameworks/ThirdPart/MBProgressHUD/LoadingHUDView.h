//
//  LoadingHUDView.h
//  FatFist
//
//  Copyright 2011 FatFish. All rights reserved.
//
//

#import <UIKit/UIKit.h>

@interface LoadingHUDView : UIView {
	UIActivityIndicatorView *_activity;
	BOOL _hidden;

	NSString *_title;
	NSString *_message;
	float radius;
}
@property (copy,nonatomic) NSString *title;
@property (copy,nonatomic) NSString *message;
@property (assign,nonatomic) float radius;

- (id) initWithTitle:(NSString*)title message:(NSString*)message;
- (id) initWithTitle:(NSString*)title;

- (void) startAnimating;
- (void) stopAnimating;




@end
