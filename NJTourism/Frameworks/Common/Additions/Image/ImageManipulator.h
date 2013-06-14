//
//  ImageManipulator.h
//  FatFist
//
//  Copyright 2011 FatFish. All rights reserved.
//
//

#import <UIKit/UIKit.h>


@interface ImageManipulator : NSObject {

}

+(UIImage *)makeRoundCornerImage:(UIImage*)img :(int) cornerWidth :(int) cornerHeight;
+(UIImage*)imageWithBorderFromImage:(UIImage*)source;
@end
