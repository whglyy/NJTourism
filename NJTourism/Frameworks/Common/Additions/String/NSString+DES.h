//
//  NSString+DES.h
//  FatFist
//
//  Created by lyywhg on 13-5-24.
//
//

#import <Foundation/Foundation.h>

@interface NSString (DES)

+(NSString *) encryptUseDES:(NSString *)clearText key:(NSString *)key;

+(NSString *) decryptUseDES:(NSString *)plainText key:(NSString *)key;


@end
