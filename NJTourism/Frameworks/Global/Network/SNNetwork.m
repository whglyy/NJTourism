//
//  SNNetwork.m
//  FatFist
//
//  Created by lyywhg on 13-5-24.
//
//

#import "SNNetwork.h"
#pragma mark -

@implementation NSObject(SNRequestResponder)

- (BOOL)isRequestResponder
{
	if ( [self respondsToSelector:@selector(handleRequest:)] )
	{
		return YES;
	}
	
	return NO;
}

- (SNRequest *)GET:(NSString *)url
{
	if ( [self isRequestResponder] )
	{
		SNRequest * request = [SNRequestQueue GET:url];
		[request addResponder:self];
        
		return request;
	}
	else
	{
		return nil;
	}
}

- (SNRequest *)GET:(NSString *)url params:(NSDictionary *)kvs{
    
    if ( [self isRequestResponder] )
	{
		SNRequest * request = [SNRequestQueue GET:url params:kvs];
		[request addResponder:self];
        //		request.responder = self;
		return request;
	}
	else
	{
		return nil;
	}
}

- (SNRequest *)GET:(NSString *)url ToPath:(NSString *)path{
    if ( [self isRequestResponder] )
	{
		SNRequest * request = [SNRequestQueue GET:url ToPath:path];
		[request addResponder:self];
        //		request.responder = self;
		return request;
	}
	else
	{
		return nil;
	}
}



