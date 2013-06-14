//
//  CommonViewController.h
//  FatFist
//
//  Copyright 2011 FatFish. All rights reserved.
//
//

#import <Foundation/Foundation.h>
#import "UIView+ActivityIndicator.h"
#import "AppDelegate.h"
#import "BBTipView.h"
#import "BBAlertView.h"
#import "NSTimerHelper.h"
#import "TPKeyboardAvoidingTableView.h"

@interface CommonViewController : UIViewController<UITableViewDelegate, UITableViewDataSource, BBAlertViewDelegate>
{
    
	UITableView             *_tableView;
    
    UITableView             *_groupTableView;
        
    NSTimerHelper           *_dlgTimer;                                 
    
    NSString                *_pageInTime;
}

@property (nonatomic, retain) UITableView       *tableView;

@property (nonatomic, retain) UITableView       *groupTableView;

@property (nonatomic, retain) TPKeyboardAvoidingTableView *tpTableView;

@property (nonatomic, retain) NSTimerHelper     *dlgTimer; 

@property (nonatomic, retain) NSString          *pageInTime;

+ (id)controller;

/*!
 @method
 @abstract      包含［加载中⋯⋯］的提示语，并且包含加载动态进度圈的弹出框
 @discussion    继承自commonViewController 的类直接调用
 */
- (void)displayOverFlowActivityView;

/*!
 @method
 @abstract      移除包含［加载中⋯⋯］的提示语，并且包含加载动态进度圈的弹出框
 @discussion    继承自commonViewController 的类直接调用
 */
- (void)removeOverFlowActivityView;

/*!
 @method
 @abstract      包含［加载中⋯⋯］的提示语，并且包含加载动态进度圈的弹出框
 @discussion    继承自commonViewController 的类直接调用
 @param         indiTitle  提示信息
 */
- (void)displayOverFlowActivityView:(NSString *)indiTitle;


/*!
 @method
 @abstract      包含［加载中⋯⋯］的提示语，并且包含加载动态进度圈的弹出框
 @discussion    继承自commonViewController 的类直接调用
 @param         indiTitle  提示信息
 @param         time       自加载框最长自动消失时间
 */
- (void)displayOverFlowActivityView:(NSString *)indiTitle maxShowTime:(CGFloat)time;

/*!
 @method
 @abstract      包含［加载中⋯⋯］的提示语，并且包含加载动态进度圈的弹出框
 @discussion    继承自commonViewController 的类直接调用
 @param         indiTitle  提示信息
 @param         y          自定义的位置
 */
- (void)displayOverFlowActivityView:(NSString *)indiTitle yOffset:(CGFloat)y;

/*!
 @method
 @abstract 仅文字提示的黑色半透明信息框
 @discussion 继承自commonViewController 的类直接调用
 @param indiTitle  提示信息 
 */
- (void)presentSheet:(NSString *)indiTitle;
/*!
 @method
 @abstract      包含［对号］logo以及文字提示的黑色半透明信息框，用于任务成功提示
 @discussion    继承自commonViewController 的类直接调用，实际弹出BBTipView的定制弹出框
 @param         indiTitle  提示信息
 */
- (void)presentSuccessLogoSheet:(NSString*)indiTitle;
/*!
 @method
 @abstract      包含［叉号］logo以及文字提示的黑色半透明信息框，用语任务失败提示
 @discussion    继承自commonViewController 的类直接调用，实际弹出BBTipView的定制弹出框
 @param         indiTitle  提示信息
 */
- (void)presentFailLogoSheet:(NSString*)indiTitle;
/*!
 @method
 @abstract      包含一个确认按钮的以及提示信息的弹出框，用于需要用户交互的提示信息。
 @discussion    继承自commonViewController 的类直接调用，实际弹出BBAlertView的定制弹出框
 @param         indiTitle  提示信息
 */
- (void)presentCustomDlg:(NSString *)indiTitle;

/*!
 @method
 @abstract      仅文字提示的黑色半透明信息框
 @discussion    继承自commonViewController 的类直接调用
 @param         indiTitle  提示信息
 @param         y          自定义的位置
 */
- (void)presentSheet:(NSString*)indiTitle posY:(CGFloat)y;

@end