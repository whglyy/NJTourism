//
//  ChatListViewController.h
//  SuningIM
//
//  Created by lyywhg on 13-5-21.
//
//

/*
 说明：
    本类是会话列表展示控制器
 */

#import "CommonViewController.h"

#import "ChatViewController.h"
#import "ChatListCell.h"

@interface ChatListViewController : CommonViewController<UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *chatListTableView;

@end
