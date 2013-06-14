//
//  EGOPhotoImageView.h
//  FatFist
//
//  Copyright 2011 FatFish. All rights reserved.
//
//


#import "EGOPhotoGlobal.h"
#import "EGOPhotoSource.h"
#import "EGOImageLoader.h"

@class EGOPhotoScrollView, EGOPhotoCaptionView;

@interface EGOPhotoImageView : UIView <EGOImageLoaderObserver, UIScrollViewDelegate>{
@private
	EGOPhotoScrollView *_scrollView;
	id <EGOPhoto> _photo;
	UIImageView *_imageView;
	UIActivityIndicatorView *_activityView;
	
	BOOL _loading;
//	CGRect _currentRect;
	CGFloat _beginRadians;
//	CGPoint _midPos;
	
}

@property(nonatomic,readonly) id <EGOPhoto> photo;
@property(nonatomic,readonly) UIImageView *imageView;
@property(nonatomic,readonly) EGOPhotoScrollView *scrollView;
@property(nonatomic,assign,getter=isLoading) BOOL loading;

- (void)setPhoto:(id <EGOPhoto>)aPhoto;
- (void)killScrollViewZoom;
- (void)layoutScrollViewAnimated:(BOOL)animated;
- (void)prepareForReusue;
- (void)rotateToOrientation:(UIInterfaceOrientation)orientation;
- (CGSize)sizeForPopover;

@end
