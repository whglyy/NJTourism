//
//  CommonView.m
//  FatFist
//
//  Copyright 2011 FatFish. All rights reserved.
//
//

#import "CommonView.h"

@implementation CommonView

@synthesize tableView = _tableView;
@synthesize groupTableView = _groupTableView;
@synthesize tpTableView = _tpTableView;
@synthesize owner = _owner;


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)init {
    self = [super init];
    if (self) {

    }
    return self;
}

- (id)initWithOwner:(id)owner
{
    self = [super init];
    if (self) {
        self.owner = owner;
    }
    return self;
}


- (UITableView *)tableView{
	
	
	if(!_tableView){
		
		_tableView = [[UITableView alloc] initWithFrame:CGRectZero
												  style:UITableViewStylePlain];    
		
		[_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
		
		[_tableView setIndicatorStyle:UIScrollViewIndicatorStyleWhite];
		
		_tableView.scrollEnabled = YES;
		
		_tableView.userInteractionEnabled = YES;
		
		_tableView.backgroundColor = [UIColor clearColor];
        
        _tableView.backgroundView = nil;
		
        _tableView.delegate = self.owner;
        
        _tableView.dataSource = self.owner;
	}
	
	return _tableView;
}

- (UITableView *)groupTableView{
	
	
	if(!_groupTableView){
		
        _groupTableView = [[UITableView alloc] initWithFrame:CGRectZero
                                                       style:UITableViewStyleGrouped];    
		
		
		[_groupTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
		
		[_groupTableView setIndicatorStyle:UIScrollViewIndicatorStyleWhite];
		
		_groupTableView.scrollEnabled = YES;
		
		_groupTableView.userInteractionEnabled = YES;
		
		_groupTableView.backgroundColor = [UIColor clearColor];
        
        _groupTableView.backgroundView = nil;
        
        _groupTableView.delegate = self.owner;
        
        _groupTableView.dataSource = self.owner;
	}
	
	return _groupTableView;
}

- (TPKeyboardAvoidingTableView *)tpTableView
{
    if(!_tpTableView)
    {
		
		_tpTableView = [[TPKeyboardAvoidingTableView alloc] initWithFrame:CGRectZero
                                                                    style:UITableViewStyleGrouped];    
		
		[_tpTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
		
		[_tpTableView setIndicatorStyle:UIScrollViewIndicatorStyleWhite];
		
		_tpTableView.scrollEnabled = YES;
		
		_tpTableView.userInteractionEnabled = YES;
		
		_tpTableView.backgroundColor = [UIColor clearColor];
		
        _tpTableView.backgroundView = nil;
        
        _tpTableView.delegate = self.owner;
        
        _tpTableView.dataSource = self.owner;
	}
	
	return _tpTableView;
}
- (void)presentSheet:(NSString*)indiTitle
{
    [self showTipViewAtCenter:indiTitle];
}
- (void)showTipViewAtCenter:(NSString*)indiTitle{
	
	BBTipView *activityView = [self getTipView];
    
    if (activityView) {
        [activityView dismiss:NO];
    }
    
	activityView = [[BBTipView alloc] initWithView:self message:indiTitle posY:80] ;
    
    activityView.tag = toolViewTag;
    
    [activityView show];
	
}

@end
