//
//  XmppManager.m
//  SuningIM
//
//  Created by shasha on 13-5-23.
//
//

#import "XmppManager.h"
#import "SNXMPPvCard.h"
@interface XmppManager(){
    
	BOOL allowSelfSignedCertificates;
	BOOL allowSSLHostNameMismatch;
	
	BOOL isXmppConnected;
}

@end

@implementation XmppManager
@synthesize xmppStream = _xmppStream;
@synthesize xmppReconnect = _xmppReconnect;
@synthesize xmppRosterStorage = _xmppRosterStorage;
@synthesize xmppRoster = _xmppRoster;
@synthesize xmppvCardStorage = _xmppvCardStorage;
@synthesize xmppvCardTempModule = _xmppvCardTempModule;
@synthesize xmppvCardAvatarModule = _xmppvCardAvatarModule;
@synthesize xmppCapabilities = _xmppCapabilities;
@synthesize xmppFriends = _xmppFriends;
- (void)dealloc
{
    [self teardownStream];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)registerToApp{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(LoginComplete:) name:LOGIN_OK_NOTIFICATION object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(LogoutComplete:) name:LOGOUT_OK_NOTIFICATION object:nil];

}

- (void)LoginComplete:(NSNotification *)note{
    [self setupStream];
    [self connect];
}

- (void)LogoutComplete:(NSNotification *)note{
    [self disconnect];
}

/*Start Set up XMPP Connection*/
- (void)startXMPPConnection{
        
    // Setup the XMPP stream
	[self setupStream];
    
    if (![self connect])
	{
		dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 0.0 * NSEC_PER_SEC);
		dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
			
		});
	}
}

- (void)teardownStream
{
	[self.xmppStream removeDelegate:self];
	[self.xmppRoster removeDelegate:self];
	
	[self.xmppReconnect         deactivate];
	[self.xmppRoster            deactivate];
	[self.xmppvCardTempModule   deactivate];
	[self.xmppvCardAvatarModule deactivate];
	[self.xmppCapabilities      deactivate];
    [self.xmppFriends     deactivate];
	
	[self.xmppStream disconnect];
	
	_xmppStream = nil;
	_xmppReconnect = nil;
    _xmppRoster = nil;
	_xmppRosterStorage = nil;
	_xmppvCardStorage = nil;
    _xmppvCardTempModule = nil;
	_xmppvCardAvatarModule = nil;
	_xmppCapabilities = nil;
	xmppCapabilitiesStorage = nil;
    _xmppFriends = nil;
}

- (void)setupStream
{
	NSAssert(_xmppStream == nil, @"Method setupStream invoked multiple times");
 
	// Activate xmpp modules
    
	[self.xmppReconnect         activate:self.xmppStream];
	[self.xmppRoster            activate:self.xmppStream];
	[self.xmppvCardTempModule   activate:self.xmppStream];
	[self.xmppvCardAvatarModule activate:self.xmppStream];
	[self.xmppCapabilities      activate:self.xmppStream];
    
	// Add ourself as a delegate to anything we may be interested in
    
	[self.xmppStream addDelegate:self delegateQueue:dispatch_get_main_queue()];
	[self.xmppRoster addDelegate:self delegateQueue:dispatch_get_main_queue()];
	
    [self.xmppStream setHostName:[UserCenter defaultCenter].userInfoDTO.openfireip];
    [self.xmppStream setHostPort:(UInt16)[[UserCenter defaultCenter].userInfoDTO.port integerValue]];
    // You may need to alter these settings depending on the server you're connecting to
    
	allowSelfSignedCertificates = NO;
	allowSSLHostNameMismatch = NO;
    
    [self connect];
    
}

#pragma mark - On/OffLine Methods
#pragma mark - 上线下线状态方法

- (void)goOnline
{
	XMPPPresence *presence = [XMPPPresence presence]; // type="available" is implicit
	
	[[self xmppStream] sendElement:presence];
}

- (void)goOffline
{
	XMPPPresence *presence = [XMPPPresence presenceWithType:@"unavailable"];
	
	[[self xmppStream] sendElement:presence];
}

#pragma mark - Connect/disconnect
#pragma mark - 连接断开连接方法

