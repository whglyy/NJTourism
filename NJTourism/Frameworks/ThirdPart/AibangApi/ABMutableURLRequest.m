//
//  ABMutableURLRequest.m
//  FatFist
//
//  Created by lyywhg on 13-5-24.
//
//

#import "ABMutableURLRequest.h"

@implementation ABMutableURLRequest

+ (NSMutableURLRequest *)requestGet:(NSString *)aUrl queryString:(NSString *)aQueryString {
	NSMutableString *url = [[NSMutableString alloc] initWithString:aUrl];
	if (aQueryString) {
		[url appendFormat:@"?%@", aQueryString];
	}
	NSMutableURLRequest *request = [[[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:url]] autorelease];
	[request setHTTPMethod:@"GET"];
	[request setTimeoutInterval:60.0f];
	[url release];
	return request;
}

+ (NSMutableURLRequest *)requestPost:(NSString *)aUrl queryString:(NSData *)data {
	NSMutableURLRequest *request = [[[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:aUrl]] autorelease];
	[request setHTTPMethod:@"POST"];
	[request setTimeoutInterval:60.0f];
	[request setValue:@"multipart/form-data;boundary=0194784892923" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:data];
	return request;
}

@end
