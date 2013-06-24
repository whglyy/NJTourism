//
//  RevealCell.m
//  NJTourism
//
//  Created by lyywhg on 13-6-24.
//
//

#import "RevealCell.h"

@interface RevealCell()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation RevealCell

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

- (void)setAllContent:(NSString *)title
{
    _titleLabel.text = title;
}

@end
