//
//  NSString-NULL.h
//  FatFist
//
//  Copyright 2011 FatFish. All rights reserved.
//
//
#import <Foundation/Foundation.h>

@interface NSString (NSString_MD5)
+ (NSString*)md5HexDigest:(NSString*)input;
@end
@interface NSData (MD5)
- (NSString *)md5HexDigest;
@end