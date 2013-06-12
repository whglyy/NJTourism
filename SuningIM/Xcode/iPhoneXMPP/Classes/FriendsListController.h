//
//  FriendsListController.h
//  SuningIM
//
//  Created by lyywhg on 13-5-22.
//
//

#import "CommonViewController.h"
#import "ChatViewController.h"

#import "NewFriendCell.h"
#import "FriendsListCell.h"

#import "FriendInfoHeader.h"
#import "FriendListDao.h"

#import "NSDictionary-MutableDeepCopy.h"

@interface FriendsListController : CommonViewController<UISearchBarDelegate, UISearchDisplayDelegate>

@property (weak, nonatomic) IBOutlet UISearchBar *friendSearch;
@property (retain, nonatomic) IBOutlet UITableView *friendListTableView;

@property (strong, nonatomic) NSMutableDictionary *friendsListDic;
@property (strong, nonatomic) NSMutableDictionary *searchFriendNameListDic;

@property (strong, nonatomic) NSMutableArray *friendsFirstNameList;

@property (assign, nonatomic) BOOL isSearch;

@end
