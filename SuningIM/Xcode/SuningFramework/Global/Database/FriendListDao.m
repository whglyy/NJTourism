//
//  FriendListDao.m
//  FatFist
//
//  Created by lyywhg on 13-5-29.
//
//

#import "FriendListDao.h"

@implementation FriendListDao

- (id)OperateFriendInfoDB:(id)friendInfo operateIndex:(NSInteger)index
{
    NSMutableDictionary *friendInfoDic = [[NSMutableDictionary alloc] init];
    NSMutableArray *friendInfoArray = [[NSMutableArray alloc] init];
    NSNumber *isSuccess = [NSNumber numberWithBool:NO];
    
    switch (index)
    {
        case AddFriendActionType:
            isSuccess = [NSNumber numberWithBool:[self insertFriendInfo2FriendDB:friendInfo]];
            return isSuccess;
        case ChangeFriendNickNameActionType:
            isSuccess = [NSNumber numberWithBool:[self updateLastUnreadMessageInfoFromFriendDB:friendInfo]];
            return isSuccess;
        case DeleteFriendActionType:
            isSuccess = [NSNumber numberWithBool:[self deleteFriendInfoFromFriendDB:friendInfo]];
            return isSuccess;
        case IsFriendInfoExistedType:
            isSuccess = [NSNumber numberWithBool:[self isExistOneFriendInfoInFriendDB:friendInfo]];
            return isSuccess;
        case UpdateFriendIsRecentChattedType:
            isSuccess = [NSNumber numberWithBool:[self updateIsRecentChattedFromFriendDB:friendInfo]];
            return isSuccess;
        case GetFriendsListActionType:
            [friendInfoDic addEntriesFromDictionary:[self getFriendInfoListFromFriendDB:friendInfo]];
            return friendInfoDic;
        case GetAllChatFriendInfoActionType:
            [friendInfoArray addObjectsFromArray:[self getAllChatFriendInfoListFromFriendDB:friendInfo]];
            return friendInfoArray;
        case GetOneFriendInfoActionType:
            [friendInfoArray addObjectsFromArray:[self readOneFriendInfoFromFriendDB:friendInfo]];
            return friendInfoArray;
        case GetNewChatFriendInfoActionType:
            [friendInfoArray addObjectsFromArray:
             [self getNewChatFriendInfoListFromFriendDB:friendInfo]];
            return friendInfoArray;
        default:
            break;
    }
    return isSuccess;
}

#pragma mark-
#pragma mark Detail FriendInfo Database Method
- (BOOL)insertFriendInfo2FriendDB:(FriendInfoDTO *)friendInfo
{
    if (friendInfo == nil)
    {
        return NO;
    }

    __block BOOL isSuccess = NO;
    [self.databaseQueue inDatabase:^(FMDatabase *db){
        NSString *sql = [NSString stringWithFormat:@"insert into CHATLIST_TABLE(USERID, FRIENDID, FRIENDGROUPID, FRIENDNAME, FRIENDNAMECHARACTER, FRIENDSTATUS, FRIENDSIGNATURE, FRIENDHEADERIMAGE, TOTALMESSAGECOUNT, READEDMESSAGECOUNT, ISRECENTCHATTED, LASTUNREADMESSAGE, LASTMESSAGETIME)values(?,?,?,?,?,?,?,?,?,?,?,?,?);"];
        DLog(@"add ol IM sql is %@", sql);
        isSuccess = [db executeUpdate:sql,
                     friendInfo.userId,
                     friendInfo.friendId,
                     friendInfo.friendGroupName,
                     friendInfo.friendUserName,
                     friendInfo.friendNameCharacter,
                     [NSNumber numberWithInt:1],
                     friendInfo.friendSignNote,
                     friendInfo.friendHeaderImage,
                     [NSNumber numberWithInteger:friendInfo.totalMessageCount],
                     [NSNumber numberWithInteger:friendInfo.readedMessageCount],
                     [NSNumber numberWithInteger:friendInfo.isRecentChatted],
                     friendInfo.lastUnreadMessage,
                     friendInfo.lastMessageTime,
                     @"~/user/cache"
                     ];
        DLog(@"error:%@",[db  lastErrorMessage]);
        DLog(@"isSuccess:%d",isSuccess);
    }];
    return isSuccess;
}

