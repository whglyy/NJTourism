//
//  ContactCell.h
//  SuningIM
//
//  Created by shasha on 13-6-4.
//
//

#import <UIKit/UIKit.h>
#import "ContactDTO.h"

@protocol ContactCellDelegate <NSObject>

- (void)addFriends:(ContactDTO *)dto;

- (void)talkFriends:(ContactDTO *)dto;

@end

@interface ContactCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIButton *AddBtn;
@property (weak, nonatomic) IBOutlet UILabel  *nameLabel;
@property (nonatomic, weak) id<ContactCellDelegate>  delegate;
@property (nonatomic, strong) ContactDTO      *contactDTO;

+ (CGFloat)Height;

- (IBAction)AddAction:(id)sender;


@end
