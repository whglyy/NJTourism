//
//  EGORefreshTableHeaderView.h
//  FatFist
//
//  Copyright 2011 FatFish. All rights reserved.
//
//
#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

typedef enum
{
	EGOOPullRefreshPulling = 0,
	EGOOPullRefreshNormal,
	EGOOPullRefreshLoading,	
} EGOPullRefreshState;

@interface EGORefreshTableHeaderView : UIView {
	
	UILabel *lastUpdatedLabel;
	UILabel *statusLabel;
	CALayer *arrowImage;
	UIActivityIndicatorView *activityView;
	
	EGOPullRefreshState _state;
    
    
    
}

@property(nonatomic,assign) EGOPullRefreshState state;
- (void)setCurrentDate;
- (void)setState:(EGOPullRefreshState)aState;
@end

