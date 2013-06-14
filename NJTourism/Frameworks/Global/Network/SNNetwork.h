//
//  SNNetwork.h
//  FatFist
//
//  Copyright 2011 FatFish. All rights reserved.
//
//
#import <Foundation/Foundation.h>
#import "ASIFormDataRequest.h"
@class SNRequest;

#pragma mark -
#undef	DEFAULT_BLACKLIST_TIMEOUT
#define DEFAULT_BLACKLIST_TIMEOUT	(60.0f * 5.0f)	// 黑名单超时
#undef	DEFAULT_GET_TIMEOUT
#define DEFAULT_GET_TIMEOUT			HTTP_TIMEOUT    // 取图30秒超时
#undef	DEFAULT_POST_TIMEOUT
#define DEFAULT_POST_TIMEOUT		HTTP_TIMEOUT	// 发协议30秒超时
#undef	DEFAULT_UPLOAD_TIMEOUT
#define DEFAULT_UPLOAD_TIMEOUT		(120.0f)		// 上传图片120秒超时

/*********************************************************************/
typedef void (^SNRequestBlock)( SNRequest * req );
typedef enum {
    SNRequestState_Created = 1,
    SNRequestState_Sending,
    SNRequestState_Recving,
    SNRequestState_Failed,
    SNRequestState_Success,
    SNRequestState_Cancel
}SNRequestState;
/*********************************************************************/
#pragma mark -
@interface NSObject(SNRequestResponder)
- (BOOL)isRequestResponder;
- (SNRequest *)GET:(NSString *)url;
- (SNRequest *)GET:(NSString *)url params:(NSDictionary *)kvs;
- (SNRequest *)GET:(NSString *)url ToPath:(NSString *)path;
- (SNRequest *)POST:(NSString *)url data:(NSData *)data;
- (SNRequest *)POST:(NSString *)url text:(NSString *)text;
- (SNRequest *)POST:(NSString *)url dict:(NSDictionary *)kvs;
- (SNRequest *)POST:(NSString *)url params:(id)first, ...;
- (SNRequest *)POST:(NSString *)url files:(NSDictionary *)files;
- (SNRequest *)POST:(NSString *)url files:(NSDictionary *)files dict:(NSDictionary *)kvs;
- (SNRequest *)POST:(NSString *)url files:(NSDictionary *)files params:(id)first, ...;
- (BOOL)requestingURL;
- (BOOL)requestingURL:(NSString *)url;
- (BOOL)requestingCmd:(E_CMDCODE)cmdCode;
- (NSArray *)requests;
- (NSArray *)requests:(NSString *)url;
- (NSArray *)requestsOfCmd:(E_CMDCODE)cmdCode;
- (void)cancelRequests;
- (void)cancelRequestByCmdCode:(E_CMDCODE)cmdCode;
- (void)cancelRequestByUrl:(NSString *)url;
- (void)handleRequest:(SNRequest *)request;
@end
@interface SNRequest : ASIFormDataRequest
{
	SNRequestState		_state;
	NSMutableArray *		_responders;
    
	NSInteger				_errorCode;
	NSMutableDictionary *	_userInfo;
    
	BOOL					_sendProgressed;
	BOOL					_recvProgressed;
	SNRequestBlock			_whenUpdate;
	
	NSTimeInterval			_initTimeStamp;
	NSTimeInterval			_sendTimeStamp;
	NSTimeInterval			_recvTimeStamp;
	NSTimeInterval			_doneTimeStamp;
    
    id                      _jsonItems;
    E_CMDCODE               _cmdCode;
    NSDictionary            *_postDataDic;
}
@property (nonatomic, assign) SNRequestState            state;
@property (nonatomic, retain) NSMutableArray *			responders;
@property (nonatomic, assign) NSInteger					errorCode;
@property (nonatomic, retain) NSMutableDictionary *		userInfo;
@property (nonatomic, copy)   SNRequestBlock		    whenUpdate;
@property (nonatomic, assign) NSTimeInterval			initTimeStamp;
@property (nonatomic, assign) NSTimeInterval			sendTimeStamp;
@property (nonatomic, assign) NSTimeInterval			recvTimeStamp;
@property (nonatomic, assign) NSTimeInterval			doneTimeStamp;
@property (nonatomic, readonly) NSTimeInterval			timeCostPending;	// 排队等待耗时
@property (nonatomic, readonly) NSTimeInterval			timeCostOverDNS;	// 网络连接耗时（DNS）
@property (nonatomic, readonly) NSTimeInterval			timeCostRecving;	// 网络收包耗时
@property (nonatomic, readonly) NSTimeInterval			timeCostOverAir;	// 网络整体耗时
@property (nonatomic, readonly) BOOL					created;
@property (nonatomic, readonly) BOOL					sending;
@property (nonatomic, readonly) BOOL					recving;
@property (nonatomic, readonly) BOOL					failed;
@property (nonatomic, readonly) BOOL					succeed;
@property (nonatomic, readonly) BOOL					cancelled;
@property (nonatomic, readonly) BOOL					sendProgressed;
@property (nonatomic, readonly) BOOL					recvProgressed;
@property (nonatomic, readonly) CGFloat					uploadPercent;
@property (nonatomic, readonly) NSUInteger				uploadBytes;
@property (nonatomic, readonly) NSUInteger				uploadTotalBytes;
@property (nonatomic, readonly) CGFloat					downloadPercent;
@property (nonatomic, readonly) NSUInteger				downloadBytes;
@property (nonatomic, readonly) NSUInteger				downloadTotalBytes;
//response item
@property (nonatomic, readonly, retain) id              jsonItems;
@property (nonatomic, assign)   E_CMDCODE               cmdCode;
@property (nonatomic, retain) NSDictionary              *postDataDic;

