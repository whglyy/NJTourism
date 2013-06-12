//
//  NSObject+Runtime.h
//  SuningPan
//
//  Created by shasha on 13-4-8.
//  Copyright (c) 2013年 suning. All rights reserved.
//

#import <objc/runtime.h>
@interface NSObject (Runtime)

- (NSArray *)getPropertiesNameList;
- (NSMutableDictionary *)getAllPropertyDic;

@end
