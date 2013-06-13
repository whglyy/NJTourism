//
//
//  FatFist
//
//  Created by lyywhg on 13-5-24.
//
//

@interface NSData (Base64)

+ (id)dataWithBase64EncodedString:(NSString *)string;     //  Padding '=' characters are optional. Whitespace is ignored.
- (NSString *)base64Encoding;

@end
