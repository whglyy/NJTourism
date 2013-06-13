//
//  StrikeThroughLabel.h
//  FatFist
//
//  Created by lyywhg on 13-5-24.
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