- (BOOL)connect
{
	if (![self.xmppStream isDisconnected]) {
		return YES;
	}
 
    NSString *myJID = [UserCenter defaultCenter].userInfoDTO.jid;
    NSString *myPassword = [UserCenter defaultCenter].userInfoDTO.pwd;
	
	if (myJID == nil || myPassword == nil) {
		return NO;
	}
    
	[self.xmppStream setMyJID:[XMPPJID jidWithString:myJID]];
    
	NSError *error = nil;
	if (![self.xmppStream connectWithTimeout:XMPPStreamTimeoutNone error:&error])
	{
		UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error connecting"
		                                                    message:@"See console for error details."
		                                                   delegate:nil
		                                          cancelButtonTitle:@"Ok"
		                                          otherButtonTitles:nil];
		[alertView show];
        
		DDLogError(@"Error connecting: %@", error);
        
		return NO;
	}
    
	return YES;
}

- (void)disconnect
{
	[self goOffline];
	[self.xmppStream disconnect];
}

#pragma mark - XMPPStream Delegate
#pragma mark - XMPPStram  代理方法

- (void)xmppStream:(XMPPStream *)sender socketDidConnect:(GCDAsyncSocket *)socket
{
	DDLogVerbose(@"%@: %@", THIS_FILE, THIS_METHOD);
}

- (void)xmppStream:(XMPPStream *)sender willSecureWithSettings:(NSMutableDictionary *)settings
{
	DDLogVerbose(@"%@: %@", THIS_FILE, THIS_METHOD);
	
	if (allowSelfSignedCertificates)
	{
		[settings setObject:[NSNumber numberWithBool:YES] forKey:(NSString *)kCFStreamSSLAllowsAnyRoot];
	}
	
	if (allowSSLHostNameMismatch)
	{
		[settings setObject:[NSNull null] forKey:(NSString *)kCFStreamSSLPeerName];
	}
	else
	{
		// Google does things incorrectly (does not conform to RFC).
		// Because so many people ask questions about this (assume xmpp framework is broken),
		// I've explicitly added code that shows how other xmpp clients "do the right thing"
		// when connecting to a google server (gmail, or google apps for domains).
		
		NSString *expectedCertName = nil;
		
		NSString *serverDomain = self.xmppStream.hostName;
		NSString *virtualDomain = [self.xmppStream.myJID domain];
		
		if ([serverDomain isEqualToString:@"talk.google.com"])
		{
			if ([virtualDomain isEqualToString:@"gmail.com"])
			{
				expectedCertName = virtualDomain;
			}
			else
			{
				expectedCertName = serverDomain;
			}
		}
		else if (serverDomain == nil)
		{
			expectedCertName = virtualDomain;
		}
		else
		{
			expectedCertName = serverDomain;
		}
		
		if (expectedCertName)
		{
			[settings setObject:expectedCertName forKey:(NSString *)kCFStreamSSLPeerName];
		}
	}
}

- (void)xmppStreamDidSecure:(XMPPStream *)sender
{
	DDLogVerbose(@"%@: %@", THIS_FILE, THIS_METHOD);
}

- (void)xmppStreamDidConnect:(XMPPStream *)sender
{
	DDLogVerbose(@"%@: %@", THIS_FILE, THIS_METHOD);
	
	isXmppConnected = YES;
	
	NSError *error = nil;
	
    NSString *passWord = [UserCenter defaultCenter].userInfoDTO.pwd;
    
	if (![[self xmppStream] authenticateWithPassword:passWord error:&error])
	{
		DDLogError(@"Error authenticating: %@", error);
	}
}

- (void)xmppStreamDidDisconnect:(XMPPStream *)sender withError:(NSError *)error
{
	DDLogVerbose(@"%@: %@", THIS_FILE, THIS_METHOD);
	
	if (!isXmppConnected)
	{
		DDLogError(@"Unable to connect to server. Check xmppStream.hostName");
	}
}

- (void)xmppStreamDidAuthenticate:(XMPPStream *)sender
{
	DDLogVerbose(@"%@: %@", THIS_FILE, THIS_METHOD);
	
	[self goOnline];
}

