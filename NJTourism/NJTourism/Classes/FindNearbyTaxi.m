//
//  FindNearbyTaxi.m
//  FatFish
//
//  Created by lyywhg on 13-4-1.
//  Copyright (c) 2013年 suning. All rights reserved.
//

#import "FindNearbyTaxi.h"

@interface FindNearbyTaxi ()
@property (nonatomic, retain) ASIHTTPRequest *createHttpRequest;
@end

@implementation FindNearbyTaxi
#pragma mark-
#pragma mark Init & Dealloc
- (id)init
{
    self = [super init];
    if (self)
    {
    }
    return self;
}

- (void)createFolderWithFolderInfo:(NSString *)folderDto
{
    
    NSString *tmpString = @"KIND=11&MOBILEID=79c848f2b485f74a2cdda302d4cbcb8f9c9de202&MOBILETYPE=1";
    NSData *data = [tmpString dataUsingEncoding:NSUnicodeStringEncoding];
    NSString *ret = [data base64Encoding];
    NSString *url = [NSString stringWithFormat:@"%@%@",
                     Taxi_Url, ret];
    DLog(@"msg_lyywhg:%@ ~~~~ %@", ret, data);
    
    [self cancelRequestByCmdCode:10001];
    SNRequest *request = [self POST:url dict:nil];
    request.cmdCode = 10001;

}

- (void)handleRequest:(SNRequest *)request
{
    switch (request.cmdCode)
    {
        case 10001:
        {
            if (request.failed)
            {
                self.errorMsg = [self  errorMsgOfRequestError:request.error];
                [self folderUrlFinished:NO];
            }
            else if(request.succeed)
            {
                BOOL isSuccess = [self isResponseSuccess:request.responseHeaders
                                              RequestCmd:request.cmdCode];
                NSDictionary *dataDic = [self dataInfoOfResponse:request.jsonItems];
                if (isSuccess)
                {
                    if ([[dataDic objectForKey:@"result"] isEqualToString:@"1"])
                    {
                        self.errorMsg = [dataDic objectForKey:@"msg"];
                        [self folderUrlFinished:NO];
                    }
                    else
                    {
                        [self folderUrlFinished:YES];
                    }
                }
                else
                {
                    [self folderUrlFinished:NO];
                }
            }
        }
            break;
        default:
            break;
    }
}

- (void)folderUrlFinished:(BOOL)isSuccess
{
    if ([self.folderCreateDelegate conformsToProtocol:@protocol(FolderCreateDelegate) ])
    {
        if ([self.folderCreateDelegate respondsToSelector:@selector(folderCreateCompletedWithResult:errorMsg:)])
        {
            [self.folderCreateDelegate folderCreateCompletedWithResult:isSuccess errorMsg:self.errorMsg];
        }
    }
}

@end
