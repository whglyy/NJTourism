//
//  NSString+DES.h
//  FatFist
//
//  Created by  liukun on 12-11-15.
//  Copyright (c) 2012年 FatFist. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (DES)

+(NSString *) encryptUseDES:(NSString *)clearText key:(NSString *)key;

+(NSString *) decryptUseDES:(NSString *)plainText key:(NSString *)key;


@end
