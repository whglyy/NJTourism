//
//  NJPageScrollViewCell.h
//  FatFist
//
//  Copyright 2011 FatFish. All rights reserved.
//
//
#import <UIKit/UIKit.h>
@interface NJPageScrollViewCell : UIView
{
    @private
    NSString    *_reuseIdentifier;
}

@property (nonatomic, readwrite, copy) NSString *reuseIdentifier;
- (id)initWithReuseIdentifier:(NSString *)reuseIdentifier;
- (void)prepareForReuse;
@end
