//
//  SNXMPPvCard.h
//  SuningIM
//
//  Created by shasha on 13-5-30.
//
//

#import "XMPPvCardTemp.h"
#import "SNXMPPvCardEmail.h"
#import "XMPPLogging.h"

@interface SNXMPPvCard : XMPPvCardTemp

+ (SNXMPPvCard *)vCardTempFromElement:(NSXMLElement *)element;
+ (SNXMPPvCard *)vCardTempSubElementFromIQ:(XMPPIQ *)iq;
+ (SNXMPPvCard *)vCardTempCopyFromIQ:(XMPPIQ *)iq;

//签名
@property (nonatomic, strong) NSString  *sign;
//地址描述
@property (nonatomic, strong) NSString  *addressDesc;

@property (nonatomic, strong) NSString  *JABBERID;
//性别
@property (nonatomic, strong) NSString  *sex;
//用户名
@property (nonatomic, strong) NSString  *userName;

@property (nonatomic, strong) NSString  *birthDay;

@property (nonatomic, strong) NSString  *photoUrl;

@property (nonatomic, assign) BOOL  isSystemPhoto;

@end
