//
//  SNFileManeger.h
//  FatFist
//
//  Created by lyywhg on 13-5-24.
//
//

#import <Foundation/Foundation.h>
#import "SNFileInfoDTO.h"

//file类型
typedef enum{
    eDirectory,
    eFile,
    eNotExist,
} E_FileType;

//file属性
struct FileInfo {

};

typedef void (^SNFileError)( NSError *err);

@interface SNFileManeger : NSObject

+ (NSString *)getDocumentPath;
+ (NSString *)getTempPath;
+ (NSString *)getResourcePath;
+ (NSString *)getLibraryPath;

+ (E_FileType)getFileTypeOfPath:(NSString *)path;

+ (void)createDirectoryAtPath:(NSString *)path ErrorBlock:(SNFileError)block;

+ (void)deleteDirectoryAtPath:(NSString *)path ErrorBlock:(SNFileError)block;

+ (NSArray *)getContentsOfDirectoryAtPath:(NSString *)path ErrorBlock:(SNFileError)block;

+ (SNFileInfoDTO *)getFileInfoAtPath:(NSString *)path ErrorBlock:(SNFileError)block;

@end
