//
//  EGOImageViewEx.h
//  FatFist
//
//  Copyright 2011 FatFish. All rights reserved.
//
//

#import "EGOImageView.h"

@protocol EGOImageViewExDelegate;

@interface EGOImageViewEx : EGOImageView {

	id <EGOImageViewExDelegate> exDelegate_;
    
}

@property (nonatomic, assign) id <EGOImageViewExDelegate> exDelegate;

@property (nonatomic, retain) UIActivityIndicatorView *activityView;

- (void)touchesBegan:(NSSet*)touches withEvent:(UIEvent*)event;
//捕获手指拖拽消息
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event;
//捕获手指拿开消息
- (void) touchesEnded:(NSSet*)touches withEvent:(UIEvent*)event;

@end



@protocol EGOImageViewExDelegate <NSObject>
@optional
- (void)imageExViewDidOk:(EGOImageViewEx *)imageViewEx;
@end
