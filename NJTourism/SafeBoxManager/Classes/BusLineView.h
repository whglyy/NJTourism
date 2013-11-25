//
//  BusLineView.h
//  NJTourism
//
//  Created by lyywhg on 13-6-17.
//
//

#import <UIKit/UIKit.h>

@protocol BusLineDelegate <NSObject>
@optional
- (void)getBusLine;
@end

@interface BusLineView : UIView<UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) id<BusLineDelegate> bDelegate;

@property (strong, nonatomic) UITableView *busLineTableView;
@property (strong, nonatomic) UITextField *busLineTextField;
@property (strong, nonatomic) UIButton *queryBtn;

- (void)setAllFrame;

@end
