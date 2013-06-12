//
//  PersonalDataViewController.h
//  SuningIM
//
//  Created by wangbao on 13-6-4.
//
//

#import <UIKit/UIKit.h>
#import "PersonalDataViewCell.h"
@interface PersonalDataViewController : CommonViewController<UITableViewDataSource,UITableViewDelegate,UIActionSheetDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>


@property (nonatomic, retain) NSString *jid;
@property (nonatomic, retain) NSString *password;
@property (nonatomic, retain) NSString *timestamp;
@property (nonatomic, retain) NSString *md5;

@end
