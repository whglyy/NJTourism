//
//  StrikeThroughLabel.h
//  FatFist
//
//  Copyright 2011 FatFish. All rights reserved.
//
//

#import <UIKit/UIKit.h>

@interface StrikeThroughLabel : UILabel
{
    BOOL isWithStrikeThrough_;
    
    UIImageView *line_;
}

@property (nonatomic, assign) BOOL isWithStrikeThrough;

@end