- (SNRequest *)POST:(NSString *)url text:(NSString *)text
{
	if ( [self isRequestResponder] )
	{
		NSData * data = [text dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
		SNRequest * request = [SNRequestQueue POST:url data:data];
		[request addResponder:self];
		return request;
	}
	else
	{
		return nil;
	}
}

- (SNRequest *)POST:(NSString *)url data:(NSData *)data
{
	if ( [self isRequestResponder] )
	{
		SNRequest * request = [SNRequestQueue POST:url data:data];
		[request addResponder:self];
        //		request.responder = self;
		return request;
	}
	else
	{
		return nil;
	}
}

- (SNRequest *)POST:(NSString *)url dict:(NSDictionary *)kvs
{
	if ( [self isRequestResponder] )
	{
		SNRequest * request = [SNRequestQueue POST:url params:kvs];
		[request addResponder:self];
        //		request.responder = self;
		return request;
	}
	else
	{
		return nil;
	}
}

- (SNRequest *)POST:(NSString *)url params:(id)first, ...
{
	NSMutableDictionary * dict = [NSMutableDictionary dictionary];
	
	va_list args;
	va_start( args, first );
	
	for ( ;; )
	{
		NSObject<NSCopying> * key = [dict count] ? va_arg( args, NSObject * ) : first;
		if ( nil == key )
			break;
		
		NSObject * value = va_arg( args, NSObject * );
		if ( nil == value )
			break;
		
		DLog( @"POST, %@ = %@", [key description], [value description] );
		
		[dict setObject:value forKey:key];
	}
    
	if ( [self isRequestResponder] )
	{
		SNRequest * request = [SNRequestQueue POST:url params:dict];
		[request addResponder:self];
        //		request.responder = self;
		return request;
	}
	else
	{
		return nil;
	}
}

- (SNRequest *)POST:(NSString *)url files:(NSDictionary *)files
{
	if ( [self isRequestResponder] )
	{
		SNRequest * request = [SNRequestQueue POST:url files:files];
		[request addResponder:self];
        //		request.responder = self;
		return request;
	}
	else
	{
		return nil;
	}
}

- (SNRequest *)POST:(NSString *)url files:(NSDictionary *)files dict:(NSDictionary *)kvs
{
	if ( [self isRequestResponder] )
	{
		SNRequest * request = [SNRequestQueue POST:url files:files params:kvs];
		[request addResponder:self];
        //		request.responder = self;
		return request;
	}
	else
	{
		return nil;
	}
}

- (SNRequest *)POST:(NSString *)url files:(NSDictionary *)files params:(id)first, ...
{
	NSMutableDictionary * dict = [NSMutableDictionary dictionary];
    
    if ([first isKindOfClass:[NSDictionary class]]) {
        NSDictionary *kvs = (NSDictionary *)first;
        [dict addEntriesFromDictionary:kvs];
    }else{
        
        va_list args;
        va_start( args, first );
        
        for ( ;; )
        {
            NSObject<NSCopying> * key = [dict count] ? va_arg( args, NSObject * ) : first;
            if ( nil == key )
                break;
            
            NSObject * value = va_arg( args, NSObject * );
            if ( nil == value )
                break;
            
            [dict setObject:value forKey:key];
        }
    }
	
	if ( [self isRequestResponder] )
	{
		SNRequest * request = [SNRequestQueue POST:url files:files params:dict];
		[request addResponder:self];
        //		request.responder = self;
		return request;
	}
	else
	{
		return nil;
	}
}

- (BOOL)requestingURL
{
	if ( [self isRequestResponder] )
	{
		return [SNRequestQueue requesting:nil byResponder:self];
	}
	else
	{
		return NO;
	}
}

- (BOOL)requestingURL:(NSString *)url
{
	if ( [self isRequestResponder] )
	{
		return [SNRequestQueue requesting:url byResponder:self];
	}
	else
	{
		return NO;
	}
}

- (BOOL)requestingCmd:(E_CMDCODE)cmdCode
{
	if ( [self isRequestResponder] )
	{
		return [SNRequestQueue requestingCmd:cmdCode byResponder:self];
	}
	else
	{
		return NO;
	}
}

- (NSArray *)requests
{
	return [SNRequestQueue requests:nil byResponder:self];
}

- (NSArray *)requests:(NSString *)url
{
	return [SNRequestQueue requests:url byResponder:self];
}

- (NSArray *)requestsOfCmd:(E_CMDCODE)cmdCode
{
    return [SNRequestQueue requestsCmd:cmdCode byResponder:self];
}

- (void)cancelRequests
{
	if ( [self isRequestResponder] )
	{
		[SNRequestQueue cancelRequestByResponder:self];
	}
}

- (void)cancelRequestByCmdCode:(E_CMDCODE)cmdCode
{
    if ( [self isRequestResponder] )
	{
        NSArray *requests = [self requestsOfCmd:cmdCode];
        for (SNRequest *request in requests)
        {
            if (request.cmdCode == cmdCode) {
                [SNRequestQueue cancelRequest:request];
            }
        }
	}
}

- (void)cancelRequestByUrl:(NSString *)url
{
    if ( [self isRequestResponder] )
	{
        NSArray *requests = [self requests:url];
        for (SNRequest *request in requests)
        {
            if (request.url.absoluteString == url) {
                [SNRequestQueue cancelRequest:request];
            }
        }
	}
}


- (void)handleRequest:(SNRequest *)request
{
    //Children complete
}

@end

#pragma mark -

@implementation SNRequest

@synthesize state = _state;
@synthesize errorCode = _errorCode;
@synthesize responders = _responders;
@synthesize userInfo = _userInfo;

@synthesize whenUpdate = _whenUpdate;

@synthesize initTimeStamp = _initTimeStamp;
@synthesize sendTimeStamp = _sendTimeStamp;
@synthesize recvTimeStamp = _recvTimeStamp;
@synthesize doneTimeStamp = _doneTimeStamp;

@synthesize timeCostPending;	// 排队等待耗时
@synthesize timeCostOverDNS;	// 网络连接耗时（DNS）
@synthesize timeCostRecving;	// 网络收包耗时
@synthesize timeCostOverAir;	// 网络整体耗时

@synthesize created;
@synthesize sending;
@synthesize recving;
@synthesize failed;
@synthesize succeed;
//@synthesize cancelled;
@synthesize sendProgressed = _sendProgressed;
@synthesize recvProgressed = _recvProgressed;

@synthesize uploadPercent;
@synthesize uploadBytes;
@synthesize uploadTotalBytes;
@synthesize downloadPercent;
@synthesize downloadBytes;
@synthesize downloadTotalBytes;

@synthesize jsonItems = _jsonItems;
@synthesize cmdCode = _cmdCode;
@synthesize postDataDic = _postDataDic;

- (id)initWithURL:(NSURL *)newURL
{
	self = [super initWithURL:newURL];
	if ( self )
	{
		_state = SNRequestState_Created;
		_errorCode = 0;
		
		_responders = [[NSMutableArray alloc] init];
		_userInfo = [[NSMutableDictionary alloc] init];
		
		_whenUpdate = nil;
		
		_sendProgressed = NO;
		_recvProgressed = NO;
		
		_initTimeStamp = [NSDate timeIntervalSinceReferenceDate];
		_sendTimeStamp = _initTimeStamp;
		_recvTimeStamp = _initTimeStamp;
		_doneTimeStamp = _initTimeStamp;
        
        [self setDefaultResponseEncoding:NSUTF8StringEncoding];
	}
    
	return self;
}

- (NSString *)description
{
	return [NSString stringWithFormat:@"%@ %@, state ==> %d, %d/%d",
			self.requestMethod, [self.url absoluteString],
			self.state,
			[self uploadBytes], [self downloadBytes]];
}

- (id)jsonItems
{
    return [[self responseString] objectFromJSONString];
}

- (void)dealloc
{
	self.whenUpdate = nil;
	
    for (NSObject *obj in _responders)
    {
        [obj retain];
    }
	[_responders removeAllObjects];
    
	[_responders release];
	
	[_userInfo removeAllObjects];
	[_userInfo release];
    
    [_jsonItems release];
    [_postDataDic release];
	
	[super dealloc];
}

- (CGFloat)uploadPercent
{
	NSUInteger bytes1 = self.uploadBytes;
	NSUInteger bytes2 = self.uploadTotalBytes;
	
	return bytes2 ? ((CGFloat)bytes1 / (CGFloat)bytes2) : 0.0f;
}

- (NSUInteger)uploadBytes
{
	if ( [self.requestMethod isEqualToString:@"GET"] )
	{
		return 0;
	}
	else if ( [self.requestMethod isEqualToString:@"POST"] )
	{
		return self.postLength;
	}
	
	return 0;
}

- (NSUInteger)uploadTotalBytes
{
	if ( [self.requestMethod isEqualToString:@"GET"] )
	{
		return 0;
	}
	else if ( [self.requestMethod isEqualToString:@"POST"] )
	{
		return self.postLength;
	}
	
	return 0;
}

- (CGFloat)downloadPercent
{
	NSUInteger bytes1 = self.downloadBytes;
	NSUInteger bytes2 = self.downloadTotalBytes;
	
	return bytes2 ? ((CGFloat)bytes1 / (CGFloat)bytes2) : 0.0f;
}

- (NSUInteger)downloadBytes
{
	return [[self rawResponseData] length];
}

- (NSUInteger)downloadTotalBytes
{
	return self.contentLength;
}

- (BOOL)is:(NSString *)text
{
	return [[self.url absoluteString] isEqualToString:text];
}

- (void)callResponders
{
	for ( NSObject * responder in _responders )
	{
		if ( [responder respondsToSelector:@selector(handleRequest:)] )
		{
			[responder performSelector:@selector(handleRequest:) withObject:self];
		}
	}
}

- (void)forwardResponder:(NSObject *)obj
{
	if ( [obj respondsToSelector:@selector(handleRequest:)] )
	{
        [obj performSelector:@selector(handleRequest:) withObject:self];
	}
}

- (void)changeState:(NSUInteger)state
{
	if ( state != _state )
	{
		_state = state;
        
        switch (_state) {
            case SNRequestState_Sending:
                _sendTimeStamp = [NSDate timeIntervalSinceReferenceDate];
                break;
            case SNRequestState_Recving:
                _recvTimeStamp = [NSDate timeIntervalSinceReferenceDate];
                break;
            case SNRequestState_Failed:
            case SNRequestState_Success:
            case SNRequestState_Cancel:
                _doneTimeStamp = [NSDate timeIntervalSinceReferenceDate];
                break;
            default:
                break;
        }
        
		[self callResponders];
		
		if ( self.whenUpdate )
		{
			self.whenUpdate( self );
		}
	}
}

- (void)updateSendProgress
{
	_sendProgressed = YES;
	
	[self callResponders];
	
	if ( self.whenUpdate )
	{
		self.whenUpdate( self );
	}
	
	_sendProgressed = NO;
}

- (void)updateRecvProgress
{
	if (_state == SNRequestState_Success ||
        _state == SNRequestState_Failed ||
        _state == SNRequestState_Cancel )
		return;
    
    if ( self.didUseCachedResponse )
		return;
    
	_recvProgressed = YES;
	
	[self callResponders];
	
	if ( self.whenUpdate )
	{
		self.whenUpdate( self );
	}
	
	_recvProgressed = NO;
}

- (NSTimeInterval)timeCostPending
{
	return _sendTimeStamp - _initTimeStamp;
}

- (NSTimeInterval)timeCostOverDNS
{
	return _recvTimeStamp - _sendTimeStamp;
}

- (NSTimeInterval)timeCostRecving
{
	return _doneTimeStamp - _recvTimeStamp;
}

- (NSTimeInterval)timeCostOverAir
{
	return _doneTimeStamp - _sendTimeStamp;
}

- (BOOL)created
{
	return SNRequestState_Created == _state ? YES : NO;
}

- (BOOL)sending
{
	return SNRequestState_Sending == _state ? YES : NO;
}

- (BOOL)recving
{
	return SNRequestState_Recving == _state ? YES : NO;
}

- (BOOL)succeed
{
	return SNRequestState_Success == _state ? YES : NO;
}

- (BOOL)failed
{
	return SNRequestState_Failed == _state ? YES : NO;
}

- (BOOL)cancelled
{
	return SNRequestState_Cancel == _state ? YES : NO;
}

- (BOOL)hasResponder:(id)responder
{
	return [_responders containsObject:responder];
}

- (void)addResponder:(id)responder
{
	[_responders addObject:responder];
    [responder release];
}

- (void)removeResponder:(id)responder
{
    if ([_responders containsObject:responder]) {
        [responder retain];
        [_responders removeObject:responder];
    }
}

- (void)removeAllResponders
{
    for (NSObject *obj in _responders)
    {
        [obj retain];
    }
	[_responders removeAllObjects];
}



@end


#pragma mark -

@implementation SNRequestQueue

@synthesize merge = _merge;
@synthesize online = _online;

@synthesize	blackListEnable = _blackListEnable;
@synthesize	blackListTimeout = _blackListTimeout;
@synthesize	blackList = _blackList;

@synthesize bytesUpload = _bytesUpload;
@synthesize bytesDownload = _bytesDownload;

@synthesize delay = _delay;
@synthesize requests = _requests;

@synthesize whenCreate = _whenCreate;
@synthesize whenUpdate = _whenUpdate;

+ (BOOL)isReachableViaWIFI
{
	return YES;
}

+ (BOOL)isReachableViaWLAN
{
	return YES;
}

+ (BOOL)isNetworkInUse
{
	return ([[SNRequestQueue sharedInstance].requests count] > 0) ? YES : NO;
}

+ (NSUInteger)bandwidthUsedPerSecond
{
	return [ASIHTTPRequest averageBandwidthUsedPerSecond];
}

+ (SNRequestQueue *)sharedInstance
{
	static SNRequestQueue * __sharedInstance = nil;
    
	@synchronized(self)
	{
		if ( nil == __sharedInstance )
		{
			__sharedInstance = [[SNRequestQueue alloc] init];
            
            //			[ASIHTTPRequest setShouldThrottleBandwidthForWWAN:YES];
            //			[ASIHTTPRequest throttleBandwidthForWWANUsingLimit:32 * 1024];	// 32K
			[[ASIHTTPRequest sharedQueue] setMaxConcurrentOperationCount:10];
		}
	}
	
	return (SNRequestQueue *)__sharedInstance;
}

- (id)init
{
	self = [super init];
	if ( self )
	{
		_delay = 0.1f;
		_merge = YES;
		_online = YES;
		_requests = [[NSMutableArray alloc] init];
        
		_blackListEnable = YES;
		_blackListTimeout = DEFAULT_BLACKLIST_TIMEOUT;
		_blackList = [[NSMutableDictionary alloc] init];
	}
	
	return self;
}

- (void)setOnline:(BOOL)en
{
	_online = en;
    
	if ( NO == _online )
	{
		[self cancelAllRequests];
	}
}

- (void)dealloc
{
	[self cancelAllRequests];
    
	[_requests removeAllObjects];
	[_requests release];
    
	[_blackList removeAllObjects];
	[_blackList release];
	
	self.whenCreate = nil;
	self.whenUpdate = nil;
    
	[super dealloc];
}

- (BOOL)checkResourceBroken:(NSString *)url
{
	if ( _blackListEnable )
	{
		NSDate * date = nil;
		NSDate * now = [NSDate date];
		
		date = [_blackList objectForKey:url];
		if ( date && ([date timeIntervalSince1970] - [now timeIntervalSince1970]) < _blackListTimeout )
		{
			DLog( @"resource broken: %@", url );
			return YES;
		}
	}
    
	return NO;
}

+ (SNRequest *)GET:(NSString *)url
{
	return [[SNRequestQueue sharedInstance] GET:url sync:NO];
}

- (SNRequest *)GET:(NSString *)url sync:(BOOL)sync
{
    url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
	if ( NO == _online )
		return nil;
	
	if ( [self checkResourceBroken:url] )
	{
		return nil;
	}
    
	SNRequest * request = nil;
    
	if ( NO == sync && _merge )
	{
		for ( SNRequest * req in _requests )
		{
			if ( [req.url.absoluteString isEqualToString:url] )
			{
				return req;
			}
		}
	}
    
	DLog( @"GET %@\n", url );
    
	request = [[SNRequest alloc] initWithURL:[NSURL URLWithString:url]];
	request.timeOutSeconds = DEFAULT_GET_TIMEOUT;
	request.requestMethod = @"GET";
	request.postBody = nil;
	[request setDelegate:self];
	[request setDownloadProgressDelegate:self];
	[request setUploadProgressDelegate:self];
    [request setShowAccurateProgress:YES];
	[request setNumberOfTimesToRetryOnTimeout:0];
#if TARGET_OS_IPHONE && __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_4_0
	[request setShouldContinueWhenAppEntersBackground:YES];
#endif
    
	[request setThreadPriority:0.5];
	[request setQueuePriority:NSOperationQueuePriorityLow];
    
	[_requests addObject:request];
	
	if ( self.whenCreate )
	{
		self.whenCreate( request );
	}
    
	if ( sync )
	{
		[request startSynchronous];
	}
	else
	{
		if ( _delay )
		{
			[request performSelector:@selector(startAsynchronous)
						  withObject:nil
						  afterDelay:_delay];
		}
		else
		{
			[request startAsynchronous];
		}
	}
    
	return [request autorelease];
}


+ (SNRequest *)GET:(NSString *)url params:(NSDictionary *)kvs
{
	return [[SNRequestQueue sharedInstance] GET:url params:kvs sync:NO];
}

- (SNRequest *)GET:(NSString *)url params:(NSDictionary *)kvs sync:(BOOL)sync
{
    NSString *absoluteUrl = [url stringByAddingQueryDictionary:kvs];
    
    absoluteUrl = [absoluteUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
	if ( NO == _online )
		return nil;
	
	if ( [self checkResourceBroken:absoluteUrl] )
	{
		return nil;
	}
    
	SNRequest * request = nil;
    
	if ( NO == sync && _merge )
	{
		for ( SNRequest * req in _requests )
		{
			if ( [req.url.absoluteString isEqualToString:absoluteUrl] )
			{
				return req;
			}
		}
	}
    
	DLog( @"GET %@\n", absoluteUrl );
    
	request = [[SNRequest alloc] initWithURL:[NSURL URLWithString:absoluteUrl]];
	request.timeOutSeconds = DEFAULT_GET_TIMEOUT;
	request.requestMethod = @"GET";
	request.postBody = nil;
	[request setDelegate:self];
	[request setDownloadProgressDelegate:self];
	[request setUploadProgressDelegate:self];
    
    [request setValidatesSecureCertificate:YES];
    
	[request setNumberOfTimesToRetryOnTimeout:0];
#if TARGET_OS_IPHONE && __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_4_0
	[request setShouldContinueWhenAppEntersBackground:YES];
#endif
    
	[request setThreadPriority:0.5];
	[request setQueuePriority:NSOperationQueuePriorityLow];
    
	[_requests addObject:request];
	
	if ( self.whenCreate )
	{
		self.whenCreate( request );
	}
    
	if ( sync )
	{
		[request startSynchronous];
	}
	else
	{
		if ( _delay )
		{
			[request performSelector:@selector(startAsynchronous)
						  withObject:nil
						  afterDelay:_delay];
		}
		else
		{
			[request startAsynchronous];
		}
	}
    
	return [request autorelease];
}


+ (SNRequest *)GET:(NSString *)url ToPath:(NSString *)path{
	return [[SNRequestQueue sharedInstance] GET:url ToPath:path sync:NO];
}

- (SNRequest *)GET:(NSString *)url ToPath:(NSString *)path sync:(BOOL)sync
{
    NSString *absoluteUrl = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
	if ( NO == _online )
		return nil;
   	
	if ( [self checkResourceBroken:absoluteUrl] )
	{
		return nil;
	}
    
	SNRequest * request = nil;
    
	if ( NO == sync && _merge )
	{
		for ( SNRequest * req in _requests )
		{
			if ( [req.url.absoluteString isEqualToString:absoluteUrl] )
			{
				return req;
			}
		}
	}
    
	request = [[SNRequest alloc] initWithURL:[NSURL URLWithString:absoluteUrl]];
	request.timeOutSeconds = DEFAULT_POST_TIMEOUT;
	request.requestMethod = @"GET";
	[request setDelegate:self];
	[request setDownloadProgressDelegate:self];
	[request setUploadProgressDelegate:self];
    [request setDownloadDestinationPath:path];//下载路径
    [request setShowAccurateProgress:YES];
	[request setNumberOfTimesToRetryOnTimeout:2];
    request.shouldRedirect = YES;
    request.shouldUseRFC2616RedirectBehaviour = YES;
#if TARGET_OS_IPHONE && __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_4_0
	[request setShouldContinueWhenAppEntersBackground:YES];
#endif
	[request setThreadPriority:1.0];
	[request setQueuePriority:NSOperationQueuePriorityHigh];
	
	[_requests addObject:request];
	
	if ( self.whenCreate )
	{
		self.whenCreate( request );
	}
    
	if ( sync )
	{
		[request startSynchronous];
	}
	else
	{
		if ( _delay )
		{
			[request performSelector:@selector(startAsynchronous)
						  withObject:nil
						  afterDelay:_delay];
		}
		else
		{
			[request startAsynchronous];
		}
	}
	
	return [request autorelease];
}

+ (SNRequest *)POST:(NSString *)url data:(NSData *)data
{
	return [[SNRequestQueue sharedInstance] POST:url data:data sync:NO];
}

- (SNRequest *)POST:(NSString *)url data:(NSData *)data sync:(BOOL)sync
{
	if ( NO == _online )
		return nil;
	
	SNRequest * request = nil;
	
	DLog( @"POST %@\n", url );
	
	request = [[SNRequest alloc] initWithURL:[NSURL URLWithString:url]];
	request.timeOutSeconds = DEFAULT_POST_TIMEOUT;
	request.requestMethod = @"POST";
	request.postFormat = ASIMultipartFormDataPostFormat; // ASIRawPostFormat;
	request.postBody = [NSMutableData dataWithData:data];
	[request setDelegate:self];
	[request setDownloadProgressDelegate:self];
	[request setUploadProgressDelegate:self];
	[request setNumberOfTimesToRetryOnTimeout:0];
#if TARGET_OS_IPHONE && __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_4_0
	[request setShouldContinueWhenAppEntersBackground:YES];
#endif
    
	[request setThreadPriority:1.0];
	[request setQueuePriority:NSOperationQueuePriorityHigh];
    
	[_requests addObject:request];
	
	if ( self.whenCreate )
	{
		self.whenCreate( request );
	}
    
	if ( sync )
	{
		[request startSynchronous];
	}
	else
	{
		if ( _delay )
		{
			[request performSelector:@selector(startAsynchronous)
						  withObject:nil
						  afterDelay:_delay];
		}
		else
		{
			[request startAsynchronous];
		}
	}
	
	return [request autorelease];
}

+ (SNRequest *)POST:(NSString *)url params:(NSDictionary *)kvs
{
	return [[SNRequestQueue sharedInstance] POST:url params:kvs sync:NO];
}

- (SNRequest *)POST:(NSString *)url params:(NSDictionary *)kvs sync:(BOOL)sync
{
	if ( NO == _online )
		return nil;
    
	SNRequest * request = nil;
    
	DLog( @"POST %@\n", url );
    
	request = [[SNRequest alloc] initWithURL:[NSURL URLWithString:url]];
#ifdef DEBUG
    request.postDataDic = kvs;
#endif
	request.timeOutSeconds = DEFAULT_POST_TIMEOUT;
	request.requestMethod = @"POST";
	request.postFormat = ASIURLEncodedPostFormat;
	[request setDelegate:self];
	[request setDownloadProgressDelegate:self];
	[request setUploadProgressDelegate:self];
    
	[request setNumberOfTimesToRetryOnTimeout:0];
#if TARGET_OS_IPHONE && __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_4_0
	[request setShouldContinueWhenAppEntersBackground:YES];
#endif
	
	[request setThreadPriority:1.0];
	[request setQueuePriority:NSOperationQueuePriorityHigh];
	
	NSArray * keys = [kvs allKeys];
	for ( NSString * key in keys )
	{
		[request setPostValue:[kvs objectForKey:key] forKey:key];
	}
    
	[_requests addObject:request];
	
	if ( self.whenCreate )
	{
		self.whenCreate( request );
	}
    
	if ( sync )
	{
		[request startSynchronous];
	}
	else
	{
		if ( _delay )
		{
			[request performSelector:@selector(startAsynchronous)
						  withObject:nil
						  afterDelay:_delay];
		}
		else
		{
			[request startAsynchronous];
		}
	}
	
	return [request autorelease];
}

+ (SNRequest *)POST:(NSString *)url files:(NSDictionary *)files
{
	return [[SNRequestQueue sharedInstance] POST:url files:files params:nil sync:NO];
}

+ (SNRequest *)POST:(NSString *)url files:(NSDictionary *)files params:(NSDictionary *)kvs
{
	return [[SNRequestQueue sharedInstance] POST:url files:files params:kvs sync:NO];
}

- (SNRequest *)POST:(NSString *)url files:(NSDictionary *)files params:(NSDictionary *)kvs sync:(BOOL)sync
{
	if ( NO == _online )
		return nil;
    
	SNRequest * request = nil;
	
	DLog( @"POST %@\n", url );
    
	request = [[SNRequest alloc] initWithURL:[NSURL URLWithString:url]];
#ifdef DEBUG
    request.postDataDic = kvs;
#endif
	request.timeOutSeconds = DEFAULT_UPLOAD_TIMEOUT;
	request.requestMethod = @"POST";
	request.postFormat = ASIMultipartFormDataPostFormat;
	[request setDelegate:self];
	[request setDownloadProgressDelegate:self];
	[request setUploadProgressDelegate:self];
    [request setShowAccurateProgress:YES];
	[request setNumberOfTimesToRetryOnTimeout:0];
#if TARGET_OS_IPHONE && __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_4_0
	[request setShouldContinueWhenAppEntersBackground:YES];
#endif	// #if TARGET_OS_IPHONE && __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_4_0
	
	[request setThreadPriority:1.0];
	[request setQueuePriority:NSOperationQueuePriorityHigh];
	
	if ( kvs )
	{
		NSArray * keys = [kvs allKeys];
		for ( NSString * key in keys )
		{
			[request setPostValue:[kvs objectForKey:key] forKey:key];
		}
	}
    
	if ( files )
	{
		NSArray * fileNames = [files allKeys];
		for ( NSInteger i = 0; i < [fileNames count]; ++i )
		{
			NSString * filePath = [fileNames objectAtIndex:i];
			NSObject * fileData = [files objectForKey:filePath];
            
			if ( filePath && fileData )
			{
                /*
                 if ( [fileData isKindOfClass:[NSString class]] )
                 {
                 NSString * string = (NSString *)fileData;
                 [string writeToFile:filePath
                 atomically:YES
                 encoding:NSUTF8StringEncoding
                 error:NULL];
                 }
                 else if ( [fileData isKindOfClass:[NSData class]] )
                 {
                 NSData * data = (NSData *)fileData;
                 [data writeToFile:filePath
                 options:NSDataWritingAtomic
                 error:NULL];
                 }
                 else
                 {
                 NSAssert( 0, @"non-support type of file data" );
                 }
                 */
				[request setFile:filePath forKey:filePath];
			}
		}
	}
    
	[_requests addObject:request];
	
	if ( self.whenCreate )
	{
		self.whenCreate( request );
	}
	if ( sync )
	{
		[request startSynchronous];
	}
	else
	{
		if ( _delay )
		{
			[request performSelector:@selector(startAsynchronous)
						  withObject:nil
						  afterDelay:_delay];
		}
		else
		{
			[request startAsynchronous];
		}
	}
    
	return [request autorelease];
}

+ (BOOL)requesting:(NSString *)url
{
	return [[SNRequestQueue sharedInstance] requesting:url];
}

- (BOOL)requesting:(NSString *)url
{
	for ( SNRequest * request in _requests )
	{
		if ( [[request.url absoluteString] isEqualToString:url] )
		{
			return YES;
		}
	}
    
	return NO;
}

+ (BOOL)requesting:(NSString *)url byResponder:(id)responder
{
	return [[SNRequestQueue sharedInstance] requesting:url byResponder:responder];
}

- (BOOL)requesting:(NSString *)url byResponder:(id)responder
{
	for ( SNRequest * request in _requests )
	{
		if ( responder && NO == [request hasResponder:responder] /*request.responder != responder*/ )
			continue;
        
		if ( nil == url || [[request.url absoluteString] isEqualToString:url] )
		{
			return YES;
		}
	}
    
	return NO;
}

+ (BOOL)requestingCmd:(E_CMDCODE)cmd byResponder:(id)responder
{
    return [[SNRequestQueue sharedInstance] requestingCmd:cmd byResponder:responder];
}

- (BOOL)requestingCmd:(E_CMDCODE)cmdCode byResponder:(id)responder
{
    for (SNRequest * request in _requests )
	{
		if ( responder && NO == [request hasResponder:responder] )
			continue;
        
		if ( request.cmdCode == cmdCode )
		{
			return YES;
		}
	}
    
	return NO;
}

+ (NSArray *)requests:(NSString *)url
{
	return [[SNRequestQueue sharedInstance] requests:url];
}

- (NSArray *)requests:(NSString *)url
{
	NSMutableArray * array = [NSMutableArray array];
	
	for ( SNRequest * request in _requests )
	{
		if ( [[request.url absoluteString] isEqualToString:url] )
		{
			[array addObject:request];
		}
	}
	
	return array;
}

+ (NSArray *)requests:(NSString *)url byResponder:(id)responder
{
	return [[SNRequestQueue sharedInstance] requests:url byResponder:responder];
}

- (NSArray *)requests:(NSString *)url byResponder:(id)responder
{
	NSMutableArray * array = [NSMutableArray array];
    
	for (SNRequest * request in _requests )
	{
		if ( responder && NO == [request hasResponder:responder] )
			continue;
		
		if ( nil == url || [[request.url absoluteString] isEqualToString:url] )
		{
			[array addObject:request];
		}
	}
    
	return array;
}

+ (NSArray *)requestsCmd:(E_CMDCODE)cmd byResponder:(id)responder
{
    return [[SNRequestQueue sharedInstance] requestsOfCmd:cmd byResponder:responder];
}

- (NSArray *)requestsOfCmd:(E_CMDCODE)cmdCode byResponder:(id)responder
{
    NSMutableArray * array = [NSMutableArray array];
    
	for ( SNRequest * request in _requests )
	{
		if ( responder && NO == [request hasResponder:responder] )
			continue;
		
		if ( request.cmdCode == cmdCode )
		{
			[array addObject:request];
		}
	}
    
	return array;
}

+ (void)cancelRequest:(SNRequest *)request
{
	[[SNRequestQueue sharedInstance] cancelRequest:request];
}

- (void)cancelRequest:(SNRequest *)request
{
	[NSObject cancelPreviousPerformRequestsWithTarget:request selector:@selector(startAsynchronous) object:nil];
	
	if ( [_requests containsObject:request] )
	{
		if ( request.created || request.sending || request.recving )
		{
			[request changeState:SNRequestState_Cancel];
			
			[request clearDelegatesAndCancel];
			[request removeAllResponders];
		}
        else
        {
            [request removeAllResponders];
        }
		
		[_requests removeObject:request];
	}
}

+ (void)cancelRequestByResponder:(id)responder
{
	[[SNRequestQueue sharedInstance] cancelRequestByResponder:responder];
}

- (void)cancelRequestByResponder:(id)responder
{
	if ( nil == responder )
	{
		[self cancelAllRequests];
	}
	else
	{
		NSMutableArray * tempArray = [NSMutableArray array];
		
		for ( SNRequest * request in _requests )
		{
			if ( [request hasResponder:responder] /* request.responder == responder */ )
			{
				[tempArray addObject:request];
			}
		}
		
		for ( SNRequest * request in tempArray )
		{
			[self cancelRequest:request];
		}
	}
}

+ (void)cancelAllRequests
{
	[[SNRequestQueue sharedInstance] cancelAllRequests];
}

- (void)cancelAllRequests
{
	for ( SNRequest * request in _requests )
	{
		[self cancelRequest:request];
	}
}

+ (void)blockURL:(NSString *)url
{
	[[SNRequestQueue sharedInstance] blockURL:url];
}

- (void)blockURL:(NSString *)url
{
	[_blackList setObject:[NSDate date] forKey:url];
}

+ (void)unblockURL:(NSString *)url
{
	[[SNRequestQueue sharedInstance] unblockURL:url];
}

- (void)unblockURL:(NSString *)url
{
	if ( [_blackList objectForKey:url] )
	{
		NSDate * date = [NSDate dateWithTimeInterval:(_blackListTimeout + 1.0f) sinceDate:[NSDate date]];
		[_blackList setObject:date forKey:url];
	}
}

- (NSArray *)requests
{
	return _requests;
}

#pragma mark -
#pragma mark ASIHTTPRequestDelegate

- (void)requestStarted:(ASIHTTPRequest *)request
{
	if ( NO == [request isKindOfClass:[SNRequest class]] )
		return;
    
	SNRequest * networkRequest = (SNRequest *)request;
	[networkRequest changeState:SNRequestState_Sending];
    
	_bytesUpload += request.postLength;
	
	if ( self.whenUpdate )
	{
		self.whenUpdate( networkRequest );
	}
}

- (void)request:(ASIHTTPRequest *)request didReceiveResponseHeaders:(NSDictionary *)responseHeaders
{
	if ( NO == [request isKindOfClass:[SNRequest class]] )
		return;
    
	SNRequest * networkRequest = (SNRequest *)request;
	[networkRequest changeState:SNRequestState_Recving];
	
	if ( self.whenUpdate )
	{
		self.whenUpdate( networkRequest );
	}
}

- (void)requestFinished:(ASIHTTPRequest *)request
{
	_bytesDownload += [[request rawResponseData] length];
	
	if ( NO == [request isKindOfClass:[SNRequest class]] )
		return;
    
	SNRequest * networkRequest = (SNRequest *)request;
    
#ifdef DEBUG
    [self logRequestInfo:networkRequest];
#endif
    
	if ( [request.requestMethod isEqualToString:@"GET"] )
	{
		if ( request.responseStatusCode >= 400 && request.responseStatusCode < 500 )
		{
			[self blockURL:[request.url absoluteString]];
		}
	}
    
	if ( 200 == request.responseStatusCode )
	{
		[networkRequest changeState:SNRequestState_Success];
	}
	else
	{
		[networkRequest changeState:SNRequestState_Failed];
	}
	[networkRequest clearDelegatesAndCancel];
	[networkRequest removeAllResponders];
    
	[_requests removeObject:networkRequest];
    
	if ( self.whenUpdate )
	{
		self.whenUpdate( networkRequest );
	}
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
	if ( NO == [request isKindOfClass:[SNRequest class]] )
		return;
    
	
    SNRequest * networkRequest = (SNRequest *)request;
    
#ifdef DEBUG
    [self logRequestInfo:networkRequest];
#endif
    
    networkRequest.errorCode = -1;
	[networkRequest changeState:SNRequestState_Failed];
    
	[networkRequest clearDelegatesAndCancel];
	[networkRequest removeAllResponders];
	
	[_requests removeObject:networkRequest];
	
	if ( self.whenUpdate )
	{
		self.whenUpdate( networkRequest );
	}
}


- (void)logRequestInfo:(SNRequest *)networkRequest{
    
    NSArray *cookies = [networkRequest requestCookies];
    NSString *cookieName = nil;
    NSString *cookieValue = nil;
    for (NSHTTPCookie *cookie in cookies)
    {
        cookieName = [cookie name];
        if ([cookieName isEqualToString:@"WC_SERVER"]) {
            cookieValue = [cookie value];
            break;
        }
    }
    NSMutableString *urlString =nil;
    if (!IsNilOrNull(networkRequest.url)) {
        urlString =[[NSMutableString alloc] initWithString:[networkRequest.url absoluteString]];
    }else{
        urlString = [[NSMutableString alloc]initWithString:@"null"];
    }
    if(networkRequest.postDataDic != nil)
    {
        [urlString appendString:@"?"];
        NSArray *allKeys = [networkRequest.postDataDic allKeys];
        for(NSString *key in allKeys)
        {
            [urlString appendFormat:@"%@=%@&", key, [networkRequest.postDataDic objectForKey:key]];
        }
    }
    NSString *absoluteString = [urlString substringWithRange:NSMakeRange(0, urlString.length-1)];
    TT_RELEASE_SAFELY(urlString);
    
    NSString *jsonStat = networkRequest.jasonItems?@"Ok":@"fail";
    
    NSString *responseStr = nil;
    
    if (networkRequest.errorCode == -1) {
        
        NSError *error = networkRequest.error;
        NSString *errorDic = [error description];
        responseStr = errorDic;
    }else{
        responseStr = [networkRequest.responseString formatJSON];
    }
    
    NSString *log = [NSString stringWithFormat:@"\n=============================================================================================begin\n----sendMsg id =  %#x\n----requestUrl = %@ \n----UrlParaDic =  %@\n----absoluteUrl = %@ \n----WC_SERVER : cell%@\n----ResponseStatus: (status %d) (JSON %@)\n----ResponseString: \n%@\n=============================================================================================end\n",networkRequest.cmdCode, [networkRequest.url absoluteString], networkRequest.postDataDic, absoluteString, cookieValue, networkRequest.responseStatusCode, jsonStat,responseStr];
        DLog( @"%@",log);
    
}

#pragma mark -


- (void)authenticationNeededForRequest:(ASIHTTPRequest *)request
{
	[self requestFailed:request];
}

- (void)proxyAuthenticationNeededForRequest:(ASIHTTPRequest *)request
{
	[self requestFailed:request];
}

#pragma mark -

// Called when the request receives some data - bytes is the length of that data
- (void)request:(ASIHTTPRequest *)request didReceiveBytes:(long long)bytes
{
	if ( NO == [request isKindOfClass:[SNRequest class]] )
		return;
	
	SNRequest * networkRequest = (SNRequest *)request;
	[networkRequest updateRecvProgress];
}

// Called when the request sends some data
// The first 32KB (128KB on older platforms) of data sent is not included in this amount because of limitations with the CFNetwork API
// bytes may be less than zero if a request needs to remove upload progress (probably because the request needs to run again)
- (void)request:(ASIHTTPRequest *)request didSendBytes:(long long)bytes
{
	if ( NO == [request isKindOfClass:[SNRequest class]] )
		return;
	
	SNRequest * networkRequest = (SNRequest *)request;
	[networkRequest updateSendProgress];
}

// Called when a request needs to change the length of the content to download
- (void)request:(ASIHTTPRequest *)request incrementDownloadSizeBy:(long long)newLength
{
	if ( NO == [request isKindOfClass:[SNRequest class]] )
		return;
	
	SNRequest * networkRequest = (SNRequest *)request;
	[networkRequest updateRecvProgress];
}

// Called when a request needs to change the length of the content to upload
// newLength may be less than zero when a request needs to remove the size of the internal buffer from progress tracking
- (void)request:(ASIHTTPRequest *)request incrementUploadSizeBy:(long long)newLength
{
	if ( NO == [request isKindOfClass:[SNRequest class]] )
		return;
	
	SNRequest * networkRequest = (SNRequest *)request;
	[networkRequest updateSendProgress];
}



@end
