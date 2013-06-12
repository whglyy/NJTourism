//
//  StrikeThroughLabel.h
//  FatFist
//
//  Created by lyywhg on 12-2-9.
//  Copyright (c) 2012年 FatFist. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StrikeThroughLabel : UILabel
{
    BOOL isWithStrikeThrough_;
    
    UIImageView *line_;
}

@property (nonatomic, assign) BOOL isWithStrikeThrough;

@end
