//
//  ChatRecordListDao.h
//  FatFist
//
//  Created by lyywhg on 13-6-5.
//
//

/*
 聊天记录DAO
 */

#import "DAO.h"
#import "FriendInfoHeader.h"

@interface ChatRecordListDao : DAO

- (id)OperateChatRecordDB:(ChatRecordDTO *)chatInfo operateIndex:(NSInteger)index;

@end
