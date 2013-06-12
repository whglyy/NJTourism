//
//  ChatViewController.h
//  SuningIM
//
//  Created by lyywhg on 13-5-21.
//
//

/*
 说明：
 本类是聊天窗口
 */

#import "CommonViewController.h"
#import "XMPPFramework.h"

#import "UIBubbleTableViewDataSource.h"
#import "UIBubbleTableView.h"
#import "UIBubbleTableViewDataSource.h"
#import "NSBubbleData.h"
#import "PHLGrowingTextView.h"

@interface ChatViewController : CommonViewController<XMPPStreamDelegate, UIBubbleTableViewDataSource, PHLGrowingTextViewDelegate>

@property (weak, nonatomic) IBOutlet UIBubbleTableView *chatTableView;

@property (weak, nonatomic) IBOutlet UIView *buttomView;
//@property (weak, nonatomic) IBOutlet PHLGrowingTextView *inputTextView;
@property (weak, nonatomic) IBOutlet PHLGrowingTextView *inputTextView;

@property (strong, nonatomic, readwrite) NSString *chatFriendJid;

@end
