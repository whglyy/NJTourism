//
//  UserCenter.m
//  TempleteProject
//
//  Created by shasha on 13-3-19.
//  Copyright (c) 2013年 shasha. All rights reserved.
//

#import "UserCenter.h"
@interface UserCenter()


@end


@implementation UserCenter
@synthesize isLogined = _isLogined;
@synthesize userInfoDTO = _userInfoDTO;
@synthesize lastUserId = _lastUserId;
@synthesize isBindPhone = _isBindPhone;

- (id)init {
    
    self = [super init];
    
    if (self) {
        _isLogined = NO;
    }
    
    return self;
}

#pragma mark - UserInfo Methods
#pragma mark   用户信息模块

- (void)setUserInfoDTO:(UserInfoDTO *)userInfoDTO
{
    if (userInfoDTO != _userInfoDTO) {
        
        if (userInfoDTO) {
            _isLogined = YES;
        }else{
            _isLogined = NO;
        }
        
   
        _userInfoDTO = userInfoDTO ;
    }
}

- (UserInfoDTO *)userInfoDTO{
    if (!_userInfoDTO) {
        _userInfoDTO = [[UserInfoDTO alloc] init];
    }
    return _userInfoDTO;
}

- (BOOL)isBindPhone{
    if (IsStrEmpty(self.bindPhoneNum)) {
        return NO;
    }else{
        return YES;
    }
}

- (void)setBindPhoneNum:(NSString *)bindPhoneNum{

    if (IsStrEmpty(bindPhoneNum)) {
        self.bindPhoneNum = @"";
        _isBindPhone = NO;
    }else{
        self.bindPhoneNum = bindPhoneNum;
        _isBindPhone = YES;
    }
}

#pragma mark Singleton methods
#pragma mark 单例方法

static UserCenter *defaultUserCenter = nil;

+ (UserCenter *)defaultCenter
{
    @synchronized(self){
        if (defaultUserCenter == nil) {
            defaultUserCenter = [[UserCenter alloc] init];
            
        }
    }
    return defaultUserCenter;
}

+ (id)allocWithZone:(NSZone *)zone
{
    @synchronized(self)
    {
        if (defaultUserCenter == nil)
        {
            defaultUserCenter = [super allocWithZone:zone];
            
            return defaultUserCenter;
        }
    }
    return nil;
}



@end
