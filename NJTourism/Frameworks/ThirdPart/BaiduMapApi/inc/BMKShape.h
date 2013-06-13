//
//  BMKShape.h
//  FatFist
//
//  Created by lyywhg on 13-5-24.
//
//

#import <Foundation/Foundation.h>
#import"BMKAnnotation.h"

/// 该类为一个抽象类，定义了基于BMKAnnotation的BMKShape类的基本属性和行为，不能直接使用，必须子类化之后才能使用
@interface BMKShape : NSObject <BMKAnnotation> {
@package
    NSString *_title;
    NSString *_subtitle;
}

/// 要显示的标题
@property (copy) NSString *title;
/// 要显示的副标题
@property (copy) NSString *subtitle;

@end
