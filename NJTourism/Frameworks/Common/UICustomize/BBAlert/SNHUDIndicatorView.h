//
//  SNHUDIndicatorView.h
//  FatFist
//
//  Copyright 2011 FatFish. All rights reserved.
//
//
#import <Foundation/Foundation.h>
@interface SNHUDIndicatorView : MBRoundProgressView
@property (nonatomic, retain) UIImageView  *indicatorImgView;
- (void)startAnimation;
- (void)stopAnimation;
@end
