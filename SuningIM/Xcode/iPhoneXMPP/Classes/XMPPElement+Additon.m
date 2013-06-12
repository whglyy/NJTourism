//
//  XMPPElement+Additon.m
//  SuningIM
//
//  Created by shasha on 13-6-5.
//
//

#import "XMPPElement+Additon.h"

@implementation XMPPElement (Additon)
/*
 <field type="hidden" var="FORM_TYPE">
 <value>jabber:iq:globalSearch</value>
 </field>
 */
+ (XMPPElement *)filedElementWithType:(NSString *)type
                                  Var:(NSString *)var
                                Value:(NSString *)value
{
    XMPPElement *elem = [XMPPElement elementWithName:Xmpp_Name_Filed];
    if (!IsStrEmpty(type)) {
        [elem addAttributeWithName:Xmpp_AttriName_Type stringValue:type];
    }
    if (!IsStrEmpty(var)) {
        [elem addAttributeWithName:Xmpp_AttriName_Var stringValue:var];
    }
    if (!IsStrEmpty(value)) {
        XMPPElement *valueChild = [XMPPElement elementWithName:Xmpp_Name_Value stringValue:value];
        [elem addChild:valueChild];
    }
    
    return elem;
}

/*
 <set xmlns="http://jabber.org/protocol/rsm">
 <index>1</index>
 <max>10</max>
 </set>
 */
+ (XMPPElement *)setElementWithIndex:(NSString *)index
                                 Max:(NSString *)max
{
    XMPPElement *setElem = [XMPPElement elementWithName:Xmpp_Name_Set];
    [setElem addAttributeWithName:Xmpp_AttriName_Xmlns stringValue:Xmpp_AttriValue_Rsm];
    if (!IsStrEmpty(index)) {
        XMPPElement *indexElem =[XMPPElement elementWithName:Xmpp_Name_Index  stringValue:index];
        [setElem addChild:indexElem];
    }
    
    if (!IsStrEmpty(max)) {
        XMPPElement *maxElem = [XMPPElement elementWithName:Xmpp_Name_Max stringValue:max];
        [setElem addChild:maxElem];
    }
    
    XMPPElement *resourceElem = [XMPPElement elementWithName:Xmpp_Name_Resource  stringValue:XmppResource];
    [setElem addChild:resourceElem];
    return setElem;
}


/*
 <x xmlns="jabber:x:data" type="submit">
 </x>
 */
+ (XMPPElement *)xElementWithType:(NSString *)type
                            Xmlns:(NSString *)xmlns
{
    XMPPElement *element = [XMPPElement elementWithName:Xmpp_Name_X];
    if (!IsStrEmpty(xmlns)) {
        [element  addAttributeWithName:Xmpp_AttriName_Xmlns stringValue:xmlns];
    }
    if (!IsStrEmpty(type)) {
        [element  addAttributeWithName:Xmpp_AttriName_Type stringValue:type];
    }
    return element;
}

/*
 <query xmlns="jabber:x:data">
 </query>
 */
+ (XMPPElement *)queryElementWithXmlns:(NSString *)xmlns
{
    XMPPElement *query = [[XMPPElement alloc] initWithName:Xmpp_Name_Query];
    if (!IsStrEmpty(xmlns)) {
        [query addAttributeWithName:Xmpp_AttriName_Xmlns stringValue:xmlns];
    }
    return query;
}

/*
 <operation>add</operation>
 */
+ (XMPPElement *)operationElementWithValue:(NSString *)value

{
    XMPPElement *operation = [XMPPElement elementWithName:Xmpp_Name_Operation];
    if (IsStrEmpty(value)) {
        [operation setStringValue:value];
    }
    return operation;
}

/*
 <from>34001485295@sitopenfireserver01.cnsuning.com</from>
 */
+ (XMPPElement *)fromElementWithValue:(NSString *)value{
    XMPPElement *from = [XMPPElement elementWithName:Xmpp_Name_Operation];
    if (IsStrEmpty(value)) {
        [from setStringValue:value];
    }
    return from;
}

