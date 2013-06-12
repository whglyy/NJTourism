//
//  SNXmppFriends.h
//  SuningIM
//
//  Created by shasha on 13-6-5.
//
//

#import "SearchCondtion.h"
#import "SNXmppConstant.h"
#import "SNXMPPvCard.h"

@interface SNXmppFriends : XMPPModule

- (void)sendAccurateSearch:(SearchCondtion *)condition
                     callback:(SNCallBackBlockWithResult) block;

- (void)addFriends:(NSString *)JID callback:(SNCallBackBlockWithResult) block;


@end

@protocol SNXmppFriendsDelegate
@optional

- (void)xmppSearch:(SNXmppFriends *)sender didReceiveResultsRequest:(NSArray *)resultArr;

@end