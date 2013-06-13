//
//
//  FatFist
//
//  Created by lyywhg on 13-5-24.
//
//

#import <UIKit/UIKit.h>
#import "NJPageScrollView.h"
#import "NJPageScrollViewCell.h"

//加入其中的viewController需要服从的协议
//取缔viewWillAppear和viewWillDisappear
@protocol BBScrollContentApperace <NSObject>

@required
- (void)viewAppear;
- (void)viewDisappear;

@end


@interface BBScrollViewController : UIViewController
<NJPageScrollViewDataSource, NJPageScrollViewDelegate>
{
@protected
    NJPageScrollView *_scrollView;
    NSInteger        _currentPage;
    NSMutableArray   *_viewControllers;
}

@property (nonatomic, retain) NSMutableArray *viewControllers;

@property (nonatomic, assign) NSInteger currentPage;


- (void)reloadViewControllers;


@end

/*********************************************************************/
//暂时未启用
@interface UIViewController(BBScroll)

@property (nonatomic, assign) BBScrollViewController *bbScrollController;

@end

