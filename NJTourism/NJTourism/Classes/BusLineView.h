//
//  BusLineView.h
//  NJTourism
//
//  Created by lyywhg on 13-6-17.
//
//

#import <UIKit/UIKit.h>

@interface BusLineView : UIView<UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, retain) UITableView *busLineTableView;
@property (strong, nonatomic) UITextField *busLineTextField;
@property (strong, nonatomic) UIButton *queryBtn;

- (void)setAllFrame;

@end
