//
//
//  FatFist
//
//  Copyright 2011 FatFish. All rights reserved.
//
//

#import <UIKit/UIKit.h>
@interface UIImageTransformation : UIImage{
    
    
}

/*
 author：zhaofk
 date:2012-03-21
 work:FatFist for image transfamation
 param:
 1 (CGSize)targetSize the targetSize that you want to transformation
 2 (UIImage)image the UIImage that you want to change
 return:
 1 new image that after transaction
 */
- (UIImage*)imageByScalingAndCroppingForSize:(CGSize)targetSize image:(UIImage*)image;
@end
