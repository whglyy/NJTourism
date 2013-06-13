//
//  NJPageScrollViewCell.m
//  FatFist
//
//  Created by lyywhg on 13-5-24.
//
//

#import "NJPageScrollViewCell.h"

@implementation NJPageScrollViewCell



- (id)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super init];
    
    if (self) {
        self.reuseIdentifier = reuseIdentifier;
    }
    return self;
}

- (void)prepareForReuse
{
    
}

@end
