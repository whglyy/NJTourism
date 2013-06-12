//
//  AuthNavigationBar.m
//  strongEBuy
//
//  Created by lyywhg on 12-4-13.
//  Copyright (c) 2012年 FatFist. All rights reserved.
//

#import "AuthNavigationBar.h"

@implementation AuthNavigationBar

- (void)drawRect:(CGRect)rect
{
    UIImage *image = [UIImage imageNamed:kNavigationBarBackgroundImage];
        
    [image drawInRect:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
}


@end
