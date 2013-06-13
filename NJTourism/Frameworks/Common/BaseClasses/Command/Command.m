//
//  Command.m
//  FatFist
//
//  Created by lyywhg on 13-5-24.
//
//

#import "Command.h"

@implementation Command

+ (id)command
{
    return [[self alloc] init] ;
}

- (void) execute
{
    // should throw an exception.
}

- (void) undo
{
    // do nothing
    // subclasses need to override this
    // method to perform actual undo.
}



@end
