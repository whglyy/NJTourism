//
//  PersonalDataViewCell.h
//  SuningIM
//
//  Created by wangbao on 13-6-8.
//
//

#import <UIKit/UIKit.h>
#import "EGOImageViewEx.h"

@interface PersonalDataViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet EGOImageViewEx  *InfoImage;
@property (strong, nonatomic) IBOutlet UILabel *InfoLabel;
@property (strong, nonatomic) IBOutlet UILabel *InfoLabelText;

@end
