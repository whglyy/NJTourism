//
//  SettingViewController.h
//  SuningIM
//
//  Created by shasha on 13-5-24.
//
//

#import <UIKit/UIKit.h>
#import "FriendsAddListCell.h"


@interface SettingViewController : CommonViewController<UITableViewDelegate,UITableViewDataSource,UIActionSheetDelegate>
@property (strong, nonatomic) IBOutlet UIButton *logout;

@end
