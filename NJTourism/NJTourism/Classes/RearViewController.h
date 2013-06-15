

#import <UIKit/UIKit.h>

@interface RearViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>


@property (nonatomic, retain) IBOutlet UITableView *rearTableView;

@property (nonatomic, strong) NSArray *sectionTitleList;
@property (nonatomic, strong) NSArray *tableList;

@end