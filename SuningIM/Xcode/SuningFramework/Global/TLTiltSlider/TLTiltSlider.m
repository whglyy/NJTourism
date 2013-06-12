//
//  TLTiltSlider.m
//
//  Created by Ash Furrow on 2013-03-08.
//  Copyright (c) 2013 Teehan+Lax. All rights reserved.
//

#import <CoreMotion/CoreMotion.h>

#import "TLTiltSlider.h"

@interface TLTiltSlider ()

// Our motion manager.
@property (nonatomic, strong) CMMotionManager *motionManager;

@end

@implementation TLTiltSlider

// This is the rendered size of the entire knob, including the shadow.
static const CGSize kKnobSize = (CGSize){.width = 24, .height = 24};
// This is the margin around kKnobSize which the shadow occupies.
static const CGFloat kShadowMargin = 1.0f;

// Allows support for using instances loaded from nibs or storyboards.
-(id)initWithCoder:(NSCoder *)aCoder
{
    if (!(self = [super initWithCoder:aCoder])) return nil;
    
    [self setup];
    
    return self;
}

// Allows support for using instances instantiated programatically.
- (id)initWithFrame:(CGRect)frame
{
    if (!(self = [super initWithFrame:frame])) return nil;
    
    [self setup];
    
    return self;
}

#pragma mark - Private Methods

// Set up the background images and motion detection.
-(void)setup
{
    [self setMinimumTrackImage:[[UIImage imageNamed:@"sncloud_progress_content_stock.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 10, 4, 4)] forState:UIControlStateNormal];
    [self setMaximumTrackImage:[[UIImage imageNamed:@"sncloud_progress_content_bg.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 10, 4, 4)] forState:UIControlStateNormal];

    // Set up our motion updates
    [self setupMotionDetection];
}

// Creates the device motion manager and starts it updating
// Make sure to only call once.
-(void)setupMotionDetection
{
    NSAssert(self.motionManager == nil, @"Motion manager being set up more than once.");

	// Since tilt is enabled by default, we need to set this ivar explicitly
	_tiltEnabled = YES;

    // Set up a motion manager and start motion updates, calling deviceMotionDidUpdate: when updated.
    self.motionManager = [[CMMotionManager alloc] init];
    
    [self startDeviceMotionUpdates];
    
    // Need to call once for the initial load
    
    [self updateButtonImageForRoll:0 pitch:0];
}

// Starts the motionManager updating device motions.
-(void)startDeviceMotionUpdates
{
    __typeof(self) weakSelf = self;
    [self.motionManager startDeviceMotionUpdatesToQueue:[NSOperationQueue mainQueue] withHandler:^(CMDeviceMotion *motion, NSError *error) {
        if (error)
        {
            [weakSelf.motionManager stopDeviceMotionUpdates];
            return;
        }
        
        [weakSelf deviceMotionDidUpdate:motion];
    }];
}

// Uppdates the Thumb (knob) image for the given roll and pitch
-(void)updateButtonImageForRoll:(CGFloat)roll pitch:(CGFloat)pitch
{
    [self setThumbImage:[UIImage imageNamed:@"sncloud_progress_music_stock_normal.png"] forState:UIControlStateNormal];
    [self setThumbImage:[UIImage imageNamed:@"sncloud_progress_music_stock_pressed.png"] forState:UIControlStateSelected];
    [self setThumbImage:[UIImage imageNamed:@"sncloud_progress_music_stock_pressed.png"] forState:UIControlStateHighlighted];
}

#pragma mark - Overridden Properties

// Updates the ivar disables (or enables) the motion manager
-(void)setTiltEnabled:(BOOL)tiltEnabled
{
    _tiltEnabled = tiltEnabled;
    
    if (tiltEnabled && ![self.motionManager isDeviceMotionActive])
    {
        [self startDeviceMotionUpdates];
    }
    else if (!tiltEnabled && [self.motionManager isDeviceMotionActive])
    {
        [self.motionManager stopDeviceMotionUpdates];
    }
}

#pragma mark - Core Motion Methods

-(void)deviceMotionDidUpdate:(CMDeviceMotion *)deviceMotion
{
    // Called when the deviceMotion property of our CMMotionManger updates.
    // Recalculates the gradient locations.
    
    // We need to account for the interface's orientation when calculating the relative roll.
    CGFloat roll = 0.0f;
    CGFloat pitch = 0.0f;
    switch ([[UIApplication sharedApplication] statusBarOrientation]) {
        case UIInterfaceOrientationPortrait:
            roll = deviceMotion.attitude.roll;
            pitch = deviceMotion.attitude.pitch;
            break;
        case UIInterfaceOrientationPortraitUpsideDown:
            roll = -deviceMotion.attitude.roll;
            pitch = -deviceMotion.attitude.pitch;
            break;
        case UIInterfaceOrientationLandscapeLeft:
            roll = -deviceMotion.attitude.pitch;
            pitch = -deviceMotion.attitude.roll;
            break;
        case UIInterfaceOrientationLandscapeRight:
            roll = deviceMotion.attitude.pitch;
            pitch = deviceMotion.attitude.roll;
            break;
    }
    
    // Update the image with the calculated values. 
    [self updateButtonImageForRoll:roll pitch:pitch];
}

@end
