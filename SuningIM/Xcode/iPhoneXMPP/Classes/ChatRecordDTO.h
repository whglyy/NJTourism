//
//  ChatRecordDTO.h
//  SuningIM
//
//  Created by lyywhg on 13-6-5.
//
//

#import <Foundation/Foundation.h>

@interface ChatRecordDTO : NSObject

@property (strong, nonatomic) NSString *userJID;
@property (strong, nonatomic) NSString *friendJID;
@property (strong, nonatomic) NSString *fromJID;
@property (strong, nonatomic) NSString *toJID;
@property (strong, nonatomic) NSString *recordTime;
@property (strong, nonatomic) NSString *recordContent;

@property (assign, nonatomic) NSInteger isSendOk;


@end
