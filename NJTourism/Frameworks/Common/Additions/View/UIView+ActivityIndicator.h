//
//  UIView+ActivityIndicator.h
//  FatFist
//
//  Copyright 2011 FatFish. All rights reserved.
//
//
#import <Foundation/Foundation.h>
#import "MBProgressHUD.h"
#import "LoadingHUDView.h"
#import "ToolTipView.h"
#import "BBTipView.h"
#define activityViewTag                0x98751234
#define hudViewTag                     0x98751235
#define toolViewTag                    0x98751255
@interface UIView (UIViewUtils) 
- (void)showActivityViewAtCenter;
- (void)showActivityViewAtCenter:(NSString*)indiTitle;
/*!
 @method
 @abstract 包含［成功logo］的popView
 @param indiTitle 描述信息 
 */
- (void)showSuccessTipViewAtCenter:(NSString*)indiTitle;
/*!
 @method
 @abstract 包含［失败logo］的popView
 @param indiTitle 描述信息
 */
- (void)showFailTipViewAtCenter:(NSString*)indiTitle;
- (void)hideActivityViewAtCenter;
- (LoadingHUDView *)createActivityViewAtCenter:(UIActivityIndicatorViewStyle)style;
- (LoadingHUDView *)createActivityViewAtCenter:(UIActivityIndicatorViewStyle)style title:(NSString*)indiTitle;
- (LoadingHUDView *)getActivityViewAtCenter;

- (void)showTipViewAtCenter:(NSString*)indiTitle posY:(CGFloat)y;
- (void)showTipViewAtCenter:(NSString*)indiTitle;
- (void)hideTipView;
- (BBTipView *)getTipView;

- (void)showHUDIndicatorViewAtCenter:(NSString *)indiTitle;
- (void)hideHUDIndicatorViewAtCenter;
- (void)showHUDIndicatorViewAtCenter:(NSString *)indiTitle yOffset:(CGFloat)y;
- (MBProgressHUD *)createHUDIndicatorViewAtCenter:(NSString *)indiTitle yOffset:(CGFloat)y;
- (MBProgressHUD *)getHUDIndicatorViewAtCenter;

@end

