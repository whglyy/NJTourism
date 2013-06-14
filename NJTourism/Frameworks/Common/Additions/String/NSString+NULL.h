//
//  NSString-NULL.h
//  FatFist
//
//  Copyright 2011 FatFish. All rights reserved.
//
//

#import <Foundation/Foundation.h>


@interface NSString (NSStringNULL)

- (id)initWithUTF8NULLString:(const char *)nullTerminatedCString;

@end
