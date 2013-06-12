//
//  ChatViewController.m
//  SuningIM
//
//  Created by lyywhg on 13-5-21.
//
//

#import "ChatViewController.h"

@interface ChatViewController()

@property (strong, nonatomic, readwrite) NSMutableArray *chatRecordDataList;

@end

@implementation ChatViewController
#pragma mark-
#pragma mark
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];;
    if (self)
    {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreashTable) name:GETMESSAGEFROMESERVICE object:nil];
    }
    return self;
}
- (id)init
{
    self = [super init];
    if (self)
    {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreashTable) name:GETMESSAGEFROMESERVICE object:nil];
    }
    return self;
}
#pragma mark-
#pragma mark
- (NSString *)chatFriendJid
{
    if (!_chatFriendJid)
    {
        _chatFriendJid = [[NSString alloc] init];
    }
    return _chatFriendJid;
}
- (NSMutableArray *)chatRecordDataList
{
    if (!_chatRecordDataList)
    {
        _chatRecordDataList = [[NSMutableArray alloc] init];
    }
    return _chatRecordDataList;
}
#pragma mark-
#pragma mark
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.chatTableView.bubbleDataSource = self;
    self.chatTableView.snapInterval = 210;
    self.chatTableView.showAvatars = YES;
    self.chatTableView.typingBubble = NSBubbleTypingTypeNobody;
    
    // Keyboard events
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasShown:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillBeHidden:) name:UIKeyboardWillHideNotification object:nil];
}
- (void)viewDidUnload
{
    [self setChatTableView:nil];
    [self setInputTextView:nil];
    [self setButtomView:nil];
    [self setInputTextView:nil];
    [self setChatTableView:nil];
    [self setInputTextView:nil];
    [super viewDidUnload];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self refreashTable];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.hidesBottomBarWhenPushed = YES;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
#pragma mark-
#pragma mark Send Message
- (IBAction)sayPressed:(id)sender
{
    self.chatTableView.typingBubble = NSBubbleTypingTypeNobody;
    [self sendMessage2Friend:self.inputTextView.text];
    self.inputTextView.text = @"";
    [self.inputTextView resignFirstResponder];
}

