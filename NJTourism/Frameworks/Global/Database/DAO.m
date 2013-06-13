//
//  DAO.m
//  FatFist
//
//  Created by lyywhg on 13-5-24.
//
//

#import "DAO.h"
#import "DatabaseManager.h"

@implementation DAO

@synthesize databaseQueue = _databaseQueue;

- (id)init{ 
    self = [super init];
    
	if(self)
    {
        
		self.databaseQueue = [DatabaseManager currentManager].databaseQueue;
	}
    
	return self;
}



- (FMDatabaseQueue *)databaseQueue
{
    if (![[DatabaseManager currentManager] isDatabaseOpened]) {
        [[DatabaseManager currentManager] openDataBase];
        self.databaseQueue = [DatabaseManager currentManager].databaseQueue;
        if (_databaseQueue)  [DAO createTablesNeeded];
    }
    return _databaseQueue;
}

+ (void)createTablesNeeded
{
    @autoreleasepool {
        FMDatabaseQueue *databaseQueue = [DatabaseManager currentManager].databaseQueue;
        
        [databaseQueue inDatabase:^(FMDatabase *database){
            
            //建表操作
            NSString *UploadTB_CREATE_Sql = @"CREATE TABLE If not EXISTS UPLOAD_TABLE (\
            TYPE integer NOT NULL DEFAULT '0',\
            THUMBNAIL_MD5 text,\
            ORIGINAL_MD5 text,\
            STATUS integer NOT NULL,\
            ALBUM_URL text NOT NULL,\
            UTI text NOT NULL,\
            FILENAME text NOT NULL,\
            FILESIZE integer NOT NULL,\
            LOCAL_THUMBNAIL_URL text,\
            LOCAL_ORIGINAL_URL text,\
            INFO text,\
            USERID text,\
            FOLDERID text,\
            FIELD_2 text,\
            CHANGETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,\
            PRIMARY KEY(ALBUM_URL,USERID)\
            )";
            //删除冗余信息操作
            
            NSString *DownloadTB_CREATE_Sql =
            @"CREATE TABLE If not EXISTS DOWNLOAD_TABLE (\
            TYPE text NOT NULL,\
            MD5 text,\
            STATUS integer NOT NULL,\
            FILENAME text NOT NULL,\
            FILESIZE text NOT NULL,\
            LOCAL_URL text,\
            INFO text,\
            USERID text,\
            FILEID text,\
            FIELD_2 text,\
            CHANGETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,\
            PRIMARY KEY(LOCAL_URL,USERID))";
            
            //会话列表数据库
            /*
             好友ID 好友组别 好友名 好友名首字母 好友状态 好友签名 好友头像 总消息数 已读消息总数 最后未读消息内容 最后消息时间 消息存储路径 
             */
            NSString *ChatListTB_CREATE_Sql =
            @"CREATE TABLE If not EXISTS CHATLIST_TABLE (\
            USERID text NOT NULL,\
            FRIENDID text NOT NULL,\
            FRIENDGROUPID text,\
            FRIENDNAME text,\
            FRIENDNAMECHARACTER text,\
            FRIENDSTATUS int,\
            FRIENDSIGNATURE text,\
            FRIENDHEADERIMAGE text,\
            TOTALMESSAGECOUNT int,\
            READEDMESSAGECOUNT int,\
            ISRECENTCHATTED int NOT NULL,\
            LASTUNREADMESSAGE text,\
            LASTMESSAGETIME text,\
            PRIMARY KEY(FRIENDID))";
            
            //聊天记录
            NSString *ChatRecordTB_CREATE_Sql =
            @"CREATE TABLE If not EXISTS CHATRECORDLIST_TABLE (\
            USERID text NOT NULL,\
            FRIENDID text NOT NULL,\
            FROMID text NOT NULL,\
            TOID text NOT NULL,\
            ISSENDOK int NOT NULL,\
            RECORDTIME text,\
            RECORDCONTENT text)";
            

            //执行sql
            BOOL isUploadTBCreateSuccess = [database executeUpdate:UploadTB_CREATE_Sql];
            if (!isUploadTBCreateSuccess)
            {
                DLog(@"errorCode==%d:%@",[database lastErrorCode],
                          [database lastErrorMessage]);
            }
            BOOL isDownloadTBCreateSuccess = [database executeUpdate:DownloadTB_CREATE_Sql];
            if (!isDownloadTBCreateSuccess)
            {
                DLog(@"errorCode==%d:%@",[database lastErrorCode],
                          [database lastErrorMessage]);
            }
            
            BOOL isChatListTBCreateSuccess = [database executeUpdate:ChatListTB_CREATE_Sql];
            if (!isChatListTBCreateSuccess)
            {
                DLog(@"errorCode==%d:%@",[database lastErrorCode],
                     [database lastErrorMessage]);
            }
            
            BOOL isChatRecordListTBCreateSuccess = [database executeUpdate:ChatRecordTB_CREATE_Sql];
            if (!isChatRecordListTBCreateSuccess)
            {
                DLog(@"errorCode==%d:%@",[database lastErrorCode],
                     [database lastErrorMessage]);
            }
        }];
    }
}

@end