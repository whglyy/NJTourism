//
//  ChangeBusView.h
//  NJTourism
//
//  Created by lyywhg on 13-6-17.
//
//

#import <UIKit/UIKit.h>

@interface ChangeBusView : UIView<UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, retain) UITableView *changeBusTableView;

@property (strong, nonatomic) UITextField *startPointTextField;
@property (strong, nonatomic) UITextField *endPointTextField;

@property (strong, nonatomic) UIButton *localBtn;

@property (strong, nonatomic) UIButton *queryBtn;

- (void)setAllFrame;

@end
