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
        _startPointTextField.frame = CGRectMake(15, 20, 200, 36);
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
        _endPointTextField.frame = CGRectMake(15, 65, 200, 36);
    }
    return _endPointTextField;
}
- (UIButton *)localBtn
{
    if (!_localBtn)
    {
        _localBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _localBtn.backgroundColor = [UIColor clearColor];
        [_localBtn setBackgroundImage:[UIImage imageNamed:@"stop_locate.png"] forState:UIControlStateNormal];
        [_localBtn addTarget:self action:@selector(getLocalStation) forControlEvents:UIControlEventTouchUpInside];
        _localBtn.frame = CGRectMake(200, 20, 39, 36);
    }
    return _localBtn;
}
- (UIButton *)queryBtn
{
    if (!_queryBtn)
    {
        _queryBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _queryBtn.backgroundColor = [UIColor clearColor];
        [_queryBtn setBackgroundImage:[UIImage imageNamed:@"button_d_search.png"] forState:UIControlStateNormal];
        [_queryBtn setTitle:L(@"查询") forState:UIControlStateNormal];
        [_queryBtn addTarget:self action:@selector(queryBusLine) forControlEvents:UIControlEventTouchUpInside];
        _queryBtn.frame = CGRectMake(20, 150, 200, 40);
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
    
    UIImageView *tmpUserIV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"user_textfield_input.png"]];
    UIImageView *nameLogoI = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"user_textfield_input.png"]];
    tmpUserIV.frame = CGRectMake(10, 20, 200, 36);
    tmpUserIV.layer.cornerRadius = 10.0f;
    nameLogoI.layer.cornerRadius = 10.0f;
    [cell.contentView addSubview:tmpUserIV];
    nameLogoI.frame = CGRectMake(10, 65, 220, 36);
    [cell.contentView addSubview:nameLogoI];
    
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
    self.changeBusTableView.frame = CGRectMake(0, 0, 260, 200);
}

- (void)getLocalStation
{
}
- (void)queryBusLine
{
    if (_cDelegate && [_cDelegate respondsToSelector:@selector(checkBusLine)])
    {
        [_cDelegate checkBusLine];
    }
}


@end
