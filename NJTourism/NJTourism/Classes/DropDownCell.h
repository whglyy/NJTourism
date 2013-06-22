//
//  DropDownCell.h
//  Cells
//
//  Created by lyywhg on 12-11-17.
//  Copyright 2011 sn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DropDownCell : UITableViewCell
{
    BOOL isOpen;
}

@property (nonatomic) BOOL isOpen;

@property (nonatomic, retain) UILabel *topTextLabel;
@property (nonatomic, retain) UIImageView *arrow_up;
@property (nonatomic, retain) UIImageView *arrow_down;
@property (nonatomic, retain) UIImageView *backgroundImage;

- (BOOL) setOpen;
- (BOOL) setClosed;

@end
