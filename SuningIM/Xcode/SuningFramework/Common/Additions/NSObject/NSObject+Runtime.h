//
//  NSObject+Runtime.h
//  FatFist
//
//  Created by lyywhg on 13-4-8.
//  Copyright (c) 2013年 FatFist. All rights reserved.
//

#import <objc/runtime.h>
@interface NSObject (Runtime)

- (NSArray *)getPropertiesNameList;
- (NSMutableDictionary *)getAllPropertyDic;

@end
