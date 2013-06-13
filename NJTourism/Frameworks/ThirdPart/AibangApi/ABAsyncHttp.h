//
//  ABAsyncHttp.h
//  FatFist
//
//  Created by lyywhg on 13-5-24.
//
//

#import <Foundation/Foundation.h>

@interface ABAsyncHttp : NSObject


//Start a connection fro http get method and return it to delegate.
+ (NSURLConnection *)httpGet:(NSString *)aUrl queryString:(NSString *)aQueryString delegate:(id)aDelegare;

//Start a connection fro http post method and return it to delegate.
+ (NSURLConnection *)httpPost:(NSString *)aUrl queryString:(NSData *)data delegate:(id)aDelegare;

@end
