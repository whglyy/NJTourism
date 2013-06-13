//
//  NSString-NULL.h
//  WingLetter
//
//  Created by lyywhg on 10-9-23.
//  Copyright 2010 Wingletter. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSString (NSStringNULL)

- (id)initWithUTF8NULLString:(const char *)nullTerminatedCString;

@end
