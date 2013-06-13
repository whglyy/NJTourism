//
//  CommonView.h
//  FatFist
//
//  Created by lyywhg on 12-8-17.
//  Copyright (c) 2012年 FatFist. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TPKeyboardAvoidingTableView.h"
#import "CommonViewController.h"

@interface CommonView : UIView
{
    UITableView             *_tableView;
    
    UITableView             *_groupTableView;
    
    TPKeyboardAvoidingTableView     *_tpTableView;
    
    id   __weak _owner;
}

@property (nonatomic, weak) id  owner;

@property (nonatomic, retain) UITableView       *tableView;

@property (nonatomic, retain) UITableView       *groupTableView;

@property (nonatomic, retain) UITableView       *tpTableView;


- (id)initWithOwner:(id)owner;
- (void)presentSheet:(NSString*)indiTitle;

@end
