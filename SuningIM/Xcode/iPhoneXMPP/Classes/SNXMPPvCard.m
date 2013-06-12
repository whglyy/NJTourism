//
//  SNXMPPvCard.m
//  SuningIM
//
//  Created by shasha on 13-5-30.
//
//

#import "SNXMPPvCard.h"

@implementation SNXMPPvCard

+ (void)initialize {
	// We use the object_setClass method below to dynamically change the class from a standard NSXMLElement.
	// The size of the two classes is expected to be the same.
	//
	// If a developer adds instance methods to this class, bad things happen at runtime that are very hard to debug.
	// This check is here to aid future developers who may make this mistake.
	//
	// For Fearless And Experienced Objective-C Developers:
	// It may be possible to support adding instance variables to this class if you seriously need it.
	// To do so, try realloc'ing self after altering the class, and then initialize your variables.
	
	size_t superSize = class_getInstanceSize([NSXMLElement class]);
	size_t ourSize   = class_getInstanceSize([SNXMPPvCard class]);
	
	if (superSize != ourSize)
	{
		//XMPPLogError(@"Adding instance variables to XMPPvCardTemp is not currently supported!");
		
		[DDLog flushLog];
		exit(15);
	}
}

+ (SNXMPPvCard *)vCardTempFromElement:(NSXMLElement *)elem {
	object_setClass(elem, [SNXMPPvCard class]);
	
	return (SNXMPPvCard *)elem;
}


+ (SNXMPPvCard *)vCardTempSubElementFromIQ:(XMPPIQ *)iq
{
	if ([iq isResultIQ])
	{
		NSXMLElement *query = [iq elementForName:kXMPPvCardTempElement xmlns:kXMPPNSvCardTemp];
		if (query)
		{
			return [SNXMPPvCard vCardTempFromElement:query];
		}
	}
	
	return nil;
}

+ (SNXMPPvCard *)vCardTempCopyFromIQ:(XMPPIQ *)iq
{
	return [[self vCardTempSubElementFromIQ:iq] copy];
}

- (NSString *)sign {
	return [[self elementForName:@"SIGN"] stringValue];
}


- (void)setSign:(NSString *)sign{
	XMPP_VCARD_SET_STRING_CHILD(sign, @"SIGN");
}

- (NSString *)sex {
	return [[self elementForName:@"SEX"] stringValue];
}


- (void)setSex:(NSString *)sex{
	XMPP_VCARD_SET_STRING_CHILD(sex, @"SEX");
}

- (NSString *)birthDay {
	return [[self elementForName:@"BDAY"] stringValue];
}


- (void)setBirthDay:(NSString *)birthDay{
	XMPP_VCARD_SET_STRING_CHILD(birthDay, @"BDAY");
}

- (NSString *)photoUrl {
    NSXMLElement *element = [self elementForName:@"PHOTO"];
    	return [[element elementForName:@"PHOTOURL"] stringValue];
}


- (void)setPhotoUrl:(NSString *)photoUrl{
    
    NSXMLElement *elem = [self elementForName:@"PHOTO"];
    
	if (elem == nil) {
		elem = [NSXMLElement elementWithName:@"PHOTO"];
		[self addChild:elem];
	}
    
    NSXMLElement *urlElem = [elem elementForName:@"PHOTOURL"];
    
    if (urlElem == nil) {
        urlElem = [NSXMLElement elementWithName:@"PHOTOURL"];
        [elem addChild:urlElem];
    }
    
    [urlElem setStringValue:photoUrl];
}


- (BOOL)isSystemPhoto{
    NSXMLElement *element = [self elementForName:@"PHOTO"];
    return [[element elementForName:@"ISSYSPHOTO"] stringValueAsBool];
}
- (void)setIsSystemPhoto:(BOOL)isSystemPhoto{
    NSXMLElement *elem = [self elementForName:@"PHOTO"];
    
	if (elem == nil) {
		elem = [NSXMLElement elementWithName:@"PHOTO"];
		[self addChild:elem];
	}
    
    NSXMLElement *urlElem = [elem elementForName:@"ISSYSPHOTO"];
    
    if (urlElem == nil) {
        urlElem = [NSXMLElement elementWithName:@"ISSYSPHOTO"];
        [elem addChild:urlElem];
    }
    
    if (isSystemPhoto) {
        [urlElem setStringValue:@"false"];
    }else{
        [urlElem setStringValue:@"true"];

    }
    
}


- (NSString *)userName {
	return [[self elementForName:@"USERNAME"] stringValue];
}


