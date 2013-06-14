//
//  EGOImageView.h
//  FatFist
//
//  Copyright 2011 FatFish. All rights reserved.
//
//

#import <UIKit/UIKit.h>
#import "EGOImageLoader.h"
#import "AnimatedImageView.h"

typedef enum
{
    ImageAnimationNone = 0,
    ImageAnimationSmallToBig,
    ImageAnimationFlip,
    ImageAnimation3DMakeRotate
}GOEForAnimation;

@protocol EGOImageViewDelegate;
@interface EGOImageView : AnimatedImageView<EGOImageLoaderObserver> {
//@private
	NSURL* imageURL;
	UIImage* placeholderImage;
	id<EGOImageViewDelegate> delegate;
    BOOL _hasBorder;
    
    //lyywhg，2012-6-8， 添加是否将图片显示圆角
    BOOL isRoundCorner_;
    NSInteger imageCornerRadius_;
}

- (id)initWithPlaceholderImage:(UIImage*)anImage; // delegate:nil
- (id)initWithPlaceholderImage:(UIImage*)anImage delegate:(id<EGOImageViewDelegate>)aDelegate;

- (void)cancelImageLoad;

@property(nonatomic,retain) NSURL* imageURL;
@property(nonatomic,retain) UIImage* placeholderImage;
@property(nonatomic,assign) id<EGOImageViewDelegate> delegate;
@property(nonatomic,assign) BOOL hasBorder;
@property(nonatomic,assign) BOOL isDataIntegrated;

@property(nonatomic,assign) GOEForAnimation hasAnimateType;
@property(nonatomic,assign) BOOL isRoundCorner;
@property(nonatomic,assign) NSInteger imageCornerRadis;

- (void)setHasBorder:(BOOL)aHasBorder;

@end

@protocol EGOImageViewDelegate<NSObject>
@optional
- (void)imageViewLoadedImage:(EGOImageView*)imageView;
- (void)imageViewFailedToLoadImage:(EGOImageView*)imageView error:(NSError*)error;
@end