

#import <UIKit/UIKit.h>

@interface RearViewController : CommonViewController <UITableViewDelegate, UITableViewDataSource>


@property (nonatomic, retain) IBOutlet UITableView *rearTableView;

@property (nonatomic, strong) NSArray *tableList;

@property (nonatomic, strong) RevealController *revealController;

@end