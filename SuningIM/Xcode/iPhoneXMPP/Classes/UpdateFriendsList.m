//
//  UpdateFriendsList.m
//  SuningIM
//
//  Created by lyywhg on 13-5-24.
//
//

#import "UpdateFriendsList.h"

@implementation UpdateFriendsList

- (NSMutableArray *)updateFriendsList:(NSMutableArray *)friendsList methodMode:(NSInteger)methodMode
{
    int iTmp = methodMode;
    switch (iTmp)
    {
        case GetFriendsListActionType:
            return [self getFriendsList:friendsList];
            break;
        case AddFriendActionType:
            return [self addNewFriendToFriendsList:nil];
            break;
        case DeleteFriendActionType:
            return [self deleteFriendFromFriendsList:nil];
            break;
        case AddFriendNickNameActionType:
            return [self addNewFriendNickNameFromFriendsList:nil];
            break;
        case ChangeFriendNickNameActionType:
            return [self changeFriednNickNameFromFriendsList:nil];
            break;
        case DeleteFriendNickNameActionType:
            return [self deleteFriendNickNameFromFriendsList:nil];
            break;
        default:
            return nil;
            break;
    }
    return nil;
}
#pragma mark-
#pragma mark Method
- (NSMutableArray *)getFriendsList:(NSMutableArray *)friendsListFromService
{
    return nil;
}
- (NSMutableArray *)addNewFriendToFriendsList:(FriendInfoDTO *)newFriendInfo
{
    return nil;
}
- (NSMutableArray *)deleteFriendFromFriendsList:(FriendInfoDTO *)newFriendInfo
{
    return nil;
}
- (NSMutableArray *)addNewFriendNickNameFromFriendsList:(NSString *)newFriendNickName
{
    return nil;
}
- (NSMutableArray *)changeFriednNickNameFromFriendsList:(NSString *)newFriendNickName
{
    return nil;
}
- (NSMutableArray *)deleteFriendNickNameFromFriendsList:(NSString *)friendNickName
{
    return nil;
}
#pragma mark-
#pragma mark FriendList Sort
/*
 说明：
    服务器返回的联系人列表是无序的，必须排序
    以下函数是实现联系人排序操作
 */
- (NSMutableArray *)sortFriendsList
{
    return nil;
}
//在联系人信息发生变化后重新排序
- (NSMutableArray *)resortFriendsList
{
    return nil;
}
//获取到用户名首字母
- (NSString *)getFriendNameFristCharacter:(NSString *)friendName
{
    char firstChar = pinyinFirstLetter([friendName characterAtIndex:0]);
    return [NSString stringWithFormat:@"%c", firstChar];
}


@end
