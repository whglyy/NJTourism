//
//  AnswerCell.h
//  Cells
//
//  Created by lyywhg on 12-11-17.
//  Copyright 2011 sn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AnswerCell : UITableViewCell
{
}

@property (nonatomic, retain) UILabel *answerTextLabel;
@property (nonatomic, retain) UIImageView *backgroundImage;

@property (nonatomic, retain) UILabel *seperatorLine;

- (void)setAnswerLabel:(CGRect)labelRect answerLabel:(int)numberLines backgroundImage:(CGRect)imageRect;

@end
