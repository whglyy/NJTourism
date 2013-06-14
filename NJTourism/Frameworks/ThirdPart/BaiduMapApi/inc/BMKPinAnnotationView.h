//
//  BMKPinAnnotationView.h
//  FatFist
//
//  Copyright 2011 FatFish. All rights reserved.
//
//

#import "BMKAnnotationView.h"


enum {
    BMKPinAnnotationColorRed = 0,
    BMKPinAnnotationColorGreen,
    BMKPinAnnotationColorPurple
};
typedef NSUInteger BMKPinAnnotationColor;

///提供类似大头针效果的annotation view
@interface BMKPinAnnotationView : BMKAnnotationView
{
@private
    BMKPinAnnotationColor _pinColor;
	BOOL _animatesDrop;
}
///大头针的颜色，有BMKPinAnnotationColorRed, BMKPinAnnotationColorGreen, BMKPinAnnotationColorPurple三种
@property (nonatomic) BMKPinAnnotationColor pinColor;
///动画效果
@property (nonatomic) BOOL animatesDrop;


@end

