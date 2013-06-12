//
//  FriendInfoDTO.h
//  SuningIM
//
//  Created by lyywhg on 13-6-4.
//
//

/*
 定义：联系人基本信息结构体
 基本内容：
 */

#import "ChatRecordDTO.h"

@interface FriendInfoDTO : NSObject

@property (assign, nonatomic) NSInteger friendSex;
@property (assign, nonatomic) NSInteger friendPhoneNumber;
@property (assign, nonatomic) NSInteger isRecentChatted;
@property (assign, nonatomic) NSInteger totalMessageCount;
@property (assign, nonatomic) NSInteger readedMessageCount;

@property (strong, nonatomic) NSString *userId;
@property (strong, nonatomic) NSString *friendId;
@property (strong, nonatomic) NSString *friendGroupName;

@property (strong, nonatomic) NSString *friendShowName;
@property (strong, nonatomic) NSString *friendNameCharacter;
@property (strong, nonatomic) NSString *friendHeaderImage;
@property (strong, nonatomic) NSString *friendSignNote;

@property (strong, nonatomic) NSString *friendNickName;
@property (strong, nonatomic) NSString *friendUserName;
@property (strong, nonatomic) NSString *friendUserEmail;
@property (strong, nonatomic) NSString *friendBirthDay;
@property (strong, nonatomic) NSString *friendHomeCity;

@property (strong, nonatomic) NSString *friendConstellation;  //星座

@property (strong, nonatomic) NSString *lastUnreadMessage;
@property (strong, nonatomic) NSString *lastMessageTime;      //最后一条消息时间

@end
