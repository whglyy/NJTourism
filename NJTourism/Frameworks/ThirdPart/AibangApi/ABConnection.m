//
//  ABConnection.m
//  FatFist
//
//  Created by lyywhg on 13-5-24.
//
//

#import "ABConnection.h"

@implementation ABConnection

@synthesize connection = _connection, callback = _callback;

-(id) init {
    self = [super init];
    if (self) {
        _bufData = [[NSMutableData alloc] init];
    }
    return self;
}

-(void) dealloc {
    [_bufData release];
    [_connection release];
    [super dealloc];
}

-(void) cancel{
    [_connection cancel];
}

-(void) execute {
    [_connection start];
}

#pragma mark NSURLConnectionDelegate

//appending receiving data
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [_bufData appendData:data];
    
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    if (_callback) {
        [_callback performSelector:@selector(handleError:WithConnection:) 
                        withObject:error 
                        withObject:self];
    }
}


- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    if ([response isKindOfClass:[NSHTTPURLResponse class]]) {
        NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)response;
        int statusCode = [httpResponse statusCode];
        if (statusCode == 200) {
            return;
        }
        NSString* errorMessage = nil;
        if (statusCode == 400) {
            errorMessage = [NSString stringWithString:@"请求的地址不存在或者参数不符合API规定"];
        }else if (statusCode == 401) {
            errorMessage = [NSString stringWithString:@"未授权"];
        }else if (statusCode == 404) {
            errorMessage = [NSString stringWithString:@"资源不存在"];
        }else if (statusCode == 500) {
            errorMessage = [NSString stringWithString:@"内部错误"];
        }else {
            errorMessage = [NSString stringWithString:@"错误"];
        }
        
//        [connection cancel];
        
        NSDictionary* errorInfo = [NSDictionary dictionaryWithObject:errorMessage 
                                                              forKey:NSLocalizedDescriptionKey];
        NSError* statusError = [NSError errorWithDomain:@"ServerStatusCode" 
                                                   code:statusCode 
                                               userInfo:errorInfo];
        if (_callback) {
            [_callback performSelector:@selector(handleError:WithConnection:) 
                            withObject:statusError 
                            withObject:self];
        }
    }
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection { 
    if (_callback) {
        [_callback performSelector:@selector(handleData:WithConnection:) 
                        withObject:_bufData 
                        withObject:self];
    }
}
@end
