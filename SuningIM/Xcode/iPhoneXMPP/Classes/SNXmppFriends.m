//
//  SNXmppFriends.m
//  SuningIM
//
//  Created by shasha on 13-6-5.
//
//

#import "SNXmppFriends.h"
#import "XMPPElement+Additon.h"

@interface SNXmppFriends(){
    SNCallBackBlockWithResult callback;
}

- (XMPPElement *)AccurateSearch:(SearchCondtion *)condition;

- (XMPPElement *)ConditionSearch:(SearchCondtion *)condition;

@end

@implementation SNXmppFriends

- (void)sendAccurateSearch:(SearchCondtion *)condition callback:(SNCallBackBlockWithResult)block
{
    callback = block;
    [self activate:[XmppManager shareInstance].xmppStream];
    
    XMPPElement *accurateSeatchElem =  [self AccurateSearch:condition];
    [xmppStream sendElement:accurateSeatchElem];
}


- (void)addFriends:(NSString *)JID callback:(SNCallBackBlockWithResult)block
{
    callback = block;
    [self activate:[XmppManager shareInstance].xmppStream];
    
    XMPPJID *jid = [XMPPJID jidWithString:JID];
    XMPPElement *presenceElem = [XMPPPresence presenceWithType:XMPP_Type_Subscribe to:jid];
    [xmppStream sendElement:presenceElem];
}


- (BOOL)xmppStream:(XMPPStream *)sender didReceiveIQ:(XMPPIQ *)iq
{
    //NSXMLElement *elem = [iq childElement];
    NSString *xmppId = [iq elementID];
    if (!IsStrEmpty(xmppId) &&[xmppId isEqualToString:Xmpp_Id_AccurateSeatch])
    {
        //解析 vcard
        BOOL isErrorIQ = [iq isErrorIQ];
        if (!isErrorIQ) {
            NSXMLElement *queryElem = [iq childElement];
            NSXMLElement *xElem = [[queryElem children] objectAtIndex:0];
            NSArray *itemArr = [xElem children];
            NSMutableArray *tempArr = [[NSMutableArray alloc] init];
            for (NSXMLElement *elem in itemArr) {
                NSXMLElement *vCardElem = [[elem children] objectAtIndex:0];
                SNXMPPvCard *vcard = [SNXMPPvCard vCardTempFromElement:vCardElem];
                if (!IsNilOrNull(vcard)) {
                    [tempArr addObject:vcard];
                }
            }
            if (callback) {
                callback(YES,nil,tempArr);
            }
        }else{
            if (callback) {
                callback(NO,nil,nil);
            }
        }
        
    }
    [self deactivate];
    return YES;
}

/*
 <iq id="agsXMPP_9" type="set" to="globalsearch.sitopenfireserver01.cnsuning.com">
 <query xmlns="jabber:iq:globalSearch">
 <set xmlns="http://jabber.org/protocol/rsm">
 <index>1</index>
 <max>10</max>
 <resource>ios_mobiel</resource>
 </set>
 <x xmlns="jabber:x:data" type="submit">
 <field type="hidden" var="FORM_TYPE">
 <value>jabber:iq:globalSearch</value>
 </field>
 <field type="boolean" var="Username">
 <value>1</value>
 </field>
 <field type="boolean" var="Name">
 <value>1</value>
 </field>
 <field type="text-single" var="search">
 <!--此处精确匹配用户昵称或账号-->
 <value>XXXX</value>
 </field>
 </x>
 </query>
 </iq>
 */
//精确查找
- (XMPPElement *)AccurateSearch:(SearchCondtion *)condition{
    XMPPJID *jid = [XMPPJID jidWithString:[NSString stringWithFormat:@"%@.%@",XMPP_JID_Area,self.user.openfiredomain]] ;
    
    XMPPIQ *iq = [XMPPIQ iqWithType:XMPP_Type_Set to:jid elementID:Xmpp_Id_AccurateSeatch];
    
    XMPPElement *queryChild = [XMPPElement queryElementWithXmlns:Xmpp_AttriValue_Search];
    [iq addChild:queryChild];
    
    XMPPElement *setChild = [XMPPElement setElementWithIndex:condition.index  Max:condition.max];
    [queryChild addChild:setChild];
    
    XMPPElement *xChild = [XMPPElement xElementWithType:XMPP_Type_Submit Xmlns:Xmpp_AttriValue_Data];
    
    XMPPElement *fromChild = [XMPPElement filedElementWithType:XMPP_Type_Hidden Var:@"FORM_TYPE" Value:Xmpp_AttriValue_Search];
    [xChild addChild:fromChild];
    
    XMPPElement *userNameChild = [XMPPElement filedElementWithType:XMPP_Type_Bool Var:@"Username" Value:@"1"];
    [xChild addChild:userNameChild];
    
    XMPPElement *nameChild = [XMPPElement filedElementWithType:XMPP_Type_Bool Var:@"Name" Value:@"1"];
    [xChild addChild:nameChild];
    
    XMPPElement *keyWordChild = [XMPPElement filedElementWithType:XMPP_Type_Text Var:@"search" Value:condition.searchKeyWord];
    [xChild addChild:keyWordChild];
    
    [queryChild addChild:xChild];
    
    return iq;
}

- (SNXmppFriends *)ConditionSearch:(SearchCondtion *)condition callback:(SNCallBackBlockWithResult)block
{
    
}

@end
