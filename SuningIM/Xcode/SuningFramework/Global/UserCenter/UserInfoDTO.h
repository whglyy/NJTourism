//
//  UserInfoDTO.h
//  TempleteProject
//
//  Created by shasha on 13-3-19.
//  Copyright (c) 2013年 shasha. All rights reserved.
//

#import "BaseHttpDTO.h"
@interface UserInfoDTO : BaseHttpDTO
@property (nonatomic, copy) NSString  *isRightInfo;
@property (nonatomic, copy) NSString  *errorCode;
@property (nonatomic, copy) NSString  *uid;
@property (nonatomic, copy) NSString  *jid;
@property (nonatomic, copy) NSString  *pwd;
@property (nonatomic, copy) NSString  *openfireip;

@property (nonatomic, copy) NSString  *port;
@property (nonatomic, copy) NSString  *openfiredomain;
@property (nonatomic, copy) NSString  *httpport;
@property (nonatomic, copy) NSString   *cmdomain;
@property (nonatomic, copy) NSString   *cmport;

@property (nonatomic, copy) NSString  *ip;

@property (nonatomic, copy) NSString   *userName;
@property (nonatomic, copy) NSString   *passWord;


@end
