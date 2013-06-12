//
//  FriendsListController.m
//  SuningIM
//
//  Created by lyywhg on 13-5-22.
//
//

#import "FriendsListController.h"

static NSString *NewFriendCellIdentifier = @"NewFriendCell";
static NSString *FriendsListCellIdentifier = @"FriendsListCell";

@implementation FriendsListController
#pragma mark-
#pragma mark
- (id)init
{
    self = [super init];
    if (self)
    {
    }
    return self;
}
#pragma mark-
#pragma mark
- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload
{
    [self setFriendListTableView:nil];
    [self setFriendSearch:nil];
    [super viewDidUnload];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self refreshFriendList];
}
#pragma mark-
#pragma mark
- (NSMutableDictionary *)friendsListDic
{
    if (!_friendsListDic)
    {
        _friendsListDic = [[NSMutableDictionary alloc] init];
    }
    return _friendsListDic;
}
- (NSMutableDictionary *)searchFriendNameListDic
{
    if (!_searchFriendNameListDic)
    {
        _searchFriendNameListDic = [[NSMutableDictionary alloc] init];
    }
    return _searchFriendNameListDic;
}
- (NSMutableArray *)friendsFirstNameList
{
    if (!_friendsFirstNameList)
    {
        _friendsFirstNameList = [[NSMutableArray alloc] init];
    }
    return _friendsFirstNameList;
}
#pragma mark-
#pragma mark Table Delegate & Table DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return ([self.friendsFirstNameList count] > 0) ? [self.friendsFirstNameList count] : 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_isSearch && ([self.friendsFirstNameList count] == 0) )
    {
        return 0;
    }
    if (section == 0 && !_isSearch)
    {
        return 1;
    }
    else
    {
        int iSection = section;
        if (_isSearch)
        {
//            iSection = iSection - 1;
        }
        NSMutableArray *nameSection = [[NSMutableArray alloc] init];
        NSString *nameFristString = [self.friendsFirstNameList objectAtIndex:iSection];
        [nameSection addObjectsFromArray:[self FriendInfos2Array:[self.searchFriendNameListDic objectForKey:nameFristString]]];
        
        return [nameSection count];
    }
    return 0;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0 && !_isSearch)
    {
        return nil;
    }
    else
    {
        return [self.friendsFirstNameList objectAtIndex:section];
    }
    return nil;
}
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return self.friendsFirstNameList;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([indexPath section] == 0 && !_isSearch)
    {
        NewFriendCell *newFriendCell = [tableView dequeueReusableCellWithIdentifier:NewFriendCellIdentifier];
        if (newFriendCell == nil)
        {
            newFriendCell = [[[NSBundle mainBundle] loadNibNamed:NewFriendCellIdentifier owner:self options:nil] objectAtIndex:0];
        }
        newFriendCell.selectionStyle = UITableViewCellSelectionStyleNone;
        return newFriendCell;
    }
    else
    {
        int iSection = [indexPath section];
        if (_isSearch)
        {
//            iSection = iSection +1;
        }
        NSMutableArray *nameSection = [[NSMutableArray alloc] init];
        NSString *nameFristString = [self.friendsFirstNameList objectAtIndex:iSection];
        
        [nameSection addObjectsFromArray:[self FriendInfos2Array:[self.searchFriendNameListDic objectForKey:nameFristString]]];
        
        FriendsListCell *friendsListCell = [tableView dequeueReusableCellWithIdentifier:FriendsListCellIdentifier];
        if (friendsListCell == nil)
        {
            friendsListCell = [[[NSBundle mainBundle] loadNibNamed:FriendsListCellIdentifier owner:self options:nil] objectAtIndex:0];
        }
        friendsListCell.selectionStyle = UITableViewCellSelectionStyleNone;
        [friendsListCell setFriendListInfo:[self getFriendInfo:nameSection index:[indexPath row]]];
        return friendsListCell;
    }
    return nil;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //跳转到会话界面
    ChatViewController *chatViewController = [[ChatViewController alloc] initWithNibName:@"ChatViewController" bundle:nil];
    NSString *tmpKey = [self.friendsFirstNameList objectAtIndex:[indexPath section]];
    NSMutableArray *tmpFriendInfoArray = [self FriendInfos2Array:[self.searchFriendNameListDic objectForKey:tmpKey]];
    chatViewController.chatFriendJid = ((FriendInfoDTO *)[tmpFriendInfoArray objectAtIndex:[indexPath row]]).friendId;
    chatViewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:chatViewController animated:YES];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *tmpKey = [self.friendsFirstNameList objectAtIndex:[indexPath section]];
    NSMutableArray *tmpFriendInfoArray = [self FriendInfos2Array:[self.searchFriendNameListDic objectForKey:tmpKey]];
    [[self.friendsListDic objectForKey:tmpKey] removeObject:[tmpFriendInfoArray objectAtIndex:[indexPath row]]];
    
    [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    [self refreshFriendList];
}

