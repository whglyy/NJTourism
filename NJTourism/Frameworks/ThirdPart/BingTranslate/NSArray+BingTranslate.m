//
// NSArray+BingTranslate.m
// BingTranslate
//
// Created by Árpád Goretity on 18/10/2011.
// Licensed under a CreativeCommons Attribution 3.0 Unported License
//

#import "NSArray+BingTranslate.h"
#import "NSString+BingTranslate.h"


@implementation NSArray (BingTranslate)

- (NSString *) escapedJsonString {
	NSString *json = [self JSONRepresentation];
	NSString *ret = [json urlEscapedString];
	return ret;
}

@end

