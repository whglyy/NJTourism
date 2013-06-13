//
//  SNHUDIndicatorView.h
//  FatFist
//
//  Created by lyywhg on 13-5-24.
//
//

#import <Foundation/Foundation.h>

@interface SNHUDIndicatorView : MBRoundProgressView

@property (nonatomic, retain) UIImageView  *indicatorImgView;

- (void)startAnimation;
- (void)stopAnimation;
@end
