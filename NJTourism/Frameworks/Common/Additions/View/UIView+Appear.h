//
//  UIView+Appear.h
//  FatFist
//
//  Copyright 2011 FatFish. All rights reserved.
//
//
#import <UIKit/UIKit.h>

@interface UIView (Appear)
-(void)appear;
-(void)disappearWithCallback:(SEL)aSelector;
@end