#pragma mark-
#pragma mark Search Delegate
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    NSString *searchTerm = [searchBar text];
    [self handleSearchForTerm:searchTerm];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchTerm
{
    searchBar.showsCancelButton = YES;
    if ([searchTerm length] == 0)
    {
        [self resetSearch];
        [self.friendListTableView reloadData];
        return;
    }
    [self handleSearchForTerm:searchTerm];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    searchBar.showsCancelButton = NO;
    _isSearch = NO;
    self.friendSearch.text = @"";
    [self resetSearch];
    [self.friendListTableView reloadData];
    [searchBar resignFirstResponder];
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    _isSearch = YES;
    [self.friendListTableView reloadData];
}
#pragma mark-
#pragma mark Get FriendInfo
- (void)refreshFriendList
{
    [self.friendsListDic removeAllObjects];
    [self.friendsFirstNameList removeAllObjects];
    [self.searchFriendNameListDic removeAllObjects];
    
    FriendListDao *tmpFriendListDao = [[FriendListDao alloc] init];
    FriendInfoDTO *tmpFriendListDto = [[FriendInfoDTO alloc] init];
    tmpFriendListDto.userId = [UserCenter defaultCenter].userInfoDTO.jid;
    NSMutableDictionary *tmpFriendListDic = [[NSMutableDictionary alloc] init];
    [tmpFriendListDic addEntriesFromDictionary:[tmpFriendListDao OperateFriendInfoDB:tmpFriendListDto operateIndex:GetFriendsListActionType]];
    
    [self.friendsListDic addEntriesFromDictionary:tmpFriendListDic];
    
    if ([self.friendsListDic isKindOfClass:[NSDictionary class]])
    {
        DLog(@"msg_lyywhg:~dict");
    }
    if ([self.friendsListDic isKindOfClass:[NSMutableDictionary class]])
    {
        DLog(@"msg_lyywhg:~Mutabledict");
    }
    
    [self resetSearch];
    
    [self.friendListTableView reloadData];
}
- (void)resetSearch
{
    NSMutableDictionary *allNamesCopy = self.friendsListDic;
    self.searchFriendNameListDic = allNamesCopy;
    NSMutableArray *keyArray = [[NSMutableArray alloc] init];
    [keyArray addObject:UITableViewIndexSearch];
    [keyArray addObjectsFromArray:[[self.friendsListDic allKeys]  sortedArrayUsingSelector:@selector(compare:)]];
    self.friendsFirstNameList = keyArray;
}
- (void)handleSearchForTerm:(NSString *)searchTerm
{
    NSMutableArray *sectionsToRemove = [[NSMutableArray alloc] init];
    [self resetSearch];
	
    @autoreleasepool
    {
        for (NSString *key in self.friendsFirstNameList)
        {
            if ([key isEqualToString:@"{search}"])
            {
                continue;
            }
            NSMutableArray *array = [self FriendInfos2Array:[self.searchFriendNameListDic objectForKey:key]];
            
            NSMutableArray *toRemove = [[NSMutableArray alloc] init];
            for (FriendInfoDTO *name in array)
            {
                if ([name.friendUserName rangeOfString:searchTerm
                                options:NSCaseInsensitiveSearch].location == NSNotFound)
                {
                    [toRemove addObject:name];
                }
            }
            if ([array count] == [toRemove count])
            {
                [sectionsToRemove addObject:key];
            }
            
            [[self.searchFriendNameListDic objectForKey:key] removeObjectsInArray:toRemove];
        }
    }
    
    [self.friendsFirstNameList removeObjectsInArray:sectionsToRemove];
    [self.friendListTableView reloadData];
}

- (FriendInfoDTO *)getFriendInfo:(NSArray *)nameSection index:(NSInteger)index
{
    NSMutableArray *tmpArray = [[NSMutableArray alloc] init];
    
    [tmpArray addObjectsFromArray:nameSection];
    
    FriendInfoDTO *friendInfo = [[FriendInfoDTO alloc] init];
    friendInfo = (FriendInfoDTO *)[tmpArray objectAtIndex:index];
    return friendInfo;
}
- (NSMutableArray *)FriendInfos2Array:(id)friendInfo;
{
    NSMutableArray *tmpArray = [[NSMutableArray alloc] init];
    
    if ([friendInfo isKindOfClass:[FriendInfoDTO class]])
    {
        [tmpArray addObject:friendInfo];
    }
    else if ([friendInfo isKindOfClass:[NSArray class]])
    {
        [tmpArray addObjectsFromArray:friendInfo];
    }
    else if ([friendInfo isKindOfClass:[NSMutableArray class]])
    {
        [tmpArray addObjectsFromArray:friendInfo];
    }
    return tmpArray;
}
@end
