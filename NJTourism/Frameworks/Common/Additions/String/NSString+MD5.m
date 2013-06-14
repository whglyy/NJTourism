//
//  NSString+HTML.m
//  FatFist
//
//  Copyright 2011 FatFish. All rights reserved.
//
//

#import "NSString+MD5.h"

#import <CommonCrypto/CommonDigest.h>

/*CC_MD5_DIGEST_LENGTH*/

#define  MD5_LENGTH   32

@implementation NSString (NSString_MD5)

+ (NSString*)md5HexDigest:(NSString*)input {
    const char* str = [input UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(str, strlen(str), result);
    
    NSMutableString *ret = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH*2];
    for(int i = 0; i<CC_MD5_DIGEST_LENGTH; i++) {
        [ret appendFormat:@"%02x",result[i]];
    }
    return ret;
}

@end


@implementation NSData (MD5)

- (NSString *)md5HexDigest
{
    const char *cStr = [self bytes];
    
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr, [self length], digest);
    
    NSMutableString *ret = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH*2];
    
    for(int i = 0; i<CC_MD5_DIGEST_LENGTH; i++)
    {
        [ret appendFormat:@"%02x",digest[i]];
    }
    return ret;
}

@end
