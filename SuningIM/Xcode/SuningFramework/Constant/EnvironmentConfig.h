//
//  HttpConstant.h
//  SuningFutureStoreVersion2
//
//  Created by Wang Jia on 10-11-28.
//  Copyright 2010 IBM. All rights reserved.
//

#import "ReleaseConfig.h"

#pragma mark -  NetWorkVisible Test Address
#pragma mark    网络畅通测试地址
#define	kNetworkTestAddress						@"http://www.suning.com"
//===============================================================================

#pragma mark -  Umeng AppKey
#pragma mark    友盟搜集健值
#ifdef  kUMNG_RELEASE
#define UMENG_APPKEY    @"Umeng Release AppKey"
#else
#define UMENG_APPKEY    @"Umeng Test appKey"
#endif

//===============================================================================


#pragma mark -  HTTP Host Address
#pragma mark    HTTP服务器域名

#ifdef kSitTest

#define kHostAddressForHttp                     @"http://sitappserver.cnsuning.com"
#define kHostAddressForHttps                    @"https://sitappserver.cnsuning.com"


#elif kPreTest

#define kHostAddressForHttp						@"http://imapp.suning.com"
#define kHostAddressForHttps					@"https://imapp.suning.com"

#elif kDevTest

#define kHostAddressForHttp						@"http://imapp.suning.com"

#define kHostAddressForHttps					@"https://imapp.suning.com"

#elif kReleaseH


#define kHostAddressForHttp					    @"http://imapp.suning.com"
#define kHostAddressForHttps					@"https://imapp.suning.com"

#else 

#define kHostAddressForHttp					    @"http://imapp.suning.com"
#define kHostAddressForHttps					@"https://imapp.suning.com"

#endif


//===============================================================================
#pragma mark -  Xmpp Resource Name
#pragma mark    Xmpp 绑定资源的name

#define XmppResource                            @"ios_mobiel"

//===============================================================================

#pragma mark -  Default Http Timeout Seconds
#pragma mark    默认http访问超时时间
#define kHttpTimeoutSeconds						180

//===============================================================================
#pragma mark -  Resource Cache Path
#pragma mark    资源缓存路径
#define	kCachePath								@"resource"

//===============================================================================
#pragma mark -  PreferenceSetting Path
#pragma mark    偏好设置文件
#define kPreferenceSetting						@"PreferenceSetting.plist"

#pragma mark -
#pragma mark 系统信息收集
#define kClientUseInfo                          @"phone.gif"
#define kUserRegisterInfo                       @"phoneRegister.gif"
#define kUserOrderNumInfo                       @"phoneOrder.gif"