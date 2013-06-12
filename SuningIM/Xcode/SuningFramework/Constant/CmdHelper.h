//
//  CmdHelper.h
//  SuningEBuy
//
//  Created by 刘坤 on 12-9-5.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#ifndef SuningEBuy_CmdHelper_h
#define SuningEBuy_CmdHelper_h

//通过cmdCode判断是否需要登录
bool CC_Login_Contain(int cmdCode);

bool CC_Need_Cookie_Contain(int cmdCode);

#endif
