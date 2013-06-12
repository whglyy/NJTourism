//
//  MsgHelper.c
//  FatFist
//
//  Created by lyywhg on 12-9-5.
//  Copyright (c) 2012年 FatFist. All rights reserved.
//

#include <stdio.h>
#include "CmdConstant.h"
#include "CmdHelper.h"


bool CC_Login_Contain(int cmdCode)
{
    int length = sizeof(CC_NEED_LOGIN_QUEUE)/sizeof(int);
    for (int i = 0; i < length; i++)
    {
        if (cmdCode == CC_NEED_LOGIN_QUEUE[i]) {
            return true;
        }
    }
    return false;
}


bool CC_Need_Cookie_Contain(int cmdCode)
{
    int length = sizeof(CC_NEED_COOKIE_QUEUE)/sizeof(int);
    for (int i = 0; i < length; i++)
    {
        if (cmdCode == CC_NEED_COOKIE_QUEUE[i]) {
            return true;
        }
    }
    return false;
}