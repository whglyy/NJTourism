//
//  NJPageScrollViewCell.m
//  FatFist
//
//  Copyright 2011 FatFish. All rights reserved.
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
