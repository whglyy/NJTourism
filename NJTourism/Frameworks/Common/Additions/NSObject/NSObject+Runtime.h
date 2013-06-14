//
//  NSObject+Runtime.h
//  FatFist
//
//  Copyright 2011 FatFish. All rights reserved.
//
//
#import <objc/runtime.h>
@interface NSObject (Runtime)
- (NSArray *)getPropertiesNameList;
- (NSMutableDictionary *)getAllPropertyDic;
@end
