//
//
//  FatFist
//
//  Copyright 2011 FatFish. All rights reserved.
//
//

#import "SBJsonStreamWriterAccumulator.h"

@implementation SBJsonStreamWriterAccumulator

@synthesize data;

- (id)init
{
    self = [super init];

    if (self)
    {
        data = [[NSMutableData alloc] initWithCapacity:8096u];
    }

    return self;
}

- (void)dealloc
{
    [data release];
    [super dealloc];
}

#pragma mark SBJsonStreamWriterDelegate

- (void)writer:(SBJsonStreamWriter *)writer appendBytes:(const void *)bytes length:(NSUInteger)length
{
    [data appendBytes:bytes length:length];
}

@end
