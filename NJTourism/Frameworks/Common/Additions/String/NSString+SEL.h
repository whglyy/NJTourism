//
//  NSString_SEL.h
//  FatFist
//
//  Copyright 2011 FatFish. All rights reserved.
//
//

#import <Foundation/Foundation.h>


@interface NSString (NSString_SEL)

- (BOOL)isGetter;
- (BOOL)isSetter;

- (NSString *)getterToSetter;
- (NSString *)setterToGetter;

@end
