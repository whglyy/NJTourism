//
//  CmdHelper.h
//  FatFist
//
//  Copyright 2011 FatFish. All rights reserved.
//
//
#ifndef FatFistEBuy_CmdHelper_h
#define FatFistEBuy_CmdHelper_h
//通过cmdCode判断是否需要登录
bool CC_Login_Contain(int cmdCode);
bool CC_Need_Cookie_Contain(int cmdCode);
#endif
