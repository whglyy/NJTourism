//
//  OpenUDID.h
//  FatFist
//
//  Copyright 2011 FatFish. All rights reserved.
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
