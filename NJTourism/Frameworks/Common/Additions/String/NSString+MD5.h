//
//  NSString-NULL.h
//  FatFist
//
//  Created by lyywhg on 13-5-24.
//
//

#import <Foundation/Foundation.h>


@interface NSString (NSString_MD5)

+ (NSString*)md5HexDigest:(NSString*)input;

@end

@interface NSData (MD5)

- (NSString *)md5HexDigest;

@end