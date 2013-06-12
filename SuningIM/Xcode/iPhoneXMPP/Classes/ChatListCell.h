//
//  ChatListCell.h
//  SuningIM
//
//  Created by lyywhg on 13-5-27.
//
//

/*
 说明：会话窗口的TableView_Cell
 */

#import "EGOImageViewEx.h"

#import "FriendInfoHeader.h"
#import "UnreadMessageCount.h"
#import "RegulateChatRecordsTime.h"

@interface ChatListCell : UITableViewCell<EGOImageViewExDelegate>

@property (strong, nonatomic) IBOutlet EGOImageViewEx *chatHeaderImageView;
@property (strong, nonatomic) IBOutlet UILabel *chatUserNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *chatTimeLabel;
@property (strong, nonatomic) IBOutlet UILabel *chatMessageLabel;

- (void)reloadChatListCellInfo:(FriendInfoDTO *)friendInfo;

@end
