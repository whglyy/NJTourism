//
//  DropDownCell.m
//  Cells
//
//  Created by lyywhg on 12-11-17.
//  Copyright 2011 sn. All rights reserved.
//

#import "DropDownCell.h"

@implementation DropDownCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        [self.contentView addSubview:self.backgroundImage];
        [self.contentView addSubview:self.arrow_up];
        self.arrow_up.hidden = YES;
        [self.contentView addSubview:self.topTextLabel];
    }
    return self;
}

- (UIImageView *)arrow_up
{
    if (!_arrow_up)
    {
        _arrow_up = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"question_arrow_up.png"]];
        _arrow_up.frame = CGRectMake(280, 36, 16, 16);
    }
    return _arrow_up;
}

- (UIImageView *)backgroundImage
{
    if (!_backgroundImage)
    {
        _backgroundImage = [[UIImageView alloc] init];
        _backgroundImage.backgroundColor = [UIColor whiteColor];
        _backgroundImage.layer.cornerRadius = 6;
        _backgroundImage.frame = CGRectMake(10, 10, 300, self.contentView.height);
    }
    return _backgroundImage;
}

- (UILabel *)topTextLabel
{
    if (!_topTextLabel)
    {
        _topTextLabel = [[UILabel alloc] init];
        _topTextLabel.font = [UIFont systemFontOfSize:18];
        _topTextLabel.backgroundColor = [UIColor clearColor];
        _topTextLabel.frame = CGRectMake(19, 2.5, 240, 40);
        _topTextLabel.textColor = RGBACOLOR(14, 48, 134, 1);
        _topTextLabel.lineBreakMode = UILineBreakModeCharacterWrap;
    }
    return _topTextLabel;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

@end
