//
//  FriendListDao.h
//  SuningIM
//
//  Created by lyywhg on 13-5-29.
//
//

#import "DAO.h"
#import "FriendInfoHeader.h"

@interface FriendListDao : DAO

- (id)OperateFriendInfoDB:(id)friendInfo operateIndex:(NSInteger)index;

@end
