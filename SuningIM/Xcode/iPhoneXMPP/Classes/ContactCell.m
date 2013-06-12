//
//  ContactCell.m
//  SuningIM
//
//  Created by shasha on 13-6-4.
//
//

#import "ContactCell.h"

@interface ContactCell ()

@end

@implementation ContactCell

+ (CGFloat)Height{
    return 50;
}

- (IBAction)AddAction:(id)sender {
    if (!IsStrEmpty(self.contactDTO.jid) ) {
        if ([self.delegate respondsToSelector:@selector(talkFriends:)]) {
            [self.delegate talkFriends:self.contactDTO];
        }
    }else{
        if ([self.delegate respondsToSelector:@selector(addFriends:)]) {
            [self.delegate addFriends:self.contactDTO];
        }
    }
}

- (void)setContactDTO:(ContactDTO *)contactDTO{
    if (_contactDTO != contactDTO) {
        _contactDTO = nil;
        _contactDTO = contactDTO;
        self.nameLabel.text = self.contactDTO.userName;
        switch (self.contactDTO.status) {
            case eStatusUnAdd:
                [self.AddBtn setTitle:L(@"加为好友") forState:UIControlStateNormal];
                break;
            case eStatusInvited:
                [self.AddBtn setTitle:L(@"邀请") forState:UIControlStateNormal];
                break;
            case eStatusAdded:
                [self.AddBtn setTitle:L(@"已添加") forState:UIControlStateNormal];
                break;
            default:
                break;
        }
    }
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}


@end
