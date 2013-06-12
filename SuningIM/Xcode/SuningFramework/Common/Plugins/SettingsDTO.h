//
//  SettingsDTO.h
//  SuningPan
//
//  Created by shasha on 13-4-7.
//  Copyright (c) 2013年 suning. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseHttpDTO.h"

@interface SettingsDTO : BaseHttpDTO <NSCoding>

/**版本更新标题*/
@property (nonatomic, copy) NSString *versionTitle;
/**版本更新内容*/
@property (nonatomic, copy) NSString *versionContent;
/**版本更新详细说明*/
@property (nonatomic, copy) NSString *versionDetail;
/**需要强制版本更新版本号：例如1.0,2.0,3.0  用逗号区分*/
@property (nonatomic, copy) NSString *versionForce;
/**当前服务器版本号*/
@property (nonatomic, copy) NSString  *serverVersion;
/**更新地址*/
@property (nonatomic, copy) NSString *downloadUrl;
/**是否有更新*/
@property (nonatomic, copy) NSString *upgrade;

/**是否有需要强制更新*/
@property (nonatomic, copy) NSString *forceUpgrade;

/**是否自动保存图片*/
@property (nonatomic, retain) NSNumber *isAutoCopyPicture;

/**是否仅仅是wifi上传*/
@property (nonatomic, retain) NSNumber *isOnlyWifyUpload;

/**是否需要提示音*/
@property (nonatomic, retain) NSNumber *isNeedAlertVoice;

/**上传图片质量*/
@property (nonatomic, copy) NSString  *uploadQuality;

@property (nonatomic, retain)NSNumber *versionUpdateCancel;


/**当前指引页的版本号*/
@property (nonatomic, copy) NSString  *helperVersion;

@end
