//
//  ABMutableURLRequest.h
//  FatFist
//
//  Copyright 2011 FatFish. All rights reserved.
//
//

#import <Foundation/Foundation.h>

@interface ABMutableURLRequest : NSObject

//Return a request for http get method
+ (NSMutableURLRequest *)requestGet:(NSString *)aUrl queryString:(NSString *)aQueryString;

//Return a request for http post method
+ (NSMutableURLRequest *)requestPost:(NSString *)aUrl queryString:(NSData *)data;


@end
