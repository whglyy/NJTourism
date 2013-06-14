//
//
//  FatFist
//
//  Copyright 2011 FatFish. All rights reserved.
//
//

#import <Foundation/Foundation.h>

@interface SBJsonUTF8Stream : NSObject {
    @private
    const char    *_bytes;
    NSMutableData *_data;
    NSUInteger     _length;
    NSUInteger     _index;
}

@property (assign) NSUInteger index;

- (void)appendData:(NSData *)data_;

- (BOOL)haveRemainingCharacters:(NSUInteger)chars;

- (void)skip;
- (void)skipWhitespace;
- (BOOL)skipCharacters:(const char *)chars length:(NSUInteger)len;

- (BOOL)getUnichar:(unichar *)ch;
- (BOOL)getNextUnichar:(unichar *)ch;
- (BOOL)getRetainedStringFragment:(NSString **)string;

- (NSString *)stringWithRange:(NSRange)range;

@end