- (void)xmppStream:(XMPPStream *)sender didNotAuthenticate:(NSXMLElement *)error
{
	DDLogVerbose(@"%@: %@", THIS_FILE, THIS_METHOD);
}


#pragma mark - XMPP Message Delegate Methods
#pragma mark   XMPP 报文代理方法

- (BOOL)xmppStream:(XMPPStream *)sender didReceiveIQ:(XMPPIQ *)iq
{
    //获取到用户好友列表
	DDLogVerbose(@"%@: %@", THIS_FILE, THIS_METHOD);
    
    NSString *iQType = [iq type];
    
    if (IsStrEmpty(iQType)) {
        return NO;
    }
    
    NSString *ActionType = nil;
    
    if ([iQType isEqualToString:XMPP_Type_Result]) {
        
        if ([[iq childElement] elementForName:Xmpp_Name_VCard xmlns:Xmpp_AttriValue_VcardTemp]) {
            
        }
    }
    
    NSXMLElement *query = [iq elementForName:@"query" xmlns:@"jabber:iq:roster"];
	if (query)
    {
        [self parserXmppIq:iq];
        return YES;
    }
    
    NSXMLElement *vCard = [iq elementForName:@"vCard" xmlns:@"vcard-temp"];
    if (vCard)
    {
        if ([[UserCenter defaultCenter].userInfoDTO.jid isEqualToString:[iq attributeStringValueForName:@"from"]])
        {
            SNXMPPvCard *userVcard = [SNXMPPvCard  vCardTempFromElement:vCard];
            [UserCenter defaultCenter].userVCard = userVcard;
            return YES;
        }
        return [self parseXmppVCard:iq];
    }
    
	return NO;
}

- (void)xmppStream:(XMPPStream *)sender didReceiveMessage:(XMPPMessage *)message
{
	DDLogVerbose(@"%@: %@", THIS_FILE, THIS_METHOD);
    
	// A simple example of inbound message handling.
    
	if ([message isChatMessageWithBody])
	{
		[self parseXmppChatMessage:message];
	}
}

- (void)xmppStream:(XMPPStream *)sender didReceivePresence:(XMPPPresence *)presence
{
	DDLogVerbose(@"%@: %@ - %@", THIS_FILE, THIS_METHOD, [presence fromStr]);
}

- (void)xmppStream:(XMPPStream *)sender didReceiveError:(id)error
{
	DDLogVerbose(@"%@: %@", THIS_FILE, THIS_METHOD);
}


#pragma mark - XMPPRosterDelegate
#pragma mark - XMPP 联系人代理方法
- (void)xmppRoster:(XMPPRoster *)sender didReceiveBuddyRequest:(XMPPPresence *)presence
{
	DDLogVerbose(@"%@: %@", THIS_FILE, THIS_METHOD);
	
	XMPPUserCoreDataStorageObject *user = [self.xmppRosterStorage userForJID:[presence from]
	                                                         xmppStream:self.xmppStream
	                                               managedObjectContext:[self managedObjectContext_roster]];
	
	NSString *displayName = [user displayName];
	NSString *jidStrBare = [presence fromStr];
	NSString *body = nil;
	
	if (![displayName isEqualToString:jidStrBare])
	{
		body = [NSString stringWithFormat:@"Buddy request from %@ <%@>", displayName, jidStrBare];
	}
	else
	{
		body = [NSString stringWithFormat:@"Buddy request from %@", displayName];
	}
	
	
	if ([[UIApplication sharedApplication] applicationState] == UIApplicationStateActive)
	{
		UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:displayName
		                                                    message:body
		                                                   delegate:nil
		                                          cancelButtonTitle:@"Not implemented"
		                                          otherButtonTitles:nil];
		[alertView show];
	}
	else
	{
		// We are not active, so use a local notification instead
		UILocalNotification *localNotification = [[UILocalNotification alloc] init];
		localNotification.alertAction = @"Not implemented";
		localNotification.alertBody = body;
		
		[[UIApplication sharedApplication] presentLocalNotificationNow:localNotification];
	}
	
}

#pragma mark - Core Data
#pragma mark - 数据存储
- (NSManagedObjectContext *)managedObjectContext_roster
{
	return [self.xmppRosterStorage mainThreadManagedObjectContext];
}

