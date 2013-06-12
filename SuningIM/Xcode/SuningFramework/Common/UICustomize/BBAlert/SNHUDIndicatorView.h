//
//  SNHUDIndicatorView.h
//  SuningPan
//
//  Created by shasha on 13-4-24.
//  Copyright (c) 2013年 suning. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SNHUDIndicatorView : MBRoundProgressView

@property (nonatomic, retain) UIImageView  *indicatorImgView;

- (void)startAnimation;
- (void)stopAnimation;
@end
