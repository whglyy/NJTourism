//
//  SNXmppOffline.m
//  SuningIM
//
//  Created by shasha on 13-6-5.
//
//

#import "SNXmppOffline.h"

@implementation SNXmppOffline

- (void)registerOffline{
    XMPPElement *iqElem = [XMPPIQ iqWithType:XMPP_Type_Get elementID:Xmpp_Id_RegisterOffline];
    [iqElem addAttributeWithName:Xmpp_AttriName_From stringValue:self.user.jid];
    
    XMPPElement *queryElem = [XMPPElement queryElementWithXmlns:Xmpp_AttriValue_Offline];
    [iqElem addChild:queryElem];
    
    [xmppStream sendElement:iqElem];
}


- (void)logoutOffline{
    XMPPElement *iqElem = [XMPPIQ iqWithType:XMPP_Type_Set elementID:Xmpp_Id_RegisterOffline];
    [iqElem addAttributeWithName:Xmpp_AttriName_From stringValue:self.user.jid];
    
    XMPPElement *queryElem = [XMPPElement queryElementWithXmlns:Xmpp_AttriValue_Offline];
    [iqElem addChild:queryElem];
    
    [xmppStream sendElement:iqElem];
}

@end