- (NSManagedObjectContext *)managedObjectContext_capabilities
{
	return [xmppCapabilitiesStorage mainThreadManagedObjectContext];
}

#pragma mark - Property Initial Mehtods
#pragma mark - 初始化方法

- (XMPPStream *)xmppStream{
    if (!_xmppStream) {
        // Setup xmpp stream
        //
        // The XMPPStream is the base class for all activity.
        // Everything else plugs into the xmppStream, such as modules/extensions and delegates.
        
        _xmppStream = [[XMPPStream alloc] init];
        
#if !TARGET_IPHONE_SIMULATOR
        {
            // Want xmpp to run in the background?
            //
            // P.S. - The simulator doesn't support backgrounding yet.
            //        When you try to set the associated property on the simulator, it simply fails.
            //        And when you background an app on the simulator,
            //        it just queues network traffic til the app is foregrounded again.
            //        We are patiently waiting for a fix from Apple.
            //        If you do enableBackgroundingOnSocket on the simulator,
            //        you will simply see an error message from the xmpp stack when it fails to set the property.
            
            _xmppStream.enableBackgroundingOnSocket = YES;
        }
#endif
    }
    return _xmppStream;
}

- (XMPPReconnect *)xmppReconnect{
    if (!_xmppReconnect ) {
        // Setup reconnect
        //
        // The XMPPReconnect module monitors for "accidental disconnections" and
        // automatically reconnects the stream for you.
        // There's a bunch more information in the XMPPReconnect header file.
        
        _xmppReconnect = [[XMPPReconnect alloc] init];
    }
    
    return _xmppReconnect;
}


- (XMPPRosterCoreDataStorage *)xmppRosterStorage{
    if (!_xmppRosterStorage) {
        // Setup roster
        //
        // The XMPPRoster handles the xmpp protocol stuff related to the roster.
        // The storage for the roster is abstracted.
        // So you can use any storage mechanism you want.
        // You can store it all in memory, or use core data and store it on disk, or use core data with an in-memory store,
        // or setup your own using raw SQLite, or create your own storage mechanism.
        // You can do it however you like! It's your application.
        // But you do need to provide the roster with some storage facility.
        
        _xmppRosterStorage = [[XMPPRosterCoreDataStorage alloc] init];
        //	xmppRosterStorage = [[XMPPRosterCoreDataStorage alloc] initWithInMemoryStore];
    }
    return _xmppRosterStorage;
}

- (XMPPRoster *)xmppRoster{
    
    if (!_xmppRoster) {
        _xmppRoster = [[XMPPRoster alloc] initWithRosterStorage:self.xmppRosterStorage];
        
        _xmppRoster.autoFetchRoster = YES;
        _xmppRoster.autoAcceptKnownPresenceSubscriptionRequests = YES;
    }
    return _xmppRoster;
}

- (SNXmppFriends *)xmppFriends{
    if (!_xmppFriends) {
        _xmppFriends = [[SNXmppFriends alloc] init];
    }
    return _xmppFriends;
}

- (XMPPvCardCoreDataStorage *)xmppvCardStorage{
    if (!_xmppvCardStorage) {
        _xmppvCardStorage = [XMPPvCardCoreDataStorage sharedInstance];
    }
    return _xmppvCardStorage;
}

- (XMPPvCardTempModule *)xmppvCardTempModule{
    if (!_xmppvCardTempModule) {
        // Setup vCard support
        //
        // The vCard Avatar module works in conjuction with the standard vCard Temp module to download user avatars.
        // The XMPPRoster will automatically integrate with XMPPvCardAvatarModule to cache roster photos in the roster.
        
        _xmppvCardTempModule = [[XMPPvCardTempModule alloc] initWithvCardStorage:self.xmppvCardStorage];
    }
    return _xmppvCardTempModule;
}

