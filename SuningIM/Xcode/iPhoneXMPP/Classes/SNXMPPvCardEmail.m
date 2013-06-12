//
//  SNXMPPvCardEmail.m
//  SuningIM
//
//  Created by shasha on 13-5-30.
//
//

#import "SNXMPPvCardEmail.h"

@implementation SNXMPPvCardEmail

+ (SNXMPPvCardEmail *)vCardEmailFromElement:(NSXMLElement *)elem {
	object_setClass(elem, [SNXMPPvCardEmail class]);
	
	return (SNXMPPvCardEmail *)elem;
}

- (NSString *)home {
	return [[self elementForName:@"HOME"] stringValue];
}


- (void)setHome:(NSString *)home {
	XMPP_VCARD_SET_STRING_CHILD(home, @"HOME");
}

- (NSString *)userID {
	return [[self elementForName:@"USERID"] stringValue];
}


- (void)setUserID:(NSString *)userID {
	XMPP_VCARD_SET_STRING_CHILD(userID, @"USERID");
}

- (NSString *)pref {
	return [[self elementForName:@"PREF"] stringValue];
}

- (void)setPref:(NSString *)pref{
	XMPP_VCARD_SET_STRING_CHILD(pref, @"PREF");
}

- (NSString *)internet {
	return [[self elementForName:@"INTERNET"] stringValue];
}

- (void)setInternet:(NSString *)internet{
	XMPP_VCARD_SET_STRING_CHILD(internet, @"INTERNET");
}
@end
