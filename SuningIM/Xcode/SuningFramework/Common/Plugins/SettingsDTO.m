//
//  SettingsDTO.m
//  SuningPan
//
//  Created by shasha on 13-4-7.
//  Copyright (c) 2013年 suning. All rights reserved.
//

#import "SettingsDTO.h"

@implementation SettingsDTO

- (id)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder
{
    [coder encodeObject:self.versionTitle forKey:@"versionTitle"];
    [coder encodeObject:self.versionContent forKey:@"versionContent"];
    [coder encodeObject:self.versionDetail forKey:@"versionDetail"];
    [coder encodeObject:self.versionForce forKey:@"versionForce"];
    [coder encodeObject:self.serverVersion forKey:@"serverVersion"];
    [coder encodeObject:self.downloadUrl forKey:@"downloadUrl"];
    [coder encodeObject:self.upgrade forKey:@"upgrade"];
    [coder encodeObject:self.forceUpgrade forKey:@"forceUpgrade"];
    

    [coder encodeObject:self.isAutoCopyPicture
                 forKey:@"isAutoCopyPicture"];
    [coder encodeObject:self.isOnlyWifyUpload
                 forKey:@"isOnlyWifyUpload"];
    [coder encodeObject:self.isNeedAlertVoice
                 forKey:@"isNeedAlertVoice"];
    [coder encodeObject:self.uploadQuality forKey:@"uploadQuality"];
    [coder encodeObject:self.versionUpdateCancel forKey:@"versionUpdateCancel"];
    
    [coder encodeObject:self.helperVersion forKey:@"helperVersion"];

}

 

- (id)initWithCoder:(NSCoder *)coder
{
    if (self = [super init]) {
        self.versionTitle = [coder decodeObjectForKey:@"versionTitle"];
        self.versionContent = [coder decodeObjectForKey:@"versionContent"];
        self.versionDetail = [coder decodeObjectForKey:@"versionDetail"];
        self.versionForce = [coder decodeObjectForKey:@"versionForce"];
        self.serverVersion = [coder decodeObjectForKey:@"serverVersion"];
        self.downloadUrl = [coder decodeObjectForKey:@"downloadUrl"];
        self.upgrade = [coder decodeObjectForKey:@"upgrade"];
        self.forceUpgrade = [coder decodeObjectForKey:@"forceUpgrade"];
        
        self.isAutoCopyPicture = [coder decodeObjectForKey:@"isAutoCopyPicture"];
        self.isOnlyWifyUpload = [coder decodeObjectForKey:@"isOnlyWifyUpload"];
        self.isNeedAlertVoice = [coder decodeObjectForKey:@"isNeedAlertVoice"];
        self.uploadQuality = [coder decodeObjectForKey:@"uploadQuality"];
        self.versionUpdateCancel = [coder decodeObjectForKey:@"versionUpdateCancel"];

        self.helperVersion = [coder decodeObjectForKey:@"helperVersion"];
    }
    return self;
}


@end
