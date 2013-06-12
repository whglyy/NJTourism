//
//  RegulateChatRecordsTime.h
//  SuningIM
//
//  Created by lyywhg on 13-5-24.
//
//

/*
 说明：
    聊天窗口时间显示格式规范，该操作最好放在页面willAppear中
 例如：
 1  当前时间是2013-05-24,16:33
    聊天时间为2013-05-24,14:22
    则显示格式为——14:22
 2  当前时间是2013-05-24,16:33
    聊天时间为2013-05-23,14:22
    则显示格式为——昨天,14:22
 3  当前时间是2013-05-24,16:33
    聊天时间为2013-03-22,14:22
    则显示格式为——03-22,14:22
 4  当前时间是2013-05-24,16:33
    聊天时间为2012-05-24,14:22
    则显示格式为——2012-05-24,14:22
 */

@interface RegulateChatRecordsTime : NSObject

- (NSString *)regulateChatRecordsTime:(NSDate *)chatRecordsTime;

@end