- (BOOL)is:(NSString *)url;
- (void)changeState:(NSUInteger)state;
- (BOOL)hasResponder:(id)responder;
- (void)addResponder:(id)responder;
- (void)removeResponder:(id)responder;
- (void)removeAllResponders;
- (void)callResponders;
- (void)forwardResponder:(NSObject *)obj;
- (void)updateRecvProgress;
- (void)updateSendProgress;
@end

/*********************************************************************/

@interface SNRequestQueue : NSObject<ASIHTTPRequestDelegate>
{
	BOOL					_merge;
	BOOL					_online;
    
	BOOL					_blackListEnable;
	NSTimeInterval			_blackListTimeout;
	NSMutableDictionary *	_blackList;
    
	NSUInteger				_bytesUpload;
	NSUInteger				_bytesDownload;
	
	NSTimeInterval			_delay;
	NSMutableArray *		_requests;
    
	SNRequestBlock			_whenCreate;
	SNRequestBlock			_whenUpdate;
}
@property (nonatomic, assign) BOOL						merge;
@property (nonatomic, assign) BOOL						online;				// 开网/断网
@property (nonatomic, assign) BOOL						blackListEnable;	// 是否使用黑名单
@property (nonatomic, assign) NSTimeInterval			blackListTimeout;	// 黑名单超时
@property (nonatomic, retain) NSMutableDictionary *		blackList;
@property (nonatomic, assign) NSUInteger				bytesUpload;
@property (nonatomic, assign) NSUInteger				bytesDownload;
@property (nonatomic, assign) NSTimeInterval			delay;
@property (nonatomic, retain) NSMutableArray *			requests;
@property (nonatomic, copy) SNRequestBlock				whenCreate;
@property (nonatomic, copy) SNRequestBlock				whenUpdate;
+ (SNRequestQueue *)sharedInstance;
+ (BOOL)isReachableViaWIFI;
+ (BOOL)isReachableViaWLAN;
+ (BOOL)isNetworkInUse;
+ (NSUInteger)bandwidthUsedPerSecond;
+ (SNRequest *)GET:(NSString *)url;
+ (SNRequest *)GET:(NSString *)url params:(NSDictionary *)kvs;
+ (SNRequest *)GET:(NSString *)url ToPath:(NSString *)path;
+ (SNRequest *)POST:(NSString *)url data:(NSData *)data;
+ (SNRequest *)POST:(NSString *)url params:(NSDictionary *)kvs;
+ (SNRequest *)POST:(NSString *)url files:(NSDictionary *)files;
/*!
 @method
 @abstract   使用content－type ＝ “multipart/form-data”;form表单上传数据的形式上传至服务器。
 @discussion 调用此方法的时候会在发送请求之前先把data数据存储至本地文件夹中。
 @param url      post的url
 @param files    dic类型，  
                 key：为本地副本文件存储路径（作为本地文件的文件名；
                 value：为文件的NSString类型或者NSData类型的对象。
 
    例如：
        
 @result 
 
 */
+ (SNRequest *)POST:(NSString *)url files:(NSDictionary *)files params:(NSDictionary *)kvs;
+ (BOOL)requesting:(NSString *)url;
+ (BOOL)requesting:(NSString *)url byResponder:(id)responder;
+ (BOOL)requestingCmd:(E_CMDCODE)cmd byResponder:(id)responder;
+ (NSArray *)requests:(NSString *)url;
+ (NSArray *)requests:(NSString *)url byResponder:(id)responder;
+ (NSArray *)requestsCmd:(E_CMDCODE)cmd byResponder:(id)responder;
+ (void)cancelRequest:(SNRequest *)request;
+ (void)cancelRequestByResponder:(id)responder;
+ (void)cancelAllRequests;
+ (void)blockURL:(NSString *)url;
+ (void)unblockURL:(NSString *)url;
@end
