//
//  NSString-NULL.h
//  FatFist
//
//  Created by lyywhg on 13-5-24.
//
//

#import <Foundation/Foundation.h>


@interface NSString (NSStringNULL)

- (id)initWithUTF8NULLString:(const char *)nullTerminatedCString;

@end
