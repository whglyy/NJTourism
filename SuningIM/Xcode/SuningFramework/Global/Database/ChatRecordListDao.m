//
//  ChatRecordListDao.m
//  SuningIM
//
//  Created by lyywhg on 13-6-5.
//
//

#import "ChatRecordListDao.h"

@implementation ChatRecordListDao

- (id)OperateChatRecordDB:(ChatRecordDTO *)chatInfo operateIndex:(NSInteger)index
{
    NSMutableArray *chatRecordArray = [[NSMutableArray alloc] init];
    NSNumber *isSuccess = [NSNumber numberWithBool:NO];
    switch (index)
    {
        case GetChatRecordsListActionType:
            [chatRecordArray addObjectsFromArray:[self readChatRecordInfoFromChatRecordDB:chatInfo]];
            return chatRecordArray;
        case AddChatRecordActionType:
            isSuccess = [NSNumber numberWithBool:[self insertChatRecordInfo2ChatRecordDB:chatInfo]];
            return isSuccess;
        case DeleteChatRecordsActionType:
            isSuccess = [NSNumber numberWithBool:[self deleteChatRecordInfoFromChatRecordDB:chatInfo]];
            return isSuccess;
        case UpdateChatRecordSendOKType:
            isSuccess = [NSNumber numberWithBool:[self updateSendMessageOkOrNot2ChatRecordDB:chatInfo]];
            return isSuccess;
        default:
            break;
    }
    return isSuccess;
}
#pragma mark-
#pragma mark Detail ChatRecord Database Method
- (BOOL)insertChatRecordInfo2ChatRecordDB:(ChatRecordDTO *)chatInfo
{
    if (chatInfo == nil)
    {
        return NO;
    }
    
    __block BOOL isSuccess = NO;
    [self.databaseQueue inDatabase:^(FMDatabase *db){
        NSString *sql = [NSString stringWithFormat:@"insert into CHATRECORDLIST_TABLE(USERID, FRIENDID, FROMID, TOID, ISSENDOK, RECORDTIME, RECORDCONTENT)values(?,?,?,?,?,?,?);"];
        DLog(@"add ol IM sql is %@", sql);
        isSuccess = [db executeUpdate:sql,
                     chatInfo.userJID,
                     chatInfo.friendJID,
                     chatInfo.fromJID,
                     chatInfo.toJID,
                     [NSNumber numberWithInteger:chatInfo.isSendOk],
                     chatInfo.recordTime,
                     chatInfo.recordContent
                     ];
        DLog(@"error:%@",[db  lastErrorMessage]);
        DLog(@"isSuccess:%d",isSuccess);
    }];
    return isSuccess;
}
- (BOOL)deleteChatRecordInfoFromChatRecordDB:(ChatRecordDTO *)chatInfo
{
    if (chatInfo == nil)
    {
        return NO;
    }
    __block BOOL isSuccess = NO;
    [self.databaseQueue inDatabase:^(FMDatabase *db) {
        NSString *sql = [NSString stringWithFormat:@"delete from CHATRECORDLIST_TABLE where FRIENDID = ?"];
        isSuccess = [db executeUpdate:sql, chatInfo.friendJID];
    }];
    return isSuccess;
}
- (NSMutableArray *)readChatRecordInfoFromChatRecordDB:(ChatRecordDTO *)chatInfo
{
    if (chatInfo.friendJID == nil)
    {
        return nil;
    }
    
    __block NSMutableArray *array = nil;
    
    [self.databaseQueue inDatabase:^(FMDatabase *db){
        NSString *sql = [NSString stringWithFormat:@"select * from CHATRECORDLIST_TABLE where  FRIENDID = ? order by RECORDTIME asc;"];
        DLog(@"sql is %@", sql);
        
        FMResultSet *rs = [db executeQuery:sql, chatInfo.friendJID];
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
                ChatRecordDTO *tmpChatInfo = [[ChatRecordDTO alloc] init];
                tmpChatInfo.userJID = [rs stringForColumn:@"USERID"];
                tmpChatInfo.friendJID = [rs stringForColumn:@"FRIENDID"];
                tmpChatInfo.fromJID = [rs stringForColumn:@"FROMID"];
                tmpChatInfo.toJID = [rs stringForColumn:@"TOID"];
                tmpChatInfo.isSendOk = [rs stringForColumnIndex:@"ISSENDOK"];
                tmpChatInfo.recordTime = [rs stringForColumn:@"RECORDTIME"];
                tmpChatInfo.recordContent = [rs stringForColumn:@"RECORDCONTENT"];
                [array addObject:tmpChatInfo];
            }
        }
        DLog(@"msg_lyywhg:%@", [db lastError]);
        [rs close];
    }];
    return array;
}
- (BOOL)updateSendMessageOkOrNot2ChatRecordDB:(ChatRecordDTO *)chatInfo
{
    if (chatInfo == nil)
    {
        return NO;
    }

    __block BOOL isSuccess = NO;
    [self.databaseQueue inDatabase:^(FMDatabase *db){
        NSString *sql = @"update CHATRECORDLIST_TABLE SET ISSENDOK = ? where FRIENDID = ? and USERID = ? and RECORDTIME = ?";
        
        isSuccess = [db executeUpdate:sql,
                     [NSNumber numberWithInteger:chatInfo.isSendOk],
                     chatInfo.friendJID,
                     chatInfo.userJID,
                     chatInfo.recordTime];
    }];
    return isSuccess;
}
@end
