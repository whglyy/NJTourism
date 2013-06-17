//
//  ChangeBusView.m
//  NJTourism
//
//  Created by lyywhg on 13-6-17.
//
//

#import "ChangeBusView.h"

@implementation ChangeBusView

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
- (UITableView *)changeBusTableView
{
    if (!_changeBusTableView)
    {
        _changeBusTableView = [[TPKeyboardAvoidingTableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        [_changeBusTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        [_changeBusTableView setIndicatorStyle:UIScrollViewIndicatorStyleWhite];
        _changeBusTableView.scrollEnabled = YES;
        _changeBusTableView.userInteractionEnabled = YES;
        _changeBusTableView.delegate = self;
        _changeBusTableView.dataSource = self;
        _changeBusTableView.backgroundColor = [UIColor clearColor];
        
        [self addSubview:_changeBusTableView];
    }
    return _changeBusTableView;
}
- (UITextField *)startPointTextField
{
    if (!_startPointTextField)
    {
        _startPointTextField = [[UITextField alloc] init];
        _startPointTextField.backgroundColor = [UIColor clearColor];
        _startPointTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _startPointTextField.delegate = self;
        _startPointTextField.autocapitalizationType = NO;
        _startPointTextField.autocorrectionType = NO;
        _startPointTextField.placeholder = L(@"起点");
        _startPointTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        _startPointTextField.borderStyle = UITextBorderStyleNone;
        _startPointTextField.returnKeyType = UIReturnKeyDone;
        _startPointTextField.frame = CGRectMake(45, 0, 222, 36);
    }
    return _startPointTextField;
}
- (UITextField *)endPointTextField
{
    if (!_endPointTextField)
    {
        _endPointTextField = [[UITextField alloc] init];
        _endPointTextField.backgroundColor = [UIColor clearColor];
        _endPointTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _endPointTextField.delegate = self;
        _endPointTextField.autocapitalizationType = NO;
        _endPointTextField.autocorrectionType = NO;
        _endPointTextField.placeholder = L(@"终点");
        _endPointTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        _endPointTextField.borderStyle = UITextBorderStyleNone;
        _endPointTextField.returnKeyType = UIReturnKeyDone;
        _endPointTextField.frame = CGRectMake(45, 0, 222, 36);
    }
    return _endPointTextField;
}
- (UIButton *)localBtn
{
    if (!_localBtn)
    {
        _localBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_localBtn addTarget:self action:@selector(getLocalStation) forControlEvents:UIControlEventTouchUpInside];
    }
    return _localBtn;
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
    return self.changeBusTableView.frame.size.height;
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
    [cell.contentView addSubview:self.startPointTextField];
    [cell.contentView addSubview:self.endPointTextField];
    [cell.contentView addSubview:self.localBtn];
    [cell.contentView addSubview:self.queryBtn];
    
    return cell;
}
#pragma mark-
#pragma mark Method
- (void)setAllFrame
{
    
}

- (void)getLocalStation
{
}
- (void)queryBusLine
{
}


@end
