//
//  BusStationView.m
//  NJTourism
//
//  Created by lyywhg on 13-6-17.
//
//

#import "BusStationView.h"

@implementation BusStationView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        // Initialization code
    }
    return self;
}

#pragma mark-
#pragma mark Init & Add
- (UITableView *)busStationTableView
{
    if (!_busStationTableView)
    {
        _busStationTableView = [[TPKeyboardAvoidingTableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        [_busStationTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        [_busStationTableView setIndicatorStyle:UIScrollViewIndicatorStyleWhite];
        _busStationTableView.scrollEnabled = YES;
        _busStationTableView.userInteractionEnabled = YES;
        _busStationTableView.delegate = self;
        _busStationTableView.dataSource = self;
        _busStationTableView.backgroundColor = [UIColor clearColor];
        
        [self addSubview:_busStationTableView];
    }
    return _busStationTableView;
}
- (UITextField *)busStationTextField
{
    if (!_busStationTextField)
    {
        _busStationTextField = [[UITextField alloc] init];
        _busStationTextField.backgroundColor = [UIColor clearColor];
        _busStationTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _busStationTextField.delegate = self;
        _busStationTextField.autocapitalizationType = NO;
        _busStationTextField.autocorrectionType = NO;
        _busStationTextField.placeholder = L(@"线路名称");
        _busStationTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        _busStationTextField.borderStyle = UITextBorderStyleNone;
        _busStationTextField.returnKeyType = UIReturnKeyDone;
        _busStationTextField.frame = CGRectMake(45, 0, 222, 36);
    }
    return _busStationTextField;
}
- (UIButton *)queryBtn
{
    if (!_queryBtn)
    {
        _queryBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_queryBtn addTarget:self action:@selector(queryBusLine) forControlEvents:UIControlEventTouchUpInside];
    }
    return _queryBtn;
}
#pragma mark-
#pragma mark Table　Delegate & Source
#pragma mark-
#pragma mark Table View
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.busStationTableView.frame.size.height;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifer = @"identifer";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    
    if (nil == cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell.contentView addSubview:self.busStationTextField];
    [cell.contentView addSubview:self.queryBtn];
    
    return cell;
}
#pragma mark-
#pragma mark Method
- (void)setAllFrame
{
    self.busStationTableView.frame = CGRectMake(0, 0, 260, 200);
}

- (void)getLocalStation
{
}
- (void)queryBusLine
{
}

@end
