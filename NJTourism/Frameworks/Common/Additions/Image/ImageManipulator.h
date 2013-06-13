//
//  ImageManipulator.h
//  FatFist
//
//  Created by lyywhg on 13-5-24.
//
//

#import <UIKit/UIKit.h>


@interface ImageManipulator : NSObject {

}

+(UIImage *)makeRoundCornerImage:(UIImage*)img :(int) cornerWidth :(int) cornerHeight;
+(UIImage*)imageWithBorderFromImage:(UIImage*)source;
@end
