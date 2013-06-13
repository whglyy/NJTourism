//
//  BMKPointAnnotation.h
//  FatFist
//
//  Created by lyywhg on 13-5-24.
//
//

#import <Foundation/Foundation.h>
#import "BMKShape.h"
#import <CoreLocation/CLLocation.h>

///表示一个点的annotation
@interface BMKPointAnnotation : BMKShape {
	@package
    CLLocationCoordinate2D _coordinate;
}
///该点的坐标
@property (nonatomic, assign) CLLocationCoordinate2D coordinate;

@end
