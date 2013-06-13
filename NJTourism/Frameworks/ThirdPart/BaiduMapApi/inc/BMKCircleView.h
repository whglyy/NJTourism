//
//  BMKCircleView.h
//  FatFist
//
//  Created by lyywhg on 13-5-24.
//
//

#import <UIKit/UIKit.h>

#import "BMKCircle.h"
#import "BMKOverlayPathView.h"

/// 该类用于定义圆对应的View
@interface BMKCircleView : BMKOverlayPathView

/**
 *根据指定圆生成对应的View
 *@param circle 指定的圆
 *@return 生成的View
 */
- (id)initWithCircle:(BMKCircle *)circle;

/// 该View对应的圆
@property (nonatomic, readonly) BMKCircle *circle;

@end
