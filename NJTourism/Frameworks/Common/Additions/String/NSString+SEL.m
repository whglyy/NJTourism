//
//  NSString+SEL.m
//  FatFist
//
//  Created by lyywhg on 13-5-24.
//
//

#import "NSString+SEL.h"


@implementation NSString (NSString_SEL)

- (BOOL)isGetter {
    
    return ![self isSetter];
}


- (BOOL)isSetter {
    
    return [self hasPrefix:@"set"];
}


- (NSString *)getterToSetter {
    
    NSRange firstChar, rest;
    firstChar.location  = 0;
    firstChar.length    = 1;
    rest.location       = 1;
    rest.length         = self.length - 1;
    
    return [NSString stringWithFormat:@"set%@%@:",
            [[self substringWithRange:firstChar] uppercaseString],
            [self substringWithRange:rest]];
}


- (NSString *)setterToGetter {
    
    NSRange firstChar, rest;
    firstChar.location  = 3;
    firstChar.length    = 1;
    rest.location       = 4;
    rest.length         = self.length - 5;
    
    return [NSString stringWithFormat:@"%@%@",
            [[self substringWithRange:firstChar] lowercaseString],
            [self substringWithRange:rest]];
}

@end