- (void)sendMessage2Friend:(NSString *)message
{
    //本地输入框中的信息
    if (message.length > 0)
    {
        NSXMLElement *body = [NSXMLElement elementWithName:@"body"];
        [body setStringValue:message];
        XMPPMessage *mes = [XMPPMessage message];
        [mes addAttributeWithName:@"type" stringValue:@"chat"];
        [mes addAttributeWithName:@"to" stringValue:self.chatFriendJid];
        [mes addAttributeWithName:@"from" stringValue:[UserCenter defaultCenter].userInfoDTO.jid];
        [mes addChild:body];
        
        @autoreleasepool
        {
            NSDate *sendDate = [NSDate date];
            NSDateFormatter *sendDateFormatter = [[NSDateFormatter alloc] init];
            [sendDateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss.SSS zzz"];
            NSString *tmpDataString = [sendDateFormatter stringFromDate:sendDate];
            
            
            ChatRecordDTO *chatRecordDto = [[ChatRecordDTO alloc] init];
            chatRecordDto.friendJID = self.chatFriendJid;
            chatRecordDto.userJID = [UserCenter defaultCenter].userInfoDTO.jid;
            chatRecordDto.toJID = chatRecordDto.friendJID;
            chatRecordDto.fromJID = chatRecordDto.userJID;
            chatRecordDto.recordTime = tmpDataString;
            chatRecordDto.isSendOk = 1;
            chatRecordDto.recordContent = message;
            
            ChatRecordListDao *chatRecordListDao = [[ChatRecordListDao alloc] init];
            [[chatRecordListDao OperateChatRecordDB:chatRecordDto operateIndex:AddChatRecordActionType] boolValue];
        }
        //发送消息
        [[[XmppManager shareInstance] xmppStream] sendElement:mes];
        [self refreashTable];
    }
}
- (void)xmppStream:(XMPPStream *)sender didSendMessage:(XMPPMessage *)message
{
    
}

- (void)refreashTable
{
    [self.chatRecordDataList removeAllObjects];
        
    ChatRecordDTO *chatRecordDto = [[ChatRecordDTO alloc] init];
    chatRecordDto.friendJID = self.chatFriendJid;
    chatRecordDto.userJID = [UserCenter defaultCenter].userInfoDTO.jid;
        
    NSMutableArray *tmpArray = [[NSMutableArray alloc] init];
        
    ChatRecordListDao *chatRecordListDao = [[ChatRecordListDao alloc] init];
    [tmpArray addObjectsFromArray:[chatRecordListDao OperateChatRecordDB:chatRecordDto operateIndex:GetChatRecordsListActionType]];
    
    if (tmpArray == nil || [tmpArray count] ==0 )
    {
        return;
    }
    
    NSString *tmpLastChatString = [[NSString alloc] init];
    for (ChatRecordDTO *tmpChatRecordDto in tmpArray)
    {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init] ;
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss.SSS zzz"];
        NSDate *recordTime = [dateFormatter dateFromString:tmpChatRecordDto.recordTime];
            
        if ([tmpChatRecordDto.fromJID isEqualToString:self.chatFriendJid])
        {
            NSBubbleData *sayBubble = [NSBubbleData dataWithText:tmpChatRecordDto.recordContent date:recordTime type:BubbleTypeSomeoneElse];
            [self.chatRecordDataList addObject:sayBubble];
        }
        else
        {
            NSBubbleData *sayBubble = [NSBubbleData dataWithText:tmpChatRecordDto.recordContent date:recordTime type:BubbleTypeMine];
            [self.chatRecordDataList addObject:sayBubble];
        }
        tmpLastChatString = tmpChatRecordDto.recordContent;
    }
    
    //获取会话列表信息
    FriendListDao *friendListDao = [[FriendListDao alloc] init];
    FriendInfoDTO *friendInfo = [[FriendInfoDTO alloc] init];
            
    friendInfo.userId = [UserCenter defaultCenter].userInfoDTO.jid;
    friendInfo.friendId = self.chatFriendJid;
    friendInfo = [[friendListDao OperateFriendInfoDB:friendInfo operateIndex:GetOneFriendInfoActionType] lastObject];
    
    [Config currentConfig].isChatInfoChanged = [NSNumber numberWithInt:UpdateChatRecord2ChatRecordListType];
    if (friendInfo.isRecentChatted == NoAccessInType)
    {
        [Config currentConfig].isChatInfoChanged = [NSNumber numberWithInt:AddNewChatRecord2ChatRecordListType];
    }
    DLog(@"msg_lyywhg:%@, %d", [Config currentConfig].isChatInfoChanged, [[Config currentConfig].isChatInfoChanged intValue]);
    
    friendInfo.isRecentChatted = RecentAccessInType;
    if (! (((ChatRecordDTO *)[tmpArray lastObject]).recordTime == nil || [((ChatRecordDTO *)[tmpArray lastObject]).recordTime length]==0) )
    {
        friendInfo.lastMessageTime = ((ChatRecordDTO *)[tmpArray lastObject]).recordTime;
    }
    if  (! (tmpLastChatString == nil || [tmpLastChatString length]==0))
    {
        friendInfo.lastUnreadMessage = tmpLastChatString;
    }
    friendInfo.friendSignNote = @"";
    [friendListDao OperateFriendInfoDB:friendInfo operateIndex:ChangeFriendNickNameActionType];
    
    [self.chatTableView reloadData];
}

#pragma mark
#pragma mark - UIBubbleTableViewDataSource implementation
- (NSInteger)rowsForBubbleTable:(UIBubbleTableView *)tableView
{
    return [self.chatRecordDataList count];
}

- (NSBubbleData *)bubbleTableView:(UIBubbleTableView *)tableView dataForRow:(NSInteger)row
{
    return [self.chatRecordDataList objectAtIndex:row];
}
#pragma mark
#pragma mark - Keyboard events
- (void)keyboardWasShown:(NSNotification*)aNotification
{
    NSDictionary* info = [aNotification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    
    [UIView animateWithDuration:0.2f animations:^{
        
        CGRect frame = self.buttomView.frame;
        frame.origin.y = self.view.frame.size.height - 44 - kbSize.height;
        self.buttomView.frame = frame;
        
        frame = self.chatTableView.frame;
        frame.origin.y = 0 - kbSize.height;
        self.chatTableView.frame = frame;
    }];
}

- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{    
    [UIView animateWithDuration:0.2f animations:^{
        
        CGRect frame = self.buttomView.frame;
        frame.origin.y = self.view.frame.size.height - 44;
        self.buttomView.frame = frame;
        
        frame = self.chatTableView.frame;
        frame.origin.y = 0;
        self.chatTableView.frame = frame;
    }];
}
- (void) textView:(PHLGrowingTextView *)textView willChangeToHeight:(CGFloat)newHeight
{
    NSLog(@"willChangeToHeight %f", newHeight);
}

- (void) textView:(PHLGrowingTextView *)textView didChangeFromHeight:(CGFloat)oldHeight
{
    NSLog(@"didChangeHeight %f", textView.frame.size.height);
}

@end
