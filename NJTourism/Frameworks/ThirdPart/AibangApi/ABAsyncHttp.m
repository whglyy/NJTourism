//
//  ABAsyncHttp.m
//  FatFist
//
//  Copyright 2011 FatFish. All rights reserved.
//
//
#import "ABAsyncHttp.h"
#import "ABMutableURLRequest.h"
@implementation ABAsyncHttp
+(NSURLConnection *)httpGet:(NSString *)aUrl queryString:(NSString *)aQueryString delegate:(id)aDelegare {
	NSMutableURLRequest *request = [ABMutableURLRequest requestGet:aUrl queryString:aQueryString];
    
    NSURLConnection *connection=[NSURLConnection connectionWithRequest:request delegate:aDelegare];
    return connection; 
	
}
+ (NSURLConnection *)httpPost:(NSString *)aUrl queryString:(NSData *)data delegate:(id)aDelegare {
	NSMutableURLRequest *request = [ABMutableURLRequest requestPost:aUrl queryString:data];
    return [NSURLConnection connectionWithRequest:request delegate:aDelegare];
}
@end
