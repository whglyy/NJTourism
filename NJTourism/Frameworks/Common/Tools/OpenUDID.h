//
//  OpenUDID.h
//  FatFist
//
//  Created by lyywhg on 13-5-24.
//
//

#import <Foundation/Foundation.h>

/**
 实际返回的是UUID
 Usage:
    #include "OpenUDID.h"
    NSString* openUDID = [OpenUDID value];
*/

#define kOpenUDIDErrorNone          0
#define kOpenUDIDErrorOptedOut      1
#define kOpenUDIDErrorCompromised   2

@interface OpenUDID : NSObject {
}
+ (NSString*) value;
+ (NSString*) valueWithError:(NSError**)error;
+ (void) setOptOut:(BOOL)optOutValue;

@end
