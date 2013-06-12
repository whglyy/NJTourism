//
//  UserInfoDTO.m
//  TempleteProject
//
//  Created by shasha on 13-3-19.
//  Copyright (c) 2013年 shasha. All rights reserved.
//

#import "UserInfoDTO.h"
#import "OpenUDID.h"

@implementation UserInfoDTO

- (void)encodeFromDictionary:(NSDictionary *)dic{
    [super encodeFromDictionary:dic];
    self.isRightInfo = EncodeObjectFromDic(dic, @"isRightInfo");
    self.uid = EncodeObjectFromDic(dic, @"uid");
    self.jid = EncodeObjectFromDic(dic, @"jid");
    self.pwd = EncodeObjectFromDic(dic,@"pwd");
    self.openfireip = EncodeObjectFromDic(dic,@"openfireip");
    self.port = EncodeObjectFromDic(dic,@"port");
    self.openfiredomain = EncodeObjectFromDic(dic,@"openfiredomain");
    self.httpport = EncodeObjectFromDic(dic,@"httpport");
    self.cmport = EncodeObjectFromDic(dic,@"cmport");
}

@end