- (XMPPvCardAvatarModule *)xmppvCardAvatarModule{
    if (!_xmppvCardAvatarModule) {
        _xmppvCardAvatarModule = [[XMPPvCardAvatarModule alloc] initWithvCardTempModule:self.xmppvCardTempModule];
    }
    return _xmppvCardAvatarModule;
}
- (XMPPCapabilities *)xmppCapabilities{

    if (!_xmppCapabilities) {
        // Setup capabilities
        //
        // The XMPPCapabilities module handles all the complex hashing of the caps protocol (XEP-0115).
        // Basically, when other clients broadcast their presence on the network
        // they include information about what capabilities their client supports (audio, video, file transfer, etc).
        // But as you can imagine, this list starts to get pretty big.
        // This is where the hashing stuff comes into play.
        // Most people running the same version of the same client are going to have the same list of capabilities.
        // So the protocol defines a standardized way to hash the list of capabilities.
        // Clients then broadcast the tiny hash instead of the big list.
        // The XMPPCapabilities protocol automatically handles figuring out what these hashes mean,
        // and also persistently storing the hashes so lookups aren't needed in the future.
        //
        // Similarly to the roster, the storage of the module is abstracted.
        // You are strongly encouraged to persist caps information across sessions.
        //
        // The XMPPCapabilitiesCoreDataStorage is an ideal solution.
        // It can also be shared amongst multiple streams to further reduce hash lookups.
        xmppCapabilitiesStorage = [XMPPCapabilitiesCoreDataStorage sharedInstance];
        _xmppCapabilities = [[XMPPCapabilities alloc] initWithCapabilitiesStorage:xmppCapabilitiesStorage];
        
        _xmppCapabilities.autoFetchHashedCapabilities = YES;
        _xmppCapabilities.autoFetchNonHashedCapabilities = NO;

    }
    return _xmppCapabilities;
}

#pragma mark Singleton methods
#pragma mark 单例方法

static XmppManager *shareInstance = nil;

+ (XmppManager *)shareInstance
{
    @synchronized(self){
        if (shareInstance == nil) {
            shareInstance = [[XmppManager alloc] init];
        }
    }
    return shareInstance;
}

+ (id)allocWithZone:(NSZone *)zone
{
    @synchronized(self)
    {
        if (shareInstance == nil)
        {
            shareInstance = [super allocWithZone:zone];
            return shareInstance;
        }
    }
    return nil;
}

#pragma mark-
#pragma mark Parse Xmpp
- (NSMutableArray *)parserXmppIq:(XMPPIQ *)iq
{
    NSArray *itemsArray = [[NSArray alloc] initWithArray:[[iq childElement] children]];
    DLog(@"msg_lyywhg:%@, \n %@", itemsArray, [[itemsArray objectAtIndex:0] attributeStringValueForName:@"jid"]);
    
    for (NSXMLElement *friendXML in itemsArray)
    {
        //获取到用户的VCard
        [self.xmppvCardTempModule fetchvCardTempForJID:[XMPPJID jidWithString:[friendXML attributeStringValueForName:@"jid"]]];
    }
    return nil;
}
//获取到好友列表
- (BOOL)parseXmppVCard:(XMPPIQ *)iq
{
    BOOL isSuccess = NO;
    @autoreleasepool
    {
        FriendInfoDTO *tmpFriendInfo = [[FriendInfoDTO alloc] init];
        tmpFriendInfo.userId = [UserCenter defaultCenter].userInfoDTO.jid;
        tmpFriendInfo.friendId = [iq attributeStringValueForName:@"from"];
        
        SNXMPPvCard *vcard = [SNXMPPvCard vCardTempCopyFromIQ:iq];
        tmpFriendInfo.friendUserName = vcard.userName;
        tmpFriendInfo.friendNickName = vcard.nickname;
        tmpFriendInfo.friendBirthDay = vcard.birthDay;
        tmpFriendInfo.friendSex = [vcard.sex integerValue];
        if ( (vcard.photoUrl != nil) && (vcard.photoUrl.length != 0) )
        {
            tmpFriendInfo.friendHeaderImage = vcard.photoUrl;
            DLog(@"msg_lyywhg:%@", vcard.photoUrl);
        }
        else
        {
            tmpFriendInfo.friendHeaderImage = @"";
        }
        char fristNameChar = [[tmpFriendInfo.friendUserName substringToIndex:1] cStringUsingEncoding:NSUTF8StringEncoding];
        char tmpChar = pinyinFirstLetter(fristNameChar);
        char *tmpFirstName = &tmpChar;
        const char *firstName = tmpFirstName;
        NSString *string = [[NSString alloc] initWithFormat:@"%s", firstName];
        tmpFriendInfo.friendNameCharacter = [string substringToIndex:1];
        
        DLog(@"msg_lyywhg:firstName ~ %@", tmpFriendInfo.friendNameCharacter);
        
        tmpFriendInfo.friendGroupName = L(@"我的好友");
        tmpFriendInfo.friendSignNote = vcard.note;
        tmpFriendInfo.totalMessageCount = 0;
        tmpFriendInfo.readedMessageCount = 0;
        tmpFriendInfo.lastUnreadMessage = L(@"空");
        tmpFriendInfo.lastMessageTime = L(@"空");
        tmpFriendInfo.friendShowName = tmpFriendInfo.friendUserName;
        
        FriendListDao *tmpFriendListDao = [[FriendListDao alloc] init];
        
        isSuccess = [[tmpFriendListDao OperateFriendInfoDB:tmpFriendInfo operateIndex:AddFriendActionType] boolValue];
    }
    
    return isSuccess;
}
//收到消息处理
- (BOOL)parseXmppChatMessage:(XMPPMessage *)message
{
    BOOL isSuccess = NO;
    
    ChatRecordDTO *chatRecordDto = [[ChatRecordDTO alloc] init];
    chatRecordDto.friendJID = [[[message attributeStringValueForName:@"from"] componentsSeparatedByString:@"/"] objectAtIndex:0];
    chatRecordDto.userJID = [[[message attributeStringValueForName:@"to"] componentsSeparatedByString:@"/"] objectAtIndex:0];
    chatRecordDto.toJID = chatRecordDto.userJID;
    chatRecordDto.fromJID = chatRecordDto.friendJID;
    chatRecordDto.isSendOk = 1;
    
    @autoreleasepool
    {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init] ;
        [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"];
        NSDate *recordTime = [dateFormatter dateFromString:[[message elementForName:@"delay"] attributeStringValueForName:@"stamp"]];
        NSTimeZone *timeZone = [[NSTimeZone alloc] initWithName:@"Asia/Shanghai"];
        NSInteger timeOff = [timeZone secondsFromGMT];
        NSDate *timeOffDate = [recordTime dateByAddingTimeInterval:timeOff];
        
        NSDateFormatter *recordDateFormatter = [[NSDateFormatter alloc] init];
        [recordDateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss.SSS zzz"];
        NSString *tmpDataString = [recordDateFormatter stringFromDate:timeOffDate];
        chatRecordDto.recordTime = tmpDataString;
    }
    
    NSString *body = [[message elementForName:@"body"] stringValue];
    DDXMLDocument *bodyDocument = [[DDXMLDocument alloc] initWithXMLString:body options:0 error:nil];
    NSString *tmpBody = [[[[[[bodyDocument childAtIndex:0] childAtIndex:1] childAtIndex:0] childAtIndex:0] childAtIndex:0] stringValue];
    chatRecordDto.recordContent = tmpBody;
    
    ChatRecordListDao *chatRecordListDao = [[ChatRecordListDao alloc] init];
    isSuccess = [[chatRecordListDao OperateChatRecordDB:chatRecordDto operateIndex:AddChatRecordActionType] boolValue];
    
    
    [[NSNotificationCenter defaultCenter] postNotificationName:GETMESSAGEFROMESERVICE object:nil];
    
//    XMPPUserCoreDataStorageObject *user = [self.xmppRosterStorage userForJID:[message from]  xmppStream:self.xmppStream managedObjectContext:[self managedObjectContext_roster]];
//    NSString *displayName = [user displayName];
//    if ([[UIApplication sharedApplication] applicationState] != UIApplicationStateActive)
//    {
//        // We are not active, so use a local notification instead
//        UILocalNotification *localNotification = [[UILocalNotification alloc] init];
//        localNotification.alertAction = @"Ok";
//        localNotification.alertBody = [NSString stringWithFormat:@"From: %@\n\n%@",displayName,body];
//        
//        [[UIApplication sharedApplication] presentLocalNotificationNow:localNotification];
//    }
    
    return isSuccess;
}
@end
