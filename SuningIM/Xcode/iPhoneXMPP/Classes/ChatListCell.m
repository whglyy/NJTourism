//
//  ChatListCell.m
//  SuningIM
//
//  Created by lyywhg on 13-5-27.
//
//

#import "ChatListCell.h"

@implementation ChatListCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (EGOImageViewEx *)chatHeaderImageView
{
    if (!_chatHeaderImageView)
    {
        _chatHeaderImageView = [[EGOImageViewEx alloc] init];
        _chatHeaderImageView.placeholderImage = [UIImage imageNamed:@"snim_default_people.png"];
        _chatHeaderImageView.exDelegate = self;
    }
    return _chatHeaderImageView;
}
- (UILabel *)chatUserNameLabel
{
    if (!_chatUserNameLabel)
    {
        _chatUserNameLabel = [[UILabel alloc] init];
    }
    return _chatUserNameLabel;
}
- (UILabel *)chatTimeLabel
{
    if (!_chatTimeLabel)
    {
        _chatTimeLabel = [[UILabel alloc] init];
    }
    return _chatTimeLabel;
}
- (UILabel *)chatMessageLabel
{
    if (!_chatMessageLabel)
    {
        _chatMessageLabel = [[UILabel alloc] init];
    }
    return _chatMessageLabel;
}
- (void)reloadChatListCellInfo:(FriendInfoDTO *)friendInfo
{
    NSURL *tmpHeaderImageUrl = [[NSURL alloc] initWithString:friendInfo.friendHeaderImage];
//    [self.chatHeaderImageView setImageURL:tmpHeaderImageUrl];
    self.chatUserNameLabel.text = friendInfo.friendUserName;
    self.chatMessageLabel.text = friendInfo.lastUnreadMessage;
    self.chatTimeLabel.text = friendInfo.lastMessageTime;
    
    return;
}

- (void)imageExViewDidOk:(EGOImageViewEx *)imageViewEx
{
    
}

@end
