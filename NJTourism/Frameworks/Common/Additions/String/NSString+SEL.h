//
//  NSString_SEL.h
//  FatFist
//
//  Created by lyywhg on 13-5-24.
//
//

#import <Foundation/Foundation.h>


@interface NSString (NSString_SEL)

- (BOOL)isGetter;
- (BOOL)isSetter;

- (NSString *)getterToSetter;
- (NSString *)setterToGetter;

@end
