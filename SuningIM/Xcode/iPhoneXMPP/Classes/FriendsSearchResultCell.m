//
//  FriendsSearchResultCell.m
//  SuningIM
//
//  Created by shasha on 13-6-3.
//
//

#import "FriendsSearchResultCell.h"

@interface FriendsSearchResultCell ()

@end

@implementation FriendsSearchResultCell

+ (CGFloat)Height{
    return 65.0f;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.IconImageView.placeholderImage = [UIImage imageNamed:@"defaultPerson.png"];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (void)setVcard:(SNXMPPvCard *)vcard{
    if (_vcard != vcard) {
        _vcard = nil;
        _vcard = vcard;
        self.NickNameLabel.text = self.vcard.nickname;
        if (IsStrEmpty( self.vcard.title)) {
            self.InfoLabel.text = L(@"这孩子啥都没说⋯⋯");
        }else{
            self.InfoLabel.text = self.vcard.title;
        }
        if (IsStrEmpty(self.vcard.photoUrl)) {
            self.IconImageView.imageURL = [NSURL URLWithString:self.vcard.photoUrl];
        }
    }
}

- (IBAction)AddFriends:(id)sender {
    
    SNXmppFriends *friends = [XmppManager shareInstance].xmppFriends;
    [friends addFriends:[self.vcard.jid full] callback:^(BOOL isSuccess, NSString *errorMsg, id result) {
        
    }];
}

@end
