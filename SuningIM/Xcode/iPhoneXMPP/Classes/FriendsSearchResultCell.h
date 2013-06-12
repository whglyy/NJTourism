//
//  FriendsSearchResultCell.h
//  SuningIM
//
//  Created by shasha on 13-6-3.
//
//

#import <UIKit/UIKit.h>
#import "EGOImageViewEx.h"

@interface FriendsSearchResultCell : UITableViewCell
@property (strong, nonatomic) SNXMPPvCard *vcard;
@property (weak, nonatomic) IBOutlet EGOImageViewEx *IconImageView;

@property (weak, nonatomic) IBOutlet UILabel *NickNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *InfoLabel;
@property (weak, nonatomic) IBOutlet UIButton *AddFriendsBtn;

- (IBAction)AddFriends:(id)sender;

+ (CGFloat)Height;
@end
