//
//  SNHUDIndicatorView.h
//  FatFist
//
//  Created by lyywhg on 13-4-24.
//  Copyright (c) 2013年 FatFist. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SNHUDIndicatorView : MBRoundProgressView

@property (nonatomic, retain) UIImageView  *indicatorImgView;

- (void)startAnimation;
- (void)stopAnimation;
@end
