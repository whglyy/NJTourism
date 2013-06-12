//
//  FriendsListCell.h
//  SuningIM
//
//  Created by lyywhg on 13-5-31.
//
//

/*
 说明：
    朋友列表Cell
 */

#import <UIKit/UIKit.h>
#import "EGOImageView.h"

@interface FriendsListCell : UITableViewCell<EGOImageViewDelegate>

@property (strong, nonatomic) IBOutlet EGOImageView *friendHeadImage;
@property (strong, nonatomic) IBOutlet UILabel *friendNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *friendSignLabel;

- (void)setFriendListInfo:(FriendInfoDTO *)friendInfo;

@end
