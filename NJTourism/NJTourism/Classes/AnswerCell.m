//
//  AnswerCell.m
//  Cells
//
//  Created by lyywhg on 12-11-17.
//  Copyright 2011 sn. All rights reserved.
//

#import "AnswerCell.h"

@implementation AnswerCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
//        [self.contentView addSubview:self.backgroundImage];
//        [self.contentView addSubview:self.answerTextLabel];
    }
    return self;
}

- (void)setAnswerLabel:(CGRect)labelRect answerLabel:(int)numberLines backgroundImage:(CGRect)imageRect
{
    self.backgroundImage.frame = imageRect;
    self.answerTextLabel.frame = labelRect;
    self.answerTextLabel.numberOfLines = numberLines;
    [self.contentView bringSubviewToFront:self.answerTextLabel];
}

- (UILabel *)answerTextLabel
{
    if (!_answerTextLabel)
    {
        _answerTextLabel = [[UILabel alloc] init];
        _answerTextLabel.font = [UIFont systemFontOfSize:18];
        _answerTextLabel.frame = CGRectZero;
        _answerTextLabel.backgroundColor = [UIColor clearColor];
        _answerTextLabel.textColor = RGBACOLOR(118, 113, 103, 1);
        _answerTextLabel.lineBreakMode = UILineBreakModeCharacterWrap;
        [self.contentView addSubview:_answerTextLabel];
    }
    return _answerTextLabel;
}

- (UIImageView *)backgroundImage
{
    if (!_backgroundImage)
    {
        _backgroundImage = [[UIImageView alloc] init];
        _backgroundImage.backgroundColor = [UIColor whiteColor];
        _backgroundImage.layer.cornerRadius = 6;
        _backgroundImage.frame = CGRectZero;
        [_backgroundImage addSubview:self.seperatorLine];
        
        [self.contentView addSubview:_backgroundImage];
    }
    
    return _backgroundImage;
}

- (UILabel *)seperatorLine
{
    if (!_seperatorLine)
    {
        _seperatorLine = [[UILabel alloc] initWithFrame:CGRectMake(12, 15, 276, 1)];
        
        _seperatorLine.backgroundColor = RGBACOLOR(127, 181, 216, 1);
    }
    
    return _seperatorLine;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

- (void)dealloc
{
    TT_RELEASE_SAFELY(_answerTextLabel);
    TT_RELEASE_SAFELY(_backgroundImage);
    TT_RELEASE_SAFELY(_seperatorLine);
    
    [super dealloc];
}

@end
