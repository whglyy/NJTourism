//
//  DataService.h
//  FatFist
//
//  Copyright 2011 FatFish. All rights reserved.
//
//

#import <Foundation/Foundation.h>
#import "SNNetwork.h"

#undef POST_VALUE
#define POST_VALUE(_VEL)   (_VEL)?(_VEL):@""

//release method
#undef SERVICE_RELEASE
#define SERVICE_RELEASE(_SER)     {_SER.delegate = nil; [_SER release]; _SER = nil;}

//errorMsg
#define kNetworkCloseErrorMsg   @"您的网络好像有点问题，请稍后再试"
#define kServerBusyErrorMsg     @"服务器忙或正在维护，请稍后再试"

@interface DataService : NSObject

@property (nonatomic, copy)   NSString   *errorMsg;
@property (nonatomic, copy) NSString   *errorCode;

- (NSString *)errorMsgOfRequestError:(NSError *)error;

- (BOOL)isResponseSuccess:(NSDictionary *)items RequestCmd:(E_CMDCODE)cmdCode;
- (id)dataInfoOfResponse:(NSDictionary *)items ;
@end
