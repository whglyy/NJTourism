//
//  BBAlertView.h
//  FatFist
//
//  Copyright 2011 FatFish. All rights reserved.
//
//
#import <UIKit/UIKit.h>

@interface NSObject (BBAlert)
- (void)alertCustomDlg:(NSString *)message;
- (void)dismissAllCustomAlerts;
@end
/*!
 @enum      BBAlertViewStyle
 @abstract  alertView的style，通过style来确定UI, 现在只有两种UI
 */
typedef enum {
    BBAlertViewStyleDefault,        //苏宁ebuy里面用
    BBAlertViewStyle1,              //图书里面用的
    BBAlertViewStyleCustomView      //可放入自定义的view
}BBAlertViewStyle;
#if NS_BLOCKS_AVAILABLE
typedef void (^BBBasicBlock)(void);
#endif
@protocol BBAlertViewDelegate;
@interface BBAlertView : UIView
{
@private
    UILabel   *_titleLabel;
    UILabel   *_bodyTextLabel;
    UITextView *_bodyTextView;
    UIView    *_customView;
    UIView    *_contentView;
    UIView    *_backgroundView;
    BOOL    _visible;
    BOOL    _dimBackground;
    UIInterfaceOrientation _orientation;
    BBAlertViewStyle   _style;
#if NS_BLOCKS_AVAILABLE
    BBBasicBlock    _cancelBlock;
    BBBasicBlock    _confirmBlock;
#endif
}
///BOOL类型
/// 是否正在显示
@property (nonatomic, readonly, getter=isVisible) BOOL visible;
/*!
 背景是否有渐变背景, 默认YES
 */
@property (nonatomic, assign) BOOL dimBackground;       //是否渐变背景，默认YES
/**
 * 背景视图，覆盖全屏的，
 *  默认nil
 */
@property (nonatomic, retain) UIView *backgroundView;   //背景view, 可无
@property (nonatomic, assign) BBAlertViewStyle style;
/**
 在点击确认后,是否需要dismiss,contentAlignment,BBAlertViewDelegate
 默认YES
 */
@property (nonatomic, assign) BOOL shouldDismissAfterConfirm;
/*!
 文本对齐方式
 */
@property (nonatomic, assign) UITextAlignment contentAlignment;
@property (nonatomic, weak) id<BBAlertViewDelegate> delegate;
/*!
 @abstract      点击取消按钮的回调
 @discussion    如果你不想用代理的方式来进行回调，可使用该方法
 http://www.FatFist.com
 ftp://192.168.10.19
 mailto:1043048769@qq.com
 file://index.html
 @param         block  点击取消后执行的程序块
 @see           content
 */
- (void)setCancelBlock:(BBBasicBlock)block;
/*!
 @abstract      点击确定按钮的回调
 
    BBAlertView *alert = [[BBAlertView alloc] initWithTitle:L(@"system-info")
    message:L(@"Cod_Address_Throw_NULL_Error_Need_Reset") delegate:nil cancelButtonTitle:L(@"Cancel") otherButtonTitles:L(@"Ok")];
    [alert setConfirmBlock:^{
    AddressEditViewController *addressEditVC =
    [[AddressEditViewController alloc] initWithBaseAddress:rowAddress];
    addressEditVC.delegate = self;
    addressEditVC.isFromEasilyBuy = self.isFromEasilyBuy;
    [self.navigationController pushViewController:addressEditVC animated:YES];
    TT_RELEASE_SAFELY(addressEditVC);
    }];
 
 @discussion    如果你不想用代理的方式来进行回调，可使用该方法
 @param         block  点击确定后执行的程序块
 */
- (void)setConfirmBlock:(BBBasicBlock)block;
/*!
 @abstract      初始话方法，默认的style：BBAlertViewStyleDefault
 
 @param         title  标题
 @param         message  内容
 @param         delegate  代理
 @param         cancelButtonTitle  取消按钮title
 @param         otherButtonTitle  其他按钮，如确定
 @result        BBAlertView的对象
 */
- (id)initWithTitle:(NSString *)title
            message:(NSString *)message
           delegate:(id <BBAlertViewDelegate>)delegate
  cancelButtonTitle:(NSString *)cancelButtonTitle
  otherButtonTitles:(NSString *)otherButtonTitle;
/*!
 @abstract      更多信息请查看[此页]((http://gentlebytes.com)，
 或者查看[此类](UIView(TTCategory))或者查看[此方法]([BBTipView dismiss:])
 */
- (id)initWithContentView:(UIView *)contentView;
/*!
 @abstract      初始话方法，默认的style：BBAlertViewStyleDefault
 @param         style  UI类型
 @param         title  标题
 @param         message  内容
 @param         customView 自定义的view,位于内容和button的中间（不常用），一般设为nil
 @param         delegate  代理
 @param         cancelButtonTitle  取消按钮title
 @param         otherButtonTitle  其他按钮，如确定
 @result        BBAlertView的对象
 */
- (id)initWithStyle:(BBAlertViewStyle)style
              Title:(NSString *)title
            message:(NSString *)message
         customView:(UIView *)customView
           delegate:(id <BBAlertViewDelegate>)delegate
  cancelButtonTitle:(NSString *)cancelButtonTitle
  otherButtonTitles:(NSString *)otherButtonTitle;
/*!
 @abstract      弹出
 类：SNPopoverCommonViewController 、 扩展类：UIView(TTCategory) 和 协议：ActivitySwitchServiceDelegate
 */
- (void)show;
/*!
 连接到其他类的方法[BBTipView dismiss:] 或属性[BBTipView dimBackground]
 */
- (void)dismiss;
@end
/*********************************************************************/
@protocol BBAlertViewDelegate <NSObject>
@optional
- (void)alertView:(BBAlertView *)alertView willDismissWithButtonIndex:(NSInteger)buttonIndex; // before animation and hiding view
- (void)alertView:(BBAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex;
- (void)didRotationToInterfaceOrientation:(BOOL)Landscape view:(UIView*)view alertView:(BBAlertView *)aletView;
@end
