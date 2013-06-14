//
//
//  FatFist
//
//  Copyright 2011 FatFish. All rights reserved.
//
//

#import "NSObject+SBJson.h"
#import "SBJsonWriter.h"
#import "SBJsonParser.h"

@implementation NSObject (NSObject_SBJsonWriting)

- (NSString *)JSONRepresentation
{
    SBJsonWriter *writer = [[[SBJsonWriter alloc] init] autorelease];
    NSString     *json = [writer stringWithObject:self];

    if (!json)
    {
        DLog(@"-JSONRepresentation failed. Error is: %@", writer.error);
    }

    return json;
}

@end

@implementation NSString (NSString_SBJsonParsing)

- (id)JSONValue
{
    SBJsonParser *parser = [[[SBJsonParser alloc] init] autorelease];
    id            repr = [parser objectWithString:self];

    if (!repr)
    {
        DLog(@"-JSONValue failed. Error is: %@", parser.error);
    }

    return repr;
}

@end
