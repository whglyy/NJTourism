//
//  BMKGeneralDelegate.h
//  FatFist
//
//  Created by lyywhg on 13-5-24.
//
//

#import <Foundation/Foundation.h>

///通知Delegate
@protocol BMKGeneralDelegate<NSObject>
@optional
/**
*返回网络错误
*@param iError 错误号
*/
- (void)onGetNetworkState:(int)iError;

/**
*返回授权验证错误
*@param iError 错误号 : BMKErrorPermissionCheckFailure 验证失败
*/
- (void)onGetPermissionState:(int)iError;
@end
