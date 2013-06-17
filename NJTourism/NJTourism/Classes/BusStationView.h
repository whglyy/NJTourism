//
//  BusStationView.h
//  NJTourism
//
//  Created by lyywhg on 13-6-17.
//
//

#import <UIKit/UIKit.h>

@interface BusStationView : UIView<UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, retain) UITableView *busStationTableView;
@property (strong, nonatomic) UITextField *busStationTextField;
@property (strong, nonatomic) UIButton *queryBtn;

@end
