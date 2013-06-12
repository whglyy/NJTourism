//
//  FriendInfoHeader.h
//  SuningIM
//
//  Created by lyywhg on 13-5-24.
//
//

#include "pinyin.h"
#import "FriendInfoDTO.h"
#import "ChatRecordDTO.h"

/*
 定义枚举：联系人列表变化操作枚举
 基本内容：
        获取到联系人列表（初次）
        增加新联系人
        删除指定联系人
 */
typedef enum _UpdateFriendListType
{
    GetFriendsListActionType              = 1,
    AddFriendActionType,
	DeleteFriendActionType,
    UpdateFriendIsRecentChattedType,
    GetOneFriendInfoActionType,
    GetNewChatFriendInfoActionType,
    GetAllChatFriendInfoActionType,
    IsFriendInfoExistedType,
    AddFriendNickNameActionType,
    ChangeFriendNickNameActionType,
    DeleteFriendNickNameActionType
}UpdateFriendListType;

/*
 定义枚举：聊天记录列表变化操作枚举
 基本内容：
 获取到聊天记录列表（初次）
 增加新聊天记录
 删除聊天记录
 */
typedef enum _UpdateChatRecordListType
{
    GetChatRecordsListActionType           = 1,
    AddChatRecordActionType,
	DeleteChatRecordsActionType,
    UpdateChatRecordSendOKType
}UpdateChatRecordListType;

/*
 定义枚举：聊天时间间隔判断
 基本内容：
        间隔一年
        间隔一月
        间隔一天
        间隔一小时
        间隔一分钟
        间隔210s
 */
typedef enum _TimeRegularType
{
    DifferentYearType                 = 1,
    DifferentMonthType,
    DifferentDayType,
    DifferentHourType,
    DifferentMinuteType,
    Interval210SType
}TimeRegularType;

/*
 定义枚举：会话列表界面变化情况
 基本内容：
        聊天记录变化
        联系人基本情况变化
        不变化
*/
typedef enum _ChatListChangeType
{
    AddNewChatRecord2ChatRecordListType        = 1,
    UpdateChatRecord2ChatRecordListType,
    DelOneChatRecordFromChatRecordListType,
    NoChangeOccuredType
}ChatListChangeType;

/*
 定义枚举：是否最近聊天
 基本内容：
        最近进入过聊天界面
        最近未进入过聊天界面
 */
typedef enum _RecentChatViewType
{
    RecentAccessInType              = 1,
    NoAccessInType                  = 0
}RecentChatViewType;