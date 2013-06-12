//
//  SNXmppUserSetting.m
//  SuningIM
//
//  Created by shasha on 13-6-5.
//
//

#import "SNXmppUserSetting.h"

@implementation SNXmppUserSetting


- (void)deleteUserLabel:(NSString *)userLabel{
    
    XMPPElement *iqElem = [XMPPIQ iqWithType:XMPP_Type_Set elementID:Xmpp_Id_DeleteUserLabel];
    [iqElem addAttributeWithName:Xmpp_AttriName_From stringValue:self.user.jid];
    
    XMPPElement *queryElem = [XMPPElement queryElementWithXmlns:Xmpp_AttriValue_AddUserLabel];

    XMPPElement *operationElem = [XMPPElement operationElementWithValue:@"delete"];
    [queryElem addChild:operationElem];
    
    XMPPElement *labelElem = [XMPPElement labelElementWithValue:userLabel];
    [queryElem addChild:labelElem];

    [iqElem addChild:queryElem];

    [xmppStream sendElement:iqElem];
    
}


- (void)getUserLabel:(BOOL)isConfirm{
    
    XMPPElement *iqElem = [XMPPIQ iqWithType:XMPP_Type_Get elementID:Xmpp_Id_getUserLabel];
    [iqElem addAttributeWithName:Xmpp_AttriName_From stringValue:self.user.jid];
    
    XMPPElement *queryElem = [XMPPElement queryElementWithXmlns:Xmpp_AttriValue_AddUserLabel];

    XMPPElement *jidElem = [XMPPElement jidElementWithValue:self.user.jid];
    [queryElem addChild:jidElem];
    
    NSString *confirm = nil;
    if (isConfirm) {
        confirm = @"1";
    }else{
        confirm = @"0";
    }
    
    XMPPElement *confirmElem = [XMPPElement confirmElementWithValue:confirm];
    [queryElem addChild:confirmElem];
    
    [iqElem addChild:queryElem];
    
    [xmppStream sendElement:iqElem];
}

//为好友添加标签
- (void)addLableForFriends:(NSString *)userLabel to:(NSString *)jid{
    
    XMPPJID *JID = [XMPPJID jidWithString:jid];
    XMPPElement *messageElem = [XMPPMessage messageWithType:XMPP_Type_Chat to:JID];
    
    XMPPElement *labelElem = [XMPPElement labelElementWithValue:userLabel];
    NSString *labelStr = [labelElem compactXMLString];
    NSString *cData = [XMPPElement CDATAWithValue:labelStr];
    
    XMPPElement *bodyElem = [XMPPElement bodyElementWithValue:cData];
    [messageElem addChild:bodyElem];
    
    XMPPElement *delayElem = [XMPPElement delayElement];
    [messageElem addChild:delayElem];
    
    [xmppStream sendElement:messageElem];
}


//确认添加用户标签
- (void)confirmAddUserLabel:(NSString *)userLabel labelId:(NSString *)labelId{
    XMPPElement *iqElem = [XMPPIQ iqWithType:XMPP_Type_Set elementID:Xmpp_Id_AddUserLabel];
    [iqElem addAttributeWithName:Xmpp_AttriName_From stringValue:self.user.jid];
    
    XMPPElement *queryElem = [XMPPElement queryElementWithXmlns:Xmpp_AttriValue_AddUserLabel];
    
    XMPPElement *operationElem = [XMPPElement operationElementWithValue:@"add"];
    [queryElem addChild:operationElem];
    
    XMPPElement *fromElem = [XMPPElement fromElementWithValue:Xmpp_Name_From];
    [queryElem addChild:fromElem];
    
    XMPPElement *labelElem = [XMPPElement labelElementWithValue:userLabel];
    [queryElem addChild:labelElem];
    
    if (!IsStrEmpty(labelId)) {
        XMPPElement *labelIdElem = [XMPPElement labelIdElementWithValue:labelId];
        [queryElem addChild:labelIdElem];
    }
    
    XMPPElement *confirmElem = [XMPPElement confirmElementWithValue:@"1"];
    [queryElem addChild:confirmElem];
    
    [iqElem addChild:queryElem];
    
    [xmppStream sendElement:iqElem];
}

- (void)saveConfig:(EUserAddConfigType)type
{
    XMPPElement *iqElem = [XMPPIQ iqWithType:XMPP_Type_Set elementID:Xmpp_Id_saveUserConfig];
    [iqElem addAttributeWithName:Xmpp_AttriName_From stringValue:self.user.jid];
    
    XMPPElement *queryElem = [XMPPElement queryElementWithXmlns:Xmpp_AttriValue_Config];
    
    NSString *cdataConfig = [XMPPElement CDATAWithConfigType:type];
    
    XMPPElement *itemElem = [XMPPElement itemElement:cdataConfig];
    [queryElem addChild:itemElem];
    
    [iqElem addChild:queryElem];
}

//获取用户设置
- (void)getConfig:(EUserAddConfigType)type{
    XMPPElement *iqElem = [XMPPIQ iqWithType:XMPP_Type_Get elementID:Xmpp_Id_getUserConfig];
    [iqElem addAttributeWithName:Xmpp_AttriName_From stringValue:self.user.jid];
    [iqElem addAttributeWithName:Xmpp_AttriName_To stringValue:self.user.openfireip];
    
    XMPPElement *queryElem = [XMPPElement queryElementWithXmlns:Xmpp_AttriValue_Config];
        
    XMPPElement *itemElem = [XMPPElement itemElement:nil];
    [queryElem addChild:itemElem];
    
    [iqElem addChild:queryElem];
}


@end
