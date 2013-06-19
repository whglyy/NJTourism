//
//  Http.m
//  WingLetter
//
//  Created by Hubert Ryan on 10-8-10.
//  Copyright 2010 Apple Inc. All rights reserved.
//

#import "Http.h"

@implementation Http

+ (void)showAlertMessage
{
    AppDelegate *appDelegate = [AppDelegate currentAppDelegate];

    [appDelegate.netReach showNetworkAlertMessage];
}

+ (ASIFormDataRequest *)sendHttpRequest:(NSString *)funcName URL:(NSString *)URL UrlParaDic:(NSDictionary *)attributesDic Delegate:(id)Delegate SucessCallback:(SEL)SucessCallback FailCallback:(SEL)FailCallback
{
    if (URL == nil)
    {
        DLog(@"funcName=%@ sendHttpRequest url is nil!\n", URL);

        return nil;
    }

    if (![[AppDelegate currentAppDelegate] isNetReachable])
    {
        DLog(@" network is unavailable!\n");

        [Http showAlertMessage];

        return nil;
    }

    DLog(@"funcName=%@ sendHttpRequest url=%@  UrlParaDic=%@\n", funcName, URL, [attributesDic description]);

    NSURL *url = [[NSURL  alloc] initWithString:URL];

    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];

    if (attributesDic != nil)
    {
        NSArray *allKeys = [attributesDic allKeys];

        for (NSString *key in allKeys)
        {
            [request setPostValue:[attributesDic objectForKey:key] forKey:key];
        }
    }

    [request setDefaultResponseEncoding:NSUTF8StringEncoding];

    [request setDelegate:Delegate];

    [request setDidFinishSelector:SucessCallback];

    [request setDidFailSelector:FailCallback];

    [request startAsynchronous];

    TT_RELEASE_SAFELY(url);

    return request;
}

+ (ASIFormDataRequest *)sendHttpRequest:(NSString *)funcName URL:(NSString *)URL isHttps:(BOOL)isHttps UrlParaDic:(NSDictionary *)attributesDic Delegate:(id)Delegate SucessCallback:(SEL)SucessCallback FailCallback:(SEL)FailCallback
{
    if (URL == nil)
    {
        DLog(@"funcName=%@ sendHttpRequest url is nil!\n", URL);

        return nil;
    }

    if (![[AppDelegate currentAppDelegate] isNetReachable])
    {
        DLog(@" network is unavailable!\n");

        [Http showAlertMessage];

        return nil;
    }

    DLog(@"funcName=%@ sendHttpRequest url=%@  UrlParaDic=%@\n", funcName, URL, [attributesDic description]);

    NSURL *url = [[NSURL  alloc] initWithString:URL];

    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];

    if (attributesDic != nil)
    {
        NSArray *allKeys = [attributesDic allKeys];

        for (NSString *key in allKeys)
        {
            [request setPostValue:[attributesDic objectForKey:key] forKey:key];
        }
    }

    [request setDefaultResponseEncoding:NSUTF8StringEncoding];

    [request setDelegate:Delegate];

    [request setDidFinishSelector:SucessCallback];

    [request setDidFailSelector:FailCallback];

    if (isHttps)
    {
        [request setValidatesSecureCertificate:NO];
    }

    [request startAsynchronous];

    TT_RELEASE_SAFELY(url);

    return request;
}

