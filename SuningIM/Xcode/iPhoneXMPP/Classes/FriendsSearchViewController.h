//
//  FriendsSearchViewController.h
//  SuningIM
//
//  Created by shasha on 13-5-31.
//
//

#import "PageRefreshTableViewController.h"
@interface FriendsSearchViewController : PageRefreshTableViewController<UISearchBarDelegate,SNXmppFriendsDelegate>
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@end
