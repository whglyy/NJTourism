//
//  NSString+SEL.m
//  FatFist
//
//  Copyright 2011 FatFish. All rights reserved.
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
