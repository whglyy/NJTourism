//
//
//  FatFist
//
//  Copyright 2011 FatFish. All rights reserved.
//
//

@interface NSData (Base64)

+ (id)dataWithBase64EncodedString:(NSString *)string;     //  Padding '=' characters are optional. Whitespace is ignored.
- (NSString *)base64Encoding;

@end
