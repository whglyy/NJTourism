//
//  UIViewAdditions.h
//  FatFist
//
//  Copyright 2011 FatFish. All rights reserved.
//
//

#import <UIKit/UIKit.h>

CGPoint demoLGStart(CGRect bounds);

CGPoint demoLGEnd(CGRect bounds);

CGPoint demoRGCenter(CGRect bounds);

CGFloat demoRGInnerRadius(CGRect bounds);

@interface UIView (TKCategory)


// DRAW GRADIENT
+ (void) drawLinearGradientInRect:(CGRect)rect colors:(CGFloat[])colors;


// DRAW ROUNDED RECTANGLE
+ (void) drawRoundRectangleInRect:(CGRect)rect withRadius:(CGFloat)radius color:(UIColor*)color;

// DRAW LINE
+ (void) drawLineInRect:(CGRect)rect red:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha;
+ (void) drawLineInRect:(CGRect)rect colors:(CGFloat[])colors;
+ (void) drawLineInRect:(CGRect)rect colors:(CGFloat[])colors width:(CGFloat)lineWidth cap:(CGLineCap)cap;

@end



