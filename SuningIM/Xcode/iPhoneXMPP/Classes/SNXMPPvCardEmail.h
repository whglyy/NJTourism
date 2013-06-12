//
//  SNXMPPvCardEmail.h
//  SuningIM
//
//  Created by shasha on 13-5-30.
//
//

#import "XMPPvCardTempEmail.h"

@interface SNXMPPvCardEmail : XMPPvCardTempEmail

+ (SNXMPPvCardEmail *)vCardEmailFromElement:(NSXMLElement *)elem;

@property (nonatomic, strong) NSString  *home;
@property (nonatomic, strong) NSString  *internet;
@property (nonatomic, strong) NSString  *pref;
@property (nonatomic, strong) NSString  *userID;

@end
