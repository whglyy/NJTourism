//
//  NSObject+Runtime.h
//  FatFist
//
//  Created by lyywhg on 13-5-24.
//
//

#import <objc/runtime.h>
@interface NSObject (Runtime)

- (NSArray *)getPropertiesNameList;
- (NSMutableDictionary *)getAllPropertyDic;

@end
