//
// NSString+BingTranslate.m
// BingTranslate
//
// Created by Árpád Goretity on 18/10/2011.
// Licensed under a CreativeCommons Attribution 3.0 Unported License
//

#import "NSString+BingTranslate.h"
#import "NSMutableString+BingTranslate.h"
#import "BTDefines.h"

@implementation NSString (BingTranslate)

+ (NSString *) keyWithObject:(NSObject *)object
{
	return [NSString stringWithFormat:@"%@", object];
}

- (NSArray *) translationResults
{
	NSArray *response = [self JSONValue];
	NSMutableArray *result = [NSMutableArray array];
	for (int i = 0; i < [response count]; i++)
    {
		NSDictionary *output = [response objectAtIndex:i];
		NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
		NSMutableString *translatedText = [[NSMutableString alloc] initWithString:[output objectForKey:@"TranslatedText"]];
		[translatedText unescapeJson];
		[dict setValue:translatedText forKey:BTResultKeyTranslation];
		NSString *from = [output objectForKey:@"From"];
		[dict setValue:from forKey:BTResultKeySourceLanguage];
		[result addObject:dict];
	}
	return result;
}

- (NSArray *) detectionResults
{
	NSArray *response = [self JSONValue];
	return response;
}


- (NSString *) urlEscapedString
{
	NSString *unpercent = [self stringByReplacingOccurrencesOfString:@"%" withString:@"%25"];
	NSString *unampersand = [unpercent stringByReplacingOccurrencesOfString:@"&" withString:@" and "];
	NSString *escaped = [unampersand stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
	return escaped;
}

@end

