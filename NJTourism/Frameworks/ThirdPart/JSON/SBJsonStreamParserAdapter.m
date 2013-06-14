//
//
//  FatFist
//
//  Copyright 2011 FatFish. All rights reserved.
//
//

#import "SBJsonStreamParserAdapter.h"

@interface SBJsonStreamParserAdapter ()

- (void)pop;
- (void)parser:(SBJsonStreamParser *)parser found:(id)obj;

@end

@implementation SBJsonStreamParserAdapter

@synthesize delegate;
@synthesize levelsToSkip;

#pragma mark Housekeeping

- (id)init
{
    self = [super init];

    if (self)
    {
        keyStack = [[NSMutableArray alloc] initWithCapacity:32];
        stack = [[NSMutableArray alloc] initWithCapacity:32];

        currentType = SBJsonStreamParserAdapterNone;
    }

    return self;
}

- (void)dealloc
{
    [keyStack release];
    [stack release];
    [super dealloc];
}

#pragma mark Private methods

- (void)pop
{
    [stack removeLastObject];
    array = nil;
    dict = nil;
    currentType = SBJsonStreamParserAdapterNone;

    id value = [stack lastObject];

    if ([value isKindOfClass:[NSArray class]])
    {
        array = value;
        currentType = SBJsonStreamParserAdapterArray;
    }
    else if ([value isKindOfClass:[NSDictionary class]])
    {
        dict = value;
        currentType = SBJsonStreamParserAdapterObject;
    }
}

- (void)parser:(SBJsonStreamParser *)parser found:(id)obj
{
    NSParameterAssert(obj);

    switch (currentType)
    {
        case SBJsonStreamParserAdapterArray:
            [array addObject:obj];
            break;

        case SBJsonStreamParserAdapterObject:
            NSParameterAssert(keyStack.count);
            [dict setObject:obj forKey:[keyStack lastObject]];
            [keyStack removeLastObject];
            break;

        case SBJsonStreamParserAdapterNone:

            if ([obj isKindOfClass:[NSArray class]])
            {
                [delegate parser:parser foundArray:obj];
            }
            else
            {
                [delegate parser:parser foundObject:obj];
            }

            break;

        default:
            break;
    }
}

#pragma mark Delegate methods

- (void)parserFoundObjectStart:(SBJsonStreamParser *)parser
{
    if (++depth > levelsToSkip)
    {
        dict = [[NSMutableDictionary new] autorelease];
        [stack addObject:dict];
        currentType = SBJsonStreamParserAdapterObject;
    }
}

- (void)parser:(SBJsonStreamParser *)parser foundObjectKey:(NSString *)key_
{
    [keyStack addObject:key_];
}

- (void)parserFoundObjectEnd:(SBJsonStreamParser *)parser
{
    if (depth-- > levelsToSkip)
    {
        id value = [dict retain];
        [self pop];
        [self parser:parser found:value];
        [value release];
    }
}

- (void)parserFoundArrayStart:(SBJsonStreamParser *)parser
{
    if (++depth > levelsToSkip)
    {
        array = [[NSMutableArray new] autorelease];
        [stack addObject:array];
        currentType = SBJsonStreamParserAdapterArray;
    }
}

- (void)parserFoundArrayEnd:(SBJsonStreamParser *)parser
{
    if (depth-- > levelsToSkip)
    {
        id value = [array retain];
        [self pop];
        [self parser:parser found:value];
        [value release];
    }
}

- (void)parser:(SBJsonStreamParser *)parser foundBoolean:(BOOL)x
{
    [self parser:parser found:[NSNumber numberWithBool:x]];
}

- (void)parserFoundNull:(SBJsonStreamParser *)parser
{
    [self parser:parser found:[NSNull null]];
}

- (void)parser:(SBJsonStreamParser *)parser foundNumber:(NSNumber *)num
{
    [self parser:parser found:num];
}

- (void)parser:(SBJsonStreamParser *)parser foundString:(NSString *)string
{
    [self parser:parser found:string];
}

@end
