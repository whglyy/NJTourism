//
//  ToolTipView.h
//  Wingletter5
//
//  Created by Hubert Ryan on 11-6-21.
//  Copyright 2011 FatFist. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ToolTipViewDelegate;

@interface ToolTipView : UIView {

    @private
	UILabel *label;
	
	NSString *_labelText;
	
	float yOffset;
	
    float xOffset;
	
	UIFont *labelFont;
	
	CGRect boxRect;
	
	UIView *bkView;
	
	CGFloat   autoHideInterval;
    
    id<ToolTipViewDelegate> delegate_;
    
    NSTimer *dlgTimer_;
}



@property (nonatomic, copy) NSString *labelText;

@property (nonatomic, retain) UIFont *labelFont;

@property (nonatomic, assign) float yOffset;

@property (nonatomic, assign) float xOffset;

@property (nonatomic, assign) CGFloat autoHideInterval;

@property (nonatomic, assign) id<ToolTipViewDelegate> delegate;

@property (nonatomic, retain) NSTimer *dlgTimer;

- (id)initWithView:(UIView *)view ;

- (void)fillRoundedRect:(CGRect)rect inContext:(CGContextRef)context ;

@end


@protocol ToolTipViewDelegate <NSObject>

- (void)tipViewWasHidden:(ToolTipView *)tipView;

@end