- (BOOL)deleteFriendInfoFromFriendDB:(FriendInfoDTO *)friendInfo
{
    if (friendInfo == nil)
    {
        return NO;
    }
    
    __block BOOL isSuccess = NO;
    [self.databaseQueue inDatabase:^(FMDatabase *db){
        NSString *sql = [NSString stringWithFormat:@"delete from CHATLIST_TABLE where USERID = ? and FRIENDID = ?;"];
        DLog(@"add ol book sql is %@", sql);
        isSuccess = [db executeUpdate:sql,
                     friendInfo.userId,
                     friendInfo.friendId
                    ];
    }];
    return isSuccess;

}
//更新最后一条未读记录的内容和时间，以及总消息数
- (BOOL)updateLastUnreadMessageInfoFromFriendDB:(FriendInfoDTO *)friendInfo
{
    if (friendInfo.userId == nil)
    {
        return NO;
    }
    __block BOOL isSuccess = NO;
    [self.databaseQueue inDatabase:^(FMDatabase *db){
        NSString *sql = @"update CHATLIST_TABLE SET FRIENDGROUPID = ?, FRIENDNAME = ?, FRIENDNAMECHARACTER = ?, FRIENDSIGNATURE = ?, FRIENDHEADERIMAGE = ?, TOTALMESSAGECOUNT = ?, READEDMESSAGECOUNT = ?, ISRECENTCHATTED = ?, LASTUNREADMESSAGE = ?, LASTMESSAGETIME = ? where FRIENDID = ? and USERID = ?";
                
        isSuccess = [db executeUpdate:sql,
                     friendInfo.friendGroupName,
                     friendInfo.friendUserName,
                     friendInfo.friendNameCharacter,
                     friendInfo.friendSignNote,
                     friendInfo.friendHeaderImage,
                     [NSNumber numberWithInteger:friendInfo.totalMessageCount],
                     [NSNumber numberWithInteger:friendInfo.readedMessageCount],
                     [NSNumber numberWithInteger:friendInfo.isRecentChatted],
                     friendInfo.lastUnreadMessage,
                     friendInfo.lastMessageTime,
                     friendInfo.friendId,
                     friendInfo.userId];
        DLog(@"msg_lyywhg:%@", [db lastError]);
    }];
    return isSuccess;
}
- (BOOL)updateIsRecentChattedFromFriendDB:(FriendInfoDTO *)friendInfo
{
    if (friendInfo.userId == nil)
    {
        return NO;
    }
    __block BOOL isSuccess = NO;
    [self.databaseQueue inDatabase:^(FMDatabase *db){
        NSString *sql = @"update CHATLIST_TABLE SET ISRECENTCHATTED = ? where FRIENDID = ? and USERID = ?";
        
        isSuccess = [db executeUpdate:sql,
                     [NSNumber numberWithInteger:friendInfo.isRecentChatted],
                     friendInfo.friendId,
                     friendInfo.userId];
    }];
    return isSuccess;
}
- (BOOL)isExistOneFriendInfoInFriendDB:(FriendInfoDTO *)tmpFriendInfo
{
    if (tmpFriendInfo.friendId == nil)
    {
        return nil;
    }
    __block BOOL *isSuccess = NO;
    
    [self.databaseQueue inDatabase:^(FMDatabase *db){
        NSString *sql = [NSString stringWithFormat:@"select * from CHATLIST_TABLE where  FRIENDID = ? and USERID = ;"];
        DLog(@"sql is %@", sql);
        
        isSuccess = [db executeUpdate:sql,
                     tmpFriendInfo.friendId,
                     tmpFriendInfo.userId];
        
        DLog(@"msg_lyywhg:%@", [db lastError]);
    }];
    return isSuccess;
}
- (NSMutableArray *)readOneFriendInfoFromFriendDB:(FriendInfoDTO *)tmpFriendInfo
{
    if (tmpFriendInfo.friendId == nil)
    {
        return nil;
    }
    
    __block NSMutableArray *array = nil;
    
    [self.databaseQueue inDatabase:^(FMDatabase *db){
        NSString *sql = [NSString stringWithFormat:@"select * from CHATLIST_TABLE where  FRIENDID = ?;"];
        DLog(@"sql is %@", sql);
        
        FMResultSet *rs = [db executeQuery:sql, tmpFriendInfo.friendId];
        if(!rs)
        {
            [rs close];
            return;
        }
        array = [[NSMutableArray alloc] init];
        while ([rs next])
        {
            FriendInfoDTO *friendInfo = [[FriendInfoDTO alloc] init];
            
            friendInfo.userId = [rs stringForColumn:@"USERID"];
            friendInfo.friendId = [rs stringForColumn:@"FRIENDID"];
            friendInfo.friendGroupName = [rs stringForColumn:@"FRIENDGROUPID"];
            friendInfo.friendUserName = [rs stringForColumn:@"FRIENDNAME"];
            friendInfo.friendSignNote = [rs stringForColumn:@"FRIENDSIGNATURE"];
            friendInfo.friendNameCharacter = [rs stringForColumn:@"FRIENDNAMECHARACTER"];
            friendInfo.totalMessageCount = 0;//[rs intForColumn:@"TOTALMESSAGECOUNT"];
            friendInfo.readedMessageCount = 0;//[rs intForColumn:@"READEDMESSAGECOUNT"];
            friendInfo.isRecentChatted = [rs intForColumn:@"ISRECENTCHATTED"];
            friendInfo.lastUnreadMessage = [rs stringForColumn:@"LASTUNREADMESSAGE"];
            friendInfo.lastMessageTime = [rs stringForColumn:@"LASTMESSAGETIME"];
            friendInfo.friendShowName = @"null";
            friendInfo.friendHeaderImage = @"null";
            friendInfo.friendNickName = @"null";
            friendInfo.friendUserEmail = @"null";
            friendInfo.friendBirthDay = @"null";
            friendInfo.friendHomeCity = @"null";
            friendInfo.friendConstellation = @"null";
            
            [array addObject:friendInfo];
        }
        
        DLog(@"msg_lyywhg:%@", [db lastError]);
        [rs close];
    }];
    return array;
}
- (NSMutableDictionary *)getFriendInfoListFromFriendDB:(FriendInfoDTO *)friendInfo
{
    if (friendInfo.userId == nil)
    {
        return nil;
    }
    
    __block NSMutableDictionary *dictionary = nil;
    
    [self.databaseQueue inDatabase:^(FMDatabase *db){
        NSString *sql = [NSString stringWithFormat:@"select * from CHATLIST_TABLE where  USERID = ? order by LASTMESSAGETIME desc;"];
        DLog(@"sql is %@", sql);
        
        FMResultSet *rs = [db executeQuery:sql, friendInfo.userId];
        if(!rs)
        {
            [rs close];
            return;
        }
        dictionary = [[NSMutableDictionary alloc] init];
        while ([rs next])
        {
            @autoreleasepool
            {
                FriendInfoDTO *tmpFriendInfo = [[FriendInfoDTO alloc] init];
                tmpFriendInfo.userId = [rs stringForColumn:@"USERID"];
                tmpFriendInfo.friendId = [rs stringForColumn:@"FRIENDID"];
                tmpFriendInfo.friendGroupName = [rs stringForColumn:@"FRIENDGROUPID"];
                tmpFriendInfo.friendUserName = [rs stringForColumn:@"FRIENDNAME"];
                tmpFriendInfo.friendSignNote = [rs stringForColumn:@"FRIENDSIGNATURE"];
                tmpFriendInfo.totalMessageCount = 0;//[rs intForColumn:@"TOTALMESSAGECOUNT"];
                tmpFriendInfo.readedMessageCount = 0;//[rs intForColumn:@"UNREADMESSAGECOUNT"];
                tmpFriendInfo.friendNameCharacter = [rs stringForColumn:@"FRIENDNAMECHARACTER"];
                tmpFriendInfo.isRecentChatted = [rs intForColumn:@"ISRECENTCHATTED"];
                tmpFriendInfo.lastUnreadMessage = [rs stringForColumn:@"LASTUNREADMESSAGE"];
                tmpFriendInfo.lastMessageTime = [rs stringForColumn:@"LASTMESSAGETIME"];
                tmpFriendInfo.friendShowName = @"null";
                tmpFriendInfo.friendHeaderImage = [rs stringForColumn:@"FRIENDHEADERIMAGE"];
                tmpFriendInfo.friendNickName = @"null";
                tmpFriendInfo.friendUserEmail = @"null";
                tmpFriendInfo.friendBirthDay = @"null";
                tmpFriendInfo.friendHomeCity = @"null";
                tmpFriendInfo.friendConstellation = @"null";
                
                if ([dictionary objectForKey:tmpFriendInfo.friendNameCharacter] != nil)
                {
                    NSMutableArray *tmpArray = [[NSMutableArray alloc] init];
                    if ([[dictionary objectForKey:tmpFriendInfo.friendNameCharacter] isKindOfClass:[FriendInfoDTO class]])
                    {
                        [tmpArray addObject:[dictionary objectForKey:tmpFriendInfo.friendNameCharacter]];
                    }
                    else if([[dictionary objectForKey:tmpFriendInfo.friendNameCharacter] isKindOfClass:[NSMutableArray class]])
                    {
                        [tmpArray addObjectsFromArray:[dictionary objectForKey:tmpFriendInfo.friendNameCharacter]];
                    }
                    else if([[dictionary objectForKey:tmpFriendInfo.friendNameCharacter] isKindOfClass:[NSArray class]])
                    {
                        [tmpArray addObjectsFromArray:[dictionary objectForKey:tmpFriendInfo.friendNameCharacter]];
                    }
                    [tmpArray addObject:tmpFriendInfo];
                    [dictionary setValue:tmpArray forKey:tmpFriendInfo.friendNameCharacter];
                }
                else
                {
                    [dictionary setValue:tmpFriendInfo forKey:tmpFriendInfo.friendNameCharacter];
                }
            }
        }
        DLog(@"msg_lyywhg:%@", [db lastError]);
        [rs close];
    }];
    return dictionary;
}
- (NSMutableArray *)getNewChatFriendInfoListFromFriendDB:(FriendInfoDTO *)friendInfo
{
    if (friendInfo.userId == nil)
    {
        return nil;
    }
    
    __block NSMutableArray *array = nil;
    
    [self.databaseQueue inDatabase:^(FMDatabase *db){
        NSString *sql = [NSString stringWithFormat:@"select * from CHATLIST_TABLE where  USERID = ? and ISRECENTCHATTED = ? order by LASTMESSAGETIME > ? and LASTMESSAGETIME desc;"];
        DLog(@"sql is %@", sql);
        
        FMResultSet *rs = [db executeQuery:sql, friendInfo.userId, [NSNumber numberWithInteger:RecentAccessInType], friendInfo.lastMessageTime];
        if(!rs)
        {
            [rs close];
            return;
        }
        array = [[NSMutableArray alloc] init];
        while ([rs next])
        {
            @autoreleasepool
            {
                FriendInfoDTO *tmpFriendInfo = [[FriendInfoDTO alloc] init];
                tmpFriendInfo.userId = [rs stringForColumn:@"USERID"];
                tmpFriendInfo.friendId = [rs stringForColumn:@"FRIENDID"];
                tmpFriendInfo.friendUserName = [rs stringForColumn:@"FRIENDNAME"];
                tmpFriendInfo.friendSignNote = [rs stringForColumn:@"FRIENDSIGNATURE"];
                tmpFriendInfo.totalMessageCount = 0;//[rs intForColumn:@"TOTALMESSAGECOUNT"];
                tmpFriendInfo.readedMessageCount = 0;//[rs intForColumn:@"UNREADMESSAGECOUNT"];
                tmpFriendInfo.isRecentChatted = [rs intForColumn:@"ISRECENTCHATTED"];
                tmpFriendInfo.lastUnreadMessage = [rs stringForColumn:@"LASTUNREADMESSAGE"];
                tmpFriendInfo.friendHeaderImage = [rs stringForColumn:@"FRIENDHEADERIMAGE"];
                [array addObject:tmpFriendInfo];
            }
        }
        DLog(@"msg_lyywhg:%@", [db lastError]);
        [rs close];
    }];
    return array;
}
- (NSMutableArray *)getAllChatFriendInfoListFromFriendDB:(FriendInfoDTO *)friendInfo
{
    if (friendInfo.userId == nil)
    {
        return nil;
    }
    __block NSMutableArray *array = nil;
    
    [self.databaseQueue inDatabase:^(FMDatabase *db){
        NSString *sql = [NSString stringWithFormat:@"select * from CHATLIST_TABLE where  USERID = ? and ISRECENTCHATTED = ? order by LASTMESSAGETIME desc;"];
        DLog(@"sql is %@", sql);
        
        FMResultSet *rs = [db executeQuery:sql, friendInfo.userId, [NSNumber numberWithInt:RecentAccessInType]];
        if(!rs)
        {
            [rs close];
            return;
        }
        array = [[NSMutableArray alloc] init];
        while ([rs next])
        {
            @autoreleasepool
            {
                FriendInfoDTO *tmpFriendInfo = [[FriendInfoDTO alloc] init];
                tmpFriendInfo.userId = [rs stringForColumn:@"USERID"];
                tmpFriendInfo.friendId = [rs stringForColumn:@"FRIENDID"];
                tmpFriendInfo.friendUserName = [rs stringForColumn:@"FRIENDNAME"];
                tmpFriendInfo.friendSignNote = [rs stringForColumn:@"FRIENDSIGNATURE"];
                tmpFriendInfo.totalMessageCount = 0;//[rs intForColumn:@"TOTALMESSAGECOUNT"];
                tmpFriendInfo.readedMessageCount = 0;//[rs intForColumn:@"UNREADMESSAGECOUNT"];
                tmpFriendInfo.isRecentChatted = [rs intForColumn:@"ISRECENTCHATTED"];
                tmpFriendInfo.lastUnreadMessage = [rs stringForColumn:@"LASTUNREADMESSAGE"];
                tmpFriendInfo.friendHeaderImage = [rs stringForColumn:@"FRIENDHEADERIMAGE"];
                [array addObject:tmpFriendInfo];
            }
        }
        DLog(@"msg_lyywhg:%@", [db lastError]);
        [rs close];
    }];
    return array;
}
@end