- (void)setUserName:(NSString *)userName{
	XMPP_VCARD_SET_STRING_CHILD(userName, @"USERNAME");
}

- (NSString *)addressDesc {
	return [[self elementForName:@"ADDRESS"] stringValue];
}


- (void)setAddressDesc:(NSString *)addressDesc {
	XMPP_VCARD_SET_STRING_CHILD(addressDesc, @"ADDRESS");
}

- (NSString *)JABBERID {
	return [[self elementForName:@"JABBERID"] stringValue];
}


- (void)setJABBERID:(NSString *)JABBERID {
	XMPP_VCARD_SET_STRING_CHILD(JABBERID, @"JABBERID");
}

- (NSArray *)emailAddresses {
    NSMutableArray *tempArr = [[NSMutableArray alloc] init];
	NSArray *emailArr = [self elementsForName:@"EMAIL"];
    for (NSXMLElement *element in emailArr) {
        SNXMPPvCardEmail *emailElement = [SNXMPPvCardEmail vCardEmailFromElement:element];
        [tempArr addObject:emailElement];
    }
	return tempArr;
    
}
- (void)addEmailAddress:(XMPPvCardTempEmail *)email {
    object_setClass(email, [SNXMPPvCardEmail class]);
    NSMutableArray *tempArr = [[NSMutableArray alloc] initWithArray:self.emailAddresses];
    [tempArr addObject:email];
    self.emailAddresses = tempArr;
}

- (void)removeEmailAddress:(XMPPvCardTempEmail *)email {
    object_setClass(email, [SNXMPPvCardEmail class]);
    NSMutableArray *tempArr = [[NSMutableArray alloc] initWithArray:self.emailAddresses];
    if ([tempArr containsObject:email]) {
        [tempArr removeObject:email];
        self.emailAddresses = tempArr;
    }
}
- (void)setEmailAddresses:(NSArray *)emails {
    self.emailAddresses = emails;
}
- (void)clearEmailAddresses {
    self.emailAddresses = nil;
}


- (NSArray *)telecomsAddresses {
    NSMutableArray *tempArr = [[NSMutableArray alloc] init];
	NSArray *telArr = [self elementsForName:@"TEL"];
    for (NSXMLElement *element in telArr) {
        XMPPvCardTempTel *telElement = [XMPPvCardTempTel vCardTelFromElement:element];
        [tempArr addObject:telElement];
    }
	return tempArr;
}

- (void)addTelecomsAddress:(XMPPvCardTempTel *)tel {
    if (!IsNilOrNull(tel)) {
        NSMutableArray *tempArr = [[NSMutableArray alloc] initWithArray:self.telecomsAddresses];
        [tempArr addObject:tel];
        self.telecomsAddresses = tempArr;
    }
 }

- (void)removeTelecomsAddress:(XMPPvCardTempTel *)tel {
    if (!IsNilOrNull(tel)) {
        NSMutableArray *tempArr = [[NSMutableArray alloc] initWithArray:self.telecomsAddresses];
        if ([tempArr containsObject:tel]) {
            [tempArr removeObject:tel];
        }
        self.telecomsAddresses = tempArr;
    }
}

- (void)setTelecomsAddresses:(NSArray *)tels {
    self.telecomsAddresses = tels;
}

- (void)clearTelecomsAddresses {
    self.telecomsAddresses = nil;
}


- (NSArray *)addresses {
    NSMutableArray *tempArr = [[NSMutableArray alloc] init];
	NSArray *adrArr = [self elementsForName:@"ADR"];
    for (NSXMLElement *element in adrArr) {
        XMPPvCardTempAdr *adrElement = [XMPPvCardTempAdr vCardAdrFromElement:element];
        [tempArr addObject:adrElement];
    }
	return tempArr;
}

- (void)addAddress:(XMPPvCardTempAdr *)adr {
    if (!IsNilOrNull(adr)) {
        NSMutableArray *tempArr = [[NSMutableArray alloc] initWithArray:self.addresses];
        [tempArr addObject:adr];
        self.addresses = tempArr;
    }
}

- (void)removeAddress:(XMPPvCardTempAdr *)adr {
    if (!IsNilOrNull(adr)) {
        NSMutableArray *tempArr = [[NSMutableArray alloc] initWithArray:self.addresses];
        if ([tempArr containsObject:adr]) {
            [tempArr removeObject:adr];
        }
        self.telecomsAddresses = tempArr;
    }
}

- (void)setAddresses:(NSArray *)adrs {
    self.addresses = adrs;
}

- (void)clearAddresses {
    self.addresses = nil;
}



@end
