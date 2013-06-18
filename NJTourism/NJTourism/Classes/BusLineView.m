//
//  BusLineView.m
//  NJTourism
//
//  Created by lyywhg on 13-6-17.
//
//

#import "BusLineView.h"

@implementation BusLineView

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
- (UITableView *)busLineTableView
{
    if (!_busLineTableView)
    {
        _busLineTableView = [[TPKeyboardAvoidingTableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        [_busLineTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        [_busLineTableView setIndicatorStyle:UIScrollViewIndicatorStyleWhite];
        _busLineTableView.scrollEnabled = YES;
        _busLineTableView.userInteractionEnabled = YES;
        _busLineTableView.delegate = self;
        _busLineTableView.dataSource = self;
        _busLineTableView.backgroundColor = [UIColor clearColor];
        
        [self addSubview:_busLineTableView];
    }
    return _busLineTableView;
}
- (UITextField *)busLineTextField
{
    if (!_busLineTextField)
    {
        _busLineTextField = [[UITextField alloc] init];
        _busLineTextField.backgroundColor = [UIColor clearColor];
        _busLineTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _busLineTextField.delegate = self;
        _busLineTextField.autocapitalizationType = NO;
        _busLineTextField.autocorrectionType = NO;
        _busLineTextField.placeholder = L(@"线路名称");
        _busLineTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        _busLineTextField.borderStyle = UITextBorderStyleNone;
        _busLineTextField.returnKeyType = UIReturnKeyDone;
        _busLineTextField.frame = CGRectMake(45, 0, 222, 36);
    }
    return _busLineTextField;
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
    return self.busLineTableView.frame.size.height;
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
    [cell.contentView addSubview:self.busLineTextField];
    [cell.contentView addSubview:self.queryBtn];
    
    return cell;
}
#pragma mark-
#pragma mark Method
- (void)setAllFrame
{
    self.busLineTableView.frame = CGRectMake(0, 0, 260, 200);
}

- (void)getLocalStation
{
}
- (void)queryBusLine
{
}

@end
