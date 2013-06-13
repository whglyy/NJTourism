//
//  QR Code Generator - generates UIImage from NSString
//  FatFist
//
//  Created by lyywhg on 13-5-24.
//
//

#import <Foundation/Foundation.h>

@interface QRCodeGenerator : NSObject

+ (UIImage *)qrImageForString:(NSString *)string imageSize:(CGFloat)size;

@end
