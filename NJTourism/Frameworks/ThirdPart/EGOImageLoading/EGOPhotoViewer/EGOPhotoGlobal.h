//
//  EGOPhotoGlobal.h
//  FatFist
//
//  Copyright 2011 FatFish. All rights reserved.
//
//

// Frameworks
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

// Controller
#import "EGOPhotoViewController.h"

// Views
#import "EGOPhotoScrollView.h"
#import "EGOPhotoImageView.h"
#import "EGOPhotoCaptionView.h"

// Model
#import "EGOPhotoSource.h"
#import "EGOQuickPhoto.h"
#import "EGOQuickPhotoSource.h"

// Loading and Disk I/O 
#import "EGOImageLoadConnection.h"
#import "EGOImageLoader.h"
#import "EGOCache.h"

// Definitions used interally.
// ifndef checks are so you can easily override them in your project.
#ifndef kEGOPhotoErrorPlaceholder
	#define kEGOPhotoErrorPlaceholder [UIImage imageNamed:@"egopv_error_placeholder.png"]
#endif

#ifndef kEGOPhotoLoadingPlaceholder
	#define kEGOPhotoLoadingPlaceholder [UIImage imageNamed:@"egopv_photo_placeholder.png"]
#endif

#ifndef EGOPV_IMAGE_GAP
	#define EGOPV_IMAGE_GAP 30
#endif

#ifndef EGOPV_ZOOM_SCALE
	#define EGOPV_ZOOM_SCALE 2.5
#endif

#ifndef EGOPV_MAX_POPOVER_SIZE
#define EGOPV_MAX_POPOVER_SIZE CGSizeMake(480.0f, 480.0f)
#endif

#ifndef EGOPV_MIN_POPOVER_SIZE
#define EGOPV_MIN_POPOVER_SIZE CGSizeMake(320.0f, 320.0f)
#endif