
//
//  ChatListViewController.m
//  SuningIM
//
//  Created by lyywhg on 13-5-21.
//
//

#import "ChatListViewController.h"

static NSString *ChatListCellIdentifier = @"ChatListCell";

@interface ChatListViewController()
@property (assign, nonatomic, readwrite) NSInteger clickIndex;
@property (strong, nonatomic, readwrite) NSMutableArray *chatListArray;

@end

@implementation ChatListViewController
#pragma mark-
#pragma mark Init & Dealloc
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshChatList) name:LOGIN_OK_NOTIFICATION object:nil];
    }
    return self;
}
- (id)init
{
    self = [super init];
    if (self)
    {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshChatList) name:LOGIN_OK_NOTIFICATION object:nil];
    }
    return self;
}
#pragma mark-
#pragma mark Init & Add
- (NSMutableArray *)chatListArray
{
    if (!_chatListArray)
    {
        _chatListArray = [[NSMutableArray alloc] init];
    }
    return _chatListArray;
}
#pragma mark-
#pragma mark 
- (void)viewDidLoad
{
    [super viewDidLoad];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self refreshChatList];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
#pragma mark-
#pragma mark Table Delegate & Table DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.chatListArray count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ChatListCell *chatListCell = [tableView dequeueReusableCellWithIdentifier:ChatListCellIdentifier];
    if (chatListCell == nil)
    {
        chatListCell = [[[NSBundle mainBundle] loadNibNamed:ChatListCellIdentifier owner:self options:nil] objectAtIndex:0];
    }
    chatListCell.selectionStyle = UITableViewCellSelectionStyleNone;
    [chatListCell reloadChatListCellInfo:self.chatListArray[[indexPath row]]];
    
    _clickIndex = indexPath.row;
    return chatListCell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ChatViewController *chatViewController = [[ChatViewController alloc] initWithNibName:@"ChatViewController" bundle:nil];
    chatViewController.chatFriendJid = ((FriendInfoDTO *)[self.chatListArray objectAtIndex:[indexPath row]]).friendId;
    chatViewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:chatViewController animated:YES];
    return;
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        [self deleteChatInfoFromDB:indexPath.row];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        [self.chatListTableView reloadData];
    }
}
#pragma mark-
#pragma mark 
- (void)viewDidUnload
{
    [self setChatListArray:nil];
    [self setChatListTableView:nil];
    [super viewDidUnload];
}
#pragma mark-
#pragma mark 
- (void)refreshChatList
{
    int iTmp = [[Config currentConfig].isChatInfoChanged intValue];
    DLog(@"msg_lyywhg:%d", [[Config currentConfig].isChatInfoChanged intValue]);
    switch (iTmp)
    {
        case AddNewChatRecord2ChatRecordListType:
            [self addNewRecord2ChatList];
            return;
        case UpdateChatRecord2ChatRecordListType:
            [self updateChatList];
            return;
        case NoChangeOccuredType:
            return;
        default:
            return;
    }
}
#pragma mark-
#pragma mark Operate ChatListView & ChatListDB
- (void)addNewRecord2ChatList
{
    @autoreleasepool
    {
        if (self.chatListArray == nil || [self.chatListArray count] == 0)
        {
            [self updateChatList];
            return;
        }
        
        int i = 0;
        FriendListDao *tmpFriendListDao = [[FriendListDao alloc] init];
        FriendInfoDTO *tmpFriendListDto = [[FriendInfoDTO alloc] init];
        tmpFriendListDto.userId = [UserCenter defaultCenter].userInfoDTO.jid;
        tmpFriendListDto.isRecentChatted = RecentAccessInType;
        NSMutableArray *tmpArray = [[NSMutableArray alloc] init];
        [tmpArray addObjectsFromArray:[tmpFriendListDao OperateFriendInfoDB:tmpFriendListDto operateIndex:GetNewChatFriendInfoActionType]];
        
        NSMutableArray *indexPaths = [[NSMutableArray alloc] init];
        for (FriendInfoDTO *friendInfo in tmpArray)
        {
            [self.chatListArray insertObject:friendInfo atIndex:i];
            [indexPaths addObject:[NSIndexPath indexPathForRow:i inSection:0]];
            i = i + 1;
        }
        
        [self.chatListTableView beginUpdates];
        [self.chatListTableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationMiddle];
        [Config currentConfig].isChatInfoChanged = [NSNumber numberWithInt:NoChangeOccuredType];
        [self.chatListTableView endUpdates];
    }
}
- (void)updateChatList
{
    [self.chatListArray removeAllObjects];
    @autoreleasepool
    {
        FriendListDao *tmpFriendListDao = [[FriendListDao alloc] init];
        FriendInfoDTO *tmpFriendListDto = [[FriendInfoDTO alloc] init];
        tmpFriendListDto.userId = [UserCenter defaultCenter].userInfoDTO.jid;
        tmpFriendListDto.isRecentChatted = RecentAccessInType;
        NSMutableArray *tmpArray = [[NSMutableArray alloc] init];
        [tmpArray addObjectsFromArray:[tmpFriendListDao OperateFriendInfoDB:tmpFriendListDto operateIndex:GetAllChatFriendInfoActionType]];
        
        for (FriendInfoDTO *tmpDto in tmpArray)
        {
            [self.chatListArray addObject:tmpDto];
        }
    }
    [Config currentConfig].isChatInfoChanged = [NSNumber numberWithInt:NoChangeOccuredType];
    [self.chatListTableView reloadData];
}
- (void)deleteChatInfoFromDB:(NSInteger)index
{
    FriendListDao *tmpFriendListDao = [[FriendListDao alloc] init];
    FriendInfoDTO *tmpFriendListDto = [[FriendInfoDTO alloc] init];
    tmpFriendListDto.userId = [UserCenter defaultCenter].userInfoDTO.jid;
    tmpFriendListDto.friendId = ((FriendInfoDTO *)[self.chatListArray objectAtIndex:index]).friendId;
    tmpFriendListDto.isRecentChatted = NoAccessInType;
    [tmpFriendListDao OperateFriendInfoDB:tmpFriendListDto operateIndex:UpdateFriendIsRecentChattedType];
    [self.chatListArray removeObjectAtIndex:index];
}
#pragma mark-
#pragma mark Click HeadImage
- (void)clickHeadImage
{
//    _clickIndex 
}

@end
