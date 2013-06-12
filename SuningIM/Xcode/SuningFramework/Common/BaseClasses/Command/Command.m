//
//  Command.m
//  SuningEBuy
//
//  Created by  liukun on 12-11-16.
//  Copyright (c) 2012年 Suning. All rights reserved.
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