+ (XMPPElement *)confirmElementWithValue:(NSString *)value
{
    XMPPElement *confirm = [XMPPElement elementWithName:Xmpp_Name_Confirm];
    if (IsStrEmpty(value)) {
        [confirm setStringValue:value];
    }
    return confirm;

}

/*
 <label>美女</label>
 */
+ (XMPPElement *)labelElementWithValue:(NSString *)value{
    XMPPElement *labe = [XMPPElement elementWithName:Xmpp_Name_Label];
    if (IsStrEmpty(value)) {
        [labe setStringValue:value];
    }
    return labe;
}

/*
 <labelId>72</labelId>
 */
+ (XMPPElement *)labelIdElementWithValue:(NSString *)value{
    XMPPElement *labeId = [XMPPElement elementWithName:Xmpp_Name_LabelId];
    if (IsStrEmpty(value)) {
        [labeId setStringValue:value];
    }
    return labeId;
}

/*
 <jid>34001485295@sitopenfireserver01</jid>
 */
+ (XMPPElement *)jidElementWithValue:(NSString *)value{
    XMPPElement *jid = [XMPPElement elementWithName:Xmpp_Name_Jid];
    if (IsStrEmpty(value)) {
        [jid setStringValue:value];
    }
    return jid;
}

/*
 <body>
 <![CDATA[<label>vcv</label>]]>
 </body>
 */
+ (XMPPElement *)bodyElementWithValue:(NSString *)value{
    XMPPElement *body = [XMPPElement elementWithName:Xmpp_Name_Body];
    if (IsStrEmpty(value)) {
        [body setStringValue:value];
    }
    return body;
}

/*
 <item jid=”testonly@onlinedev1”></item>
 */
+ (XMPPElement *)itemElement:(NSString *)value{
    XMPPElement *item = [XMPPElement elementWithName:Xmpp_Name_Item];
    [item addAttributeWithName:Xmpp_AttriName_JID stringValue:self.user.jid];
    
    if (IsStrEmpty(value)) {
        [item setStringValue:value];
    }
    return item;

}

/*
 <delay xmlns="urn:xmpp:delay" stamp="2013-05-22T06:20:10.178Z"/>
 */
+ (XMPPElement *)delayElement{
    XMPPElement *delay = [XMPPElement elementWithName:Xmpp_Name_Delay];
    [delay addAttributeWithName:Xmpp_AttriName_Xmlns stringValue:Xmpp_AttriValue_Delay];
    NSDate *date = [NSDate date];
    NSString *timestamp = [NSDate stringFromDate:date withFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"];
    [delay addAttributeWithName:Xmpp_AttriName_Stamp stringValue:timestamp];
    return delay;
}

+ (NSString *)CDATAWithValue:(NSString *)value{
    if (IsStrEmpty(value)) {
        value = @"";
    }
    NSString* nodeString = [NSString stringWithFormat:@"![CDATA[%@]]>",value];
    return nodeString;
}

/*
 <![CDATA[
 {”configuration”:{ ”roster_validate”: ”accept”/”deny”/”validate” }｝
 ]]>
 */
+ (NSString *)CDATAWithConfigType:(EUserAddConfigType)configType{
    NSDictionary *validateDic = [NSDictionary dictionary];
    switch (configType) {
        case eAcceptType:
        {
            [validateDic setValue:@"accept" forKey:@"roster_validate"];
        }
            break;
        case eDenyType:
        {
            [validateDic setValue:@"deny" forKey:@"roster_validate"];
        }
            break;
        case eValidateType:
        {
            [validateDic setValue:@"validate" forKey:@"roster_validate"];
        }
            break;
        default:
            break;
    }
    NSDictionary *configDic = [NSDictionary dictionaryWithObject:validateDic forKey:@"configuration"];
    NSString *configJsonStr = [configDic JSONString];
    NSString *cDataStr = [XMPPElement CDATAWithValue:configJsonStr];
    return cDataStr;
}

@end
