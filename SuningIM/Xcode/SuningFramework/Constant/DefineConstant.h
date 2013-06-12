/**
 DefineConstant.h
 Created by liukun.
 Modified by shasha on 13-4-2
 Copyright (c) 2013年 suning. All rights reserved.
 */

#ifndef DEFINE_CONSTANT_H
#define DEFINE_CONSTANT_H  1

#pragma mark - Local Exchange functions
#pragma mark   本地转化
/**本地化转换*/
#define L(key) \
[[NSBundle mainBundle] localizedStringForKey:(key) value:@"" table:nil]


#pragma mark - Coordinate Functions
#pragma mark   坐标相关

#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
#define STATUSBAR_HEIGHT [[UIApplication sharedApplication] statusBarFrame].size.height

#define NAVIGATION_TITLEVIEW_WIDTH				    140.0f
#define NAVIGATION_TITLEVIEW_HEIGHT				    30.0f
#define NAVIGATION_TITLEVIEW_CurXLoc				90.0f
#define NAVIGATION_TITLEVIEW_CurYLoc				7.0f
#define UINAVIGATIONBAR_HEIGHT                      44.0f
#define UITABBAR_HEIGHT                             49.0f
#define TOP_BUTTOM_HEIGHT                      50.0f
#define BOTTOM_VIEW_HEIGHT                     45.0f             

#define STATUS_BAR_HEIGHT                                  20.0f
#define IPHONE5_FIX                                 88.0f
//登陆相关信息
#define kLoginStatusMessageStartHttp				@"正在发送登录请求"
#define kLoginStatusMessageRequireUserName			@"请输入用户名"
#define kLoginStatusMessageRequirePassword			@"请输入密码"

#pragma mark - color functions
#pragma mark   颜色
#define RGBCOLOR(r,g,b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]
#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]

#define HSVCOLOR(h,s,v) [UIColor colorWithHue:h saturation:s value:v alpha:1]
#define HSVACOLOR(h,s,v,a) [UIColor colorWithHue:h saturation:s value:v alpha:a]

/// rgb颜色转换（16进制->10进制）
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#pragma mark - degrees/radian functions
#pragma mark   角度弧度转化
#define degreesToRadian(x) (M_PI * (x) / 180.0)
#define radianToDegrees(radian) (radian*180.0)/(M_PI)

#pragma mark - Block functions
#pragma mark   block相关
///block 声明
#ifdef NS_BLOCKS_AVAILABLE
typedef void (^SNBasicBlock)(void);
typedef void (^SNOperationCallBackBlock)(BOOL isSuccess, NSString *errorMsg);
typedef void (^SNCallBackBlockWithResult)(BOOL isSuccess, NSString *errorMsg,id result);
typedef void (^SNArrayBlock)(NSArray *list);
#endif

#pragma mark - Thread functions
#pragma mark   GCD线程相关
///线程执行方法 GCD
#define PERFORMSEL_BACK(block) dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), block)
#define PERFORMSEL_MAIN(block) dispatch_async(dispatch_get_main_queue(),block)

#pragma mark - Empty judge functions
#pragma mark   为空判断相关
///是否为空或是[NSNull null]
#define NotNilAndNull(_ref)  (((_ref) != nil) && (![(_ref) isEqual:[NSNull null]]))
#define IsNilOrNull(_ref)   (((_ref) == nil) || ([(_ref) isEqual:[NSNull null]]))
///字符串是否为空
#define IsStrEmpty(_ref)    (((_ref) == nil) || ([(_ref) isEqual:[NSNull null]]) ||([(_ref)isEqualToString:@""]))
///数组是否为空
#define IsArrEmpty(_ref)    (((_ref) == nil) || ([(_ref) isEqual:[NSNull null]]) ||([(_ref) count] == 0))

#pragma mark -  DataTypes Generation functions
#pragma mark    类型数据生成相关
///便捷方式创建NSNumber类型
#undef	__INT
#define __INT( __x )			[NSNumber numberWithInt:(NSInteger)__x]

#undef	__UINT
#define __UINT( __x )			[NSNumber numberWithUnsignedInt:(NSUInteger)__x]

#undef	__FLOAT
#define	__FLOAT( __x )			[NSNumber numberWithFloat:(float)__x]

#undef	__DOUBLE
#define	__DOUBLE( __x )			[NSNumber numberWithDouble:(double)__x]

#define OC(str) [NSString stringWithCString:(str) encoding:NSUTF8StringEncoding]

#pragma mark -  SystemInfo functions
#pragma mark    


///系统版本判断
#define IOS6_OR_LATER	( [[[UIDevice currentDevice] systemVersion] compare:@"6.0"] != NSOrderedAscending )
#define IOS5_OR_LATER	( [[[UIDevice currentDevice] systemVersion] compare:@"5.0"] != NSOrderedAscending )
#define IOS4_OR_LATER	( [[[UIDevice currentDevice] systemVersion] compare:@"4.0"] != NSOrderedAscending )
#define IOS3_OR_LATER	( [[[UIDevice currentDevice] systemVersion] compare:@"3.0"] != NSOrderedAscending )

#define isIPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)


#pragma mark -  View Element functions
#pragma mark    页面元素相关
///弹出提示框
#define BBAlertMessage(__MSG) \
{\
BBAlertView *alert = [[BBAlertView alloc] initWithStyle:BBAlertViewStyleDefault\
Title:L(@"system-info")\
message:(__MSG)\
customView:nil\
delegate:nil\
cancelButtonTitle:L(@"Confirm")\
otherButtonTitles:nil];\
[alert show];\
}

#pragma mark - Safe Release functions
#pragma mark   释放相关
///安全释放




#define TT_RELEASE_SAFELY(__REF) 


///view安全释放
#define TTVIEW_RELEASE_SAFELY(__REF) \
{\
    if (nil != (__REF))\
    {\
        [__REF removeFromSuperview];\
        __REF = nil;\
    }\
}

///释放ASIHttpRequest专用
#define HTTP_RELEASE_SAFELY(__POINTER) \
{\
    if (nil != (__POINTER))\
    {\
        [__POINTER clearDelegatesAndCancel];\
    }\
}


///释放service专用
#define SERVICE_RELEASE_SAFELY(__REF) \
{\
    if ((__REF) != nil)\
    { \
        [__REF setDelegate:nil];\
        TT_RELEASE_SAFELY(__REF);\
    }\
}

///释放SNPopoverViewController
#define POP_RELEASE_SAFELY(__POINTER) \
{\
    if (nil != (__POINTER))\
    {\
        [__POINTER dismissPopoverAnimated:YES];\
    }\
}

//释放定时器
#define TT_INVALIDATE_TIMER(__TIMER) \
{\
    [__TIMER invalidate];\
    __TIMER = nil;\
}

///enums
typedef enum {
    
    MobileMode = 1,
    
    EmailMode
    
}RetrieveMode;


///分页页面分页信息

struct SNPageInfo {
    NSInteger currentPage;
    NSInteger totalPage;
    NSInteger pageSize;
};
typedef struct SNPageInfo SNPageInfo;

extern SNPageInfo SNPageInfoMake(NSInteger currentPage, NSInteger totalPage, NSInteger pageSize);

extern const SNPageInfo SNPageInfoZero;


#define EncodeDicKey(sel, dic, key) \
{\
    id temp = [dic objectForKey:key];\
    if (NotNilAndNull(temp)) {\
        [self performSelector:sel withObject:(temp)];\
    }\
}

extern NSString* EncodeObjectFromDic(NSDictionary *dic, NSString *key);


#endif
