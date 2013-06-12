//
//  XmppManager.h
//  SuningIM
//
//  Created by shasha on 13-5-23.
//
//

#import <Foundation/Foundation.h>
#import "XMPPFramework.h"
#import "XMPPvCardTempModule.h"
#import "NSXMLElement+XMPP.h"
#import "DDXML.h"
#import "SNXmppFriends.h"
#import "FriendInfoHeader.h"
#import "FriendListDao.h"
#import "ChatRecordListDao.h"

@interface XmppManager : NSObject<XMPPStreamDelegate, XMPPParserDelegate, XMPPvCardTempModuleDelegate>
{
    XMPPCapabilitiesCoreDataStorage *xmppCapabilitiesStorage;
}

@property (nonatomic, strong, readonly) XMPPStream              *xmppStream;
@property (nonatomic, strong, readonly) XMPPReconnect           *xmppReconnect;
@property (nonatomic, strong, readonly) XMPPRoster              *xmppRoster;
@property (nonatomic, strong, readonly) SNXmppFriends           *xmppFriends;

@property (nonatomic, strong, readonly) XMPPRosterCoreDataStorage *xmppRosterStorage;
@property (nonatomic, strong, readonly) XMPPvCardTempModule       *xmppvCardTempModule;
@property (nonatomic, strong, readonly) XMPPvCardAvatarModule     *xmppvCardAvatarModule;
@property (nonatomic, strong, readonly) XMPPCapabilities          *xmppCapabilities;
@property (nonatomic, strong, readonly) XMPPvCardCoreDataStorage  *xmppvCardStorage;

- (void)registerToApp;

- (NSManagedObjectContext *)managedObjectContext_roster;
- (NSManagedObjectContext *)managedObjectContext_capabilities;

- (BOOL)connect;
- (void)disconnect;

- (void)setupStream;

- (void)goOnline;
- (void)goOffline;

+ (XmppManager *)shareInstance;

@end
