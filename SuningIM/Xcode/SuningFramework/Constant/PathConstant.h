//
//  PathConstant.h
//  reader4iphone
//
//  Created by shahsa on 13-3-18.
//  Copyright (c) 2012年 suning. All rights reserved.

#import "UserCenter.h"

/**数据库文件存取路径~/Library/Cache/Download/[userId] */
static NSString *_DatabaseDirectory;
/**Document路径*/
static NSString *_FileDocumentPath;
/**Download 下载文件存取路径  ~/Library/Cache/Download/[userid]*/
static NSString *_DownLoadPath;
/**Download 上传文件存取路径  ~/Library/Cache/Upload/[userid]*/
static NSString *_ThumbnailPath;
/**Download 上传文件存取路径  ~/Library/Cache/Thumbnail/[userid]*/
static NSString *_UpLoadPath;
/**appData  app配置以及数据文件  ~/Library/App*/
static NSString *_AppSurportPath;
/**本地聊天记录存储 ~/Library/Cache/Record/[userid]/[friendid]*/
static NSString *_FriendChatRecordsPath;


static inline NSString* DatabaseDirectory() {
	if(!_DatabaseDirectory) {
		NSString* cachesDirectory = [NSSearchPathForDirectoriesInDomains
                                     (NSCachesDirectory, NSUserDomainMask, YES)
                                     objectAtIndex:0];
        
		_DatabaseDirectory = [[[cachesDirectory stringByAppendingPathComponent:
                                [[NSProcessInfo processInfo] processName]]
                               stringByAppendingPathComponent:@"Database"]
                              copy];
        
        NSString *uid = [UserCenter defaultCenter].userInfoDTO.jid;
        if (IsStrEmpty(uid)) {
            uid = @"Visitor";
        }
        
        _DatabaseDirectory = [[_DatabaseDirectory stringByAppendingPathComponent:uid] copy];
        
        NSFileManager *fileManager = [NSFileManager defaultManager];
        BOOL isDir = YES;
        BOOL isExist = [fileManager fileExistsAtPath:_DatabaseDirectory
                                         isDirectory:&isDir];
        if (!isExist) 
        {
            [fileManager createDirectoryAtPath:_DatabaseDirectory
                   withIntermediateDirectories:YES
                                    attributes:nil
                                         error:NULL];
        }
	}
	return _DatabaseDirectory;
}

static inline NSString* FileDocumentPath() {
    if (!_FileDocumentPath) {
        
        NSString *documentPath = [NSSearchPathForDirectoriesInDomains
                                  (NSDocumentDirectory,NSUserDomainMask,YES)
                                  objectAtIndex:0];
        
        BOOL isDir = YES;
        NSFileManager *fileManager = [NSFileManager defaultManager];
        BOOL isExist = [fileManager fileExistsAtPath:documentPath
                                         isDirectory:&isDir];
        if (!isExist)
        {
            [[NSFileManager defaultManager] createDirectoryAtPath:documentPath
                                      withIntermediateDirectories:YES
                                                       attributes:nil
                                                            error:NULL];
        }
        _FileDocumentPath = [documentPath copy];
    }
    return _FileDocumentPath;
}

static inline NSString* DownLoadPath() {
    if (!_DownLoadPath) {
        
        NSString *downloadPath = [NSSearchPathForDirectoriesInDomains
                                  (NSCachesDirectory,NSUserDomainMask,YES)
                                  objectAtIndex:0];
                
        _DownLoadPath = [[downloadPath stringByAppendingPathComponent:@"Download"] copy];
        
        NSString *uid = [UserCenter defaultCenter].userInfoDTO.jid;
        if (IsStrEmpty(uid)) {
            uid = @"Visitor";
        }
        _DownLoadPath = [[_DownLoadPath stringByAppendingPathComponent:uid] copy];
        
        NSFileManager *fileManager = [NSFileManager defaultManager];
        BOOL isDir = YES;
        BOOL isExist = [fileManager fileExistsAtPath:_DownLoadPath
                                         isDirectory:&isDir];
        if (!isExist)
        {
            [[NSFileManager defaultManager] createDirectoryAtPath:_DownLoadPath
                                      withIntermediateDirectories:YES
                                                       attributes:nil
                                                            error:NULL];
        }
    }
    return _DownLoadPath;
}

static inline NSString* UpLoadPath() {
    if (!_UpLoadPath) {
        
        NSString *uploadPath = [NSSearchPathForDirectoriesInDomains
                                  (NSCachesDirectory,NSUserDomainMask,YES)
                                  objectAtIndex:0];
                
        _UpLoadPath = [[uploadPath stringByAppendingPathComponent:@"Upload"] copy];
        
        NSString *uid = [UserCenter defaultCenter].userInfoDTO.jid;
        if (IsStrEmpty(uid)) {
            uid = @"Visitor";
        }
        _UpLoadPath = [[_UpLoadPath stringByAppendingPathComponent:uid] copy];
        
        NSFileManager *fileManager = [NSFileManager defaultManager];
        BOOL isDir = YES;
        BOOL isExist = [fileManager fileExistsAtPath:_UpLoadPath
                                         isDirectory:&isDir];
        if (!isExist)
        {
            [[NSFileManager defaultManager] createDirectoryAtPath:_UpLoadPath
                                      withIntermediateDirectories:YES
                                                       attributes:nil
                                                            error:NULL];
        }
    }
    return _UpLoadPath;
}

static inline NSString* ThumbnailPath() {
    if (!_ThumbnailPath) {
        
        NSString *thumbnailPath = [NSSearchPathForDirectoriesInDomains
                                (NSCachesDirectory,NSUserDomainMask,YES)
                                objectAtIndex:0];
        
        _ThumbnailPath = [[thumbnailPath stringByAppendingPathComponent:@"Thumbnail"] copy];
        
        NSString *uid = [UserCenter defaultCenter].userInfoDTO.uid;
        if (IsStrEmpty(uid)) {
            uid = @"Visitor";
        }
        _ThumbnailPath = [[_ThumbnailPath stringByAppendingPathComponent:uid] copy];
        
        NSFileManager *fileManager = [NSFileManager defaultManager];
        BOOL isDir = YES;
        BOOL isExist = [fileManager fileExistsAtPath:_ThumbnailPath
                                         isDirectory:&isDir];
        if (!isExist)
        {
            [[NSFileManager defaultManager] createDirectoryAtPath:_ThumbnailPath
                                      withIntermediateDirectories:YES
                                                       attributes:nil
                                                            error:NULL];
        }
    }
    return _ThumbnailPath;
}

static inline NSString *AppSurportPath(){
    if (!_AppSurportPath) {
        NSString *appSurprtPath = [NSSearchPathForDirectoriesInDomains
                                   (NSCachesDirectory,NSUserDomainMask,YES)
                                   objectAtIndex:0];
        
        NSString* appBundleID = [[NSBundle mainBundle] bundleIdentifier];
        _AppSurportPath = [[appSurprtPath stringByAppendingPathComponent:appBundleID] copy];
        NSString *uid = [UserCenter defaultCenter].userInfoDTO.jid;
        if (IsStrEmpty(uid)) {
            uid = @"Visitor";
        }
        _AppSurportPath = [[_AppSurportPath stringByAppendingPathComponent:uid] copy];
        NSFileManager *fileManager = [NSFileManager defaultManager];
        BOOL isDir = YES;
        BOOL isExist = [fileManager fileExistsAtPath:appSurprtPath
                                         isDirectory:&isDir];
        if (!isExist)
        {
            [[NSFileManager defaultManager] createDirectoryAtPath:_AppSurportPath
                                      withIntermediateDirectories:YES
                                                       attributes:nil
                                                            error:NULL];
        }
    }
    return _AppSurportPath;
}

static inline NSString *FriendChatRecordsPath()
{
    if (!_FriendChatRecordsPath)
    {
        NSString* cachesDirectory = [NSSearchPathForDirectoriesInDomains
                                     (NSCachesDirectory, NSUserDomainMask, YES)
                                     objectAtIndex:0];
        
		_FriendChatRecordsPath = [[[cachesDirectory stringByAppendingPathComponent:
                                [[NSProcessInfo processInfo] processName]]
                               stringByAppendingPathComponent:@"Record"]
                              copy];
        
        NSString *uid = [UserCenter defaultCenter].userInfoDTO.jid;
        if (IsStrEmpty(uid))
        {
            uid = @"Visitor";
        }
        
        _FriendChatRecordsPath = [[_FriendChatRecordsPath stringByAppendingPathComponent:uid] copy];
        
        NSFileManager *fileManager = [NSFileManager defaultManager];
        BOOL isDir = YES;
        BOOL isExist = [fileManager fileExistsAtPath:_FriendChatRecordsPath
                                         isDirectory:&isDir];
        if (!isExist)
        {
            [fileManager createDirectoryAtPath:_FriendChatRecordsPath
                   withIntermediateDirectories:YES
                                    attributes:nil
                                         error:NULL];
        }
    }
    return _FriendChatRecordsPath;
}


