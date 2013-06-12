//
//  FriendsListCell.m
//  SuningIM
//
//  Created by lyywhg on 13-5-31.
//
//

#import "FriendsListCell.h"

@implementation FriendsListCell
#pragma mark-
#pragma mark System Init
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        // Initialization code
    }
    return self;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}
#pragma mark-
#pragma mark Init & Add
- (EGOImageView *)friendHeadImage
{
    if (!_friendHeadImage)
    {
        _friendHeadImage = [[EGOImageView alloc] init];
        _friendHeadImage.delegate = self;
        _friendHeadImage.placeholderImage = [UIImage imageNamed:@"snim_default_people.png"];
    }
    return _friendHeadImage;
}
- (UILabel *)friendNameLabel
{
    if (!_friendNameLabel)
    {
        _friendNameLabel = [[UILabel alloc] init];
    }
    return _friendNameLabel;
}
- (UILabel *)friendSignLabel
{
    if (!_friendSignLabel)
    {
        _friendSignLabel = [[UILabel alloc] init];
    }
    return _friendSignLabel;
}

- (void)setFriendListInfo:(FriendInfoDTO *)friendInfo
{
    if ( (friendInfo.friendHeaderImage != nil) && ([friendInfo.friendHeaderImage length] != 0) )
    {
        NSURL *tmpImageUrl = [[NSURL alloc] initWithString:friendInfo.friendHeaderImage];
        [self.friendHeadImage setImageURL:tmpImageUrl];
    }
    self.friendNameLabel.text = friendInfo.friendUserName;
    self.friendSignLabel.text = friendInfo.friendSignNote;
}

@end
