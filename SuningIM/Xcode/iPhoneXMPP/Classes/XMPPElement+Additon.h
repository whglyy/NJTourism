//
//  XMPPElement+Additon.h
//  SuningIM
//
//  Created by shasha on 13-6-5.
//
//

#import "XMPPElement.h"
#import "SNXmppConstant.h"

typedef enum{
    eDenyType,
    eAcceptType,
    eValidateType
} EUserAddConfigType;

@interface XMPPElement (Additon)


/*
    <field type="hidden" var="FORM_TYPE">
    <value>jabber:iq:globalSearch</value>
    </field>
 */
+ (XMPPElement *)filedElementWithType:(NSString *)type
                                  Var:(NSString *)var
                                Value:(NSString *)value;


/*
    <set xmlns="http://jabber.org/protocol/rsm">
    <index>1</index>
    <max>10</max>
    </set>
 */
+ (XMPPElement *)setElementWithIndex:(NSString *)index
                                 Max:(NSString *)max;

/*
 <x xmlns="jabber:x:data" type="submit">
 </x>
 */
+ (XMPPElement *)xElementWithType:(NSString *)type
                            Xmlns:(NSString *)xmlns;


/*
 <query xmlns="jabber:x:data">
 </query>
 */
+ (XMPPElement *)queryElementWithXmlns:(NSString *)xmlns;

/*
 <operation>add</operation>
 */
+ (XMPPElement *)operationElementWithValue:(NSString *)value;

/*
<from>34001485295@sitopenfireserver01.cnsuning.com</from>
 */
+ (XMPPElement *)fromElementWithValue:(NSString *)value;

/*
 <confirm>1</confirm>
 */
+ (XMPPElement *)confirmElementWithValue:(NSString *)value;

/*
<label>美女</label>
 */
+ (XMPPElement *)labelElementWithValue:(NSString *)value;

/*
 <labelId>72</labelId>
 */
+ (XMPPElement *)labelIdElementWithValue:(NSString *)value;

/*
<jid>34001485295@sitopenfireserver01</jid>
 */
+ (XMPPElement *)jidElementWithValue:(NSString *)value;

/*
 <body>
 <![CDATA[<label>vcv</label>]]>
 </body>
 */
+ (XMPPElement *)bodyElementWithValue:(NSString *)value;

/*
 <delay xmlns="urn:xmpp:delay" stamp="2013-05-22T06:20:10.178Z"/>
 2013-05-22 06:20:10.
 */
+ (XMPPElement *)delayElement;

/*
<item jid=”testonly@onlinedev1”></item>
 */
+ (XMPPElement *)itemElement:(NSString *)value;

/*
 		<![CDATA[<label>vcv</label>]]>
 */
+ (NSString *)CDATAWithValue:(NSString *)value;

/*
 <![CDATA[
 {”configuration”:{ ”roster_validate”: ”accept”/”deny”/”validate” }｝
 ]]>
 */
+ (NSString *)CDATAWithConfigType:(EUserAddConfigType)configType;

@end
