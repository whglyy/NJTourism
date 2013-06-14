//
//
//  FatFist
//
//  Copyright 2011 FatFish. All rights reserved.
//
//

#import "SBJsonStreamParserAccumulator.h"

@implementation SBJsonStreamParserAccumulator

@synthesize value;

- (void)dealloc
{
    [value release];
    [super dealloc];
}

#pragma mark SBJsonStreamParserAdapterDelegate

- (void)parser:(SBJsonStreamParser *)parser foundArray:(NSArray *)array
{
    value = [array retain];
}

- (void)parser:(SBJsonStreamParser *)parser foundObject:(NSDictionary *)dict
{
    value = [dict retain];
}

@end
