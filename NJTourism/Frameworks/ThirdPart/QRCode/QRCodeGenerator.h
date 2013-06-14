//
//  QR Code Generator - generates UIImage from NSString
//  FatFist
//
//  Copyright 2011 FatFish. All rights reserved.
//
//
#import <Foundation/Foundation.h>
@interface QRCodeGenerator : NSObject
+ (UIImage *)qrImageForString:(NSString *)string imageSize:(CGFloat)size;
@end
