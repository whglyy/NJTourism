//
//  UnreadMessageCount.h
//  SuningIM
//
//  Created by lyywhg on 13-5-27.
//
//

/*
 说明：显示未读信息情况
 例如：
 0条         不显示
 1到99条     显示x
 100条及以上  显示99+
 */

#import <Foundation/Foundation.h>

@interface UnreadMessageCount : NSObject

+ (NSString *)displayUnreadMessage:(NSInteger )unreadMessage;

@end
