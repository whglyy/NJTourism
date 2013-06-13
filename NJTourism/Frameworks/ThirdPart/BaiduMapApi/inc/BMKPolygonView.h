//
//  BMKPolygonView.h
//  FatFist
//
//  Created by lyywhg on 13-5-24.
//
//

#import <UIKit/UIKit.h>

#import "BMKPolygon.h"
#import "BMKOverlayPathView.h"

/// 此类用于定义一个多边形View
@interface BMKPolygonView : BMKOverlayPathView

/**
 *根据指定的多边形生成一个多边形View
 *@param polygon 指定的多边形数据对象
 *@return 新生成的多边形View
 */
- (id)initWithPolygon:(BMKPolygon *)polygon;

/// 该View对应的多边形数据
@property (nonatomic, readonly) BMKPolygon *polygon;

@end