+ (ASIHTTPRequest *)sendGetMethodHttpRequest:(NSString *)funcName URL:(NSString *)URL isHttps:(BOOL)isHttps UrlParaDic:(NSDictionary *)attributesDic Delegate:(id)Delegate SucessCallback:(SEL)SucessCallback FailCallback:(SEL)FailCallback
{
    if (URL == nil)
    {
        DLog(@"funcName=%@ sendHttpRequest url is nil!\n", URL);

        return nil;
    }

    if (![[AppDelegate currentAppDelegate] isNetReachable])
    {
        DLog(@" network is unavailable!\n");

        [Http showAlertMessage];

        return nil;
    }

    DLog(@"funcName=%@ sendHttpRequest url=%@  UrlParaDic=%@\n", funcName, URL, [attributesDic description]);

    NSMutableString *urlString = [[NSMutableString alloc] initWithString:URL];

    if (attributesDic != nil)
    {
        [urlString appendString:@"?"];
        NSArray *allKeys = [attributesDic allKeys];

        for (NSString *key in allKeys)
        {
            [urlString appendFormat:@"%@=%@&", key, [attributesDic objectForKey:key]];
        }
    }

    //	DLog(@"url:%@",[urlString substringWithRange:NSMakeRange(0, urlString.length-1)]);
    NSString *urlStr = [urlString substringWithRange:NSMakeRange(0, urlString.length - 1)];
    NSString *realUrl = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL    *url = [[NSURL  alloc] initWithString:realUrl];

    TT_RELEASE_SAFELY(urlString);

    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    DLog(@"url:%@", url);

    [request setDefaultResponseEncoding:NSUTF8StringEncoding];

    [request setDelegate:Delegate];

    request.shouldAttemptPersistentConnection = NO;

    [request setDidFinishSelector:SucessCallback];
    //
    [request setDidFailSelector:FailCallback];

    if (isHttps)
    {
        [request setValidatesSecureCertificate:NO];
    }

    [request startAsynchronous];

    TT_RELEASE_SAFELY(url);

    return request;
}

// add by diqun
+ (ASIHTTPRequest *)sendGetMethodHttpRequest:(NSString *)URL isHttps:(BOOL)isHttps UrlParaDic:(NSDictionary *)attributesDic Delegate:(id)Delegate
{
    if (URL == nil)
    {
        DLog(@"funcName=%@ sendHttpRequest url is nil!\n", URL);

        return nil;
    }

    DLog(@" sendHttpRequest url=%@  UrlParaDic=%@\n", URL, [attributesDic description]);

    NSMutableString *urlString = [[NSMutableString alloc] initWithString:URL];

    if (attributesDic != nil)
    {
        [urlString appendString:@"?"];
        NSArray *allKeys = [attributesDic allKeys];

        for (NSString *key in allKeys)
        {
            [urlString appendFormat:@"%@=%@&", key, [attributesDic objectForKey:key]];
        }
    }

    //	DLog(@"url:%@",[urlString substringWithRange:NSMakeRange(0, urlString.length-1)]);
    NSString *urlStr = [urlString substringWithRange:NSMakeRange(0, urlString.length - 1)];
    NSString *realUrl = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL    *url = [[NSURL  alloc] initWithString:realUrl];

    TT_RELEASE_SAFELY(urlString);

    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    DLog(@"url:%@", url);

    [request setDefaultResponseEncoding:NSUTF8StringEncoding];

    [request setDelegate:Delegate];

    request.shouldAttemptPersistentConnection = NO;

    if (isHttps)
    {
        [request setValidatesSecureCertificate:NO];
    }

    [request startAsynchronous];

    TT_RELEASE_SAFELY(url);

    return request;
}

// add by diqun
+ (ASIFormDataRequest *)sendPostMethodHttpRequest:(NSString *)URL
                                          isHttps:(BOOL)isHttps
                                       UrlParaDic:(NSDictionary *)attributesDic
                                         Delegate:(id)Delegate
{
    if (URL == nil)
    {
        DLog(@"funcName=%@ sendHttpRequest url is nil!\n", URL);

        return nil;
    }

    if (![[AppDelegate currentAppDelegate] isNetReachable])
    {
        DLog(@" network is unavailable!\n");

        [Http showAlertMessage];

        return nil;
    }

    DLog(@"sendHttpRequest url=%@  UrlParaDic=%@\n", URL, [attributesDic description]);

    NSURL *url = [[NSURL  alloc] initWithString:URL];

    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];

    if (attributesDic != nil)
    {
        NSArray *allKeys = [attributesDic allKeys];

        for (NSString *key in allKeys)
        {
            [request setPostValue:[attributesDic objectForKey:key] forKey:key];
        }
    }

    [request setDefaultResponseEncoding:NSUTF8StringEncoding];

    [request setDelegate:Delegate];

    if (isHttps)
    {
        [request setValidatesSecureCertificate:NO];
    }

    [request startAsynchronous];

    TT_RELEASE_SAFELY(url);

    return request;
}

@end
