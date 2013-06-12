//
//  VerifyService.h
//  SuningIM
//
//  Created by wangbao on 13-6-3.
//
//

#import <Foundation/Foundation.h>
#import "DataService.h"
#import "UserInfoDTO.h"

@protocol VerifyServiceDelegate ;

@interface VerifyService : DataService
@property (nonatomic, retain) NSString *jid;
@property (nonatomic, retain) NSString *password;

@property (nonatomic, strong) NSArray  *recordArray;

@property (nonatomic, assign) id<VerifyServiceDelegate>  delegate;

- (void)beginVerifyRequestWithVerifyCode:(NSString *)verifyCode JID:(NSString *)jid Password:(NSString *)password;
- (void)stopVerifyRequestWithJID:(NSString *)jid;
- (void)readRequestWithPhoneNos:(NSArray *)phoneNos;
- (void)getVerifyRequestWithPhoneNo:(NSString *)phoneNo JID:(NSString *)jid;

@end

@protocol VerifyServiceDelegate <NSObject>
@optional
- (void)VerifyCompletedWithResult:(BOOL)isSuccess Service:(VerifyService *)service;
- (void)StopVerifyCompletedWithResult:(BOOL)isSuccess Service:(VerifyService *)service;
- (void)ReadPhoneCompletedWithResult:(BOOL)isSuccess Service:(VerifyService *)service;
- (void)getVerifyCompletedWithResult:(BOOL)isSuccess Service:(VerifyService *)service;


@end
