//
//  AuthNavigationBar.m
//  FatFist
//
//  Created by lyywhg on 13-5-24.
//
//

#import "AuthNavigationBar.h"

@implementation AuthNavigationBar

- (void)drawRect:(CGRect)rect
{
    UIImage *image = [UIImage imageNamed:kNavigationBarBackgroundImage];
        
    [image drawInRect:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
}


@end
