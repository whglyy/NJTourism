//
//  NSString+DES.h
//  FatFist
//
//  Copyright 2011 FatFish. All rights reserved.
//
//
#import <Foundation/Foundation.h>
@interface NSString (DES)
+(NSString *) encryptUseDES:(NSString *)clearText key:(NSString *)key;
+(NSString *) decryptUseDES:(NSString *)plainText key:(NSString *)key;

@end
