//
//  NJPageScrollViewCell.h
//  FatFist
//
//  Created by lyywhg on 13-5-24.
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
