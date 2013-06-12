//
//  UITableViewMoreCell.h
//  FatFist
//
//  Created by lyywhg on 10/4/11.
//  Copyright (c) 2011 FatFist. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UITableViewMoreCell : UITableViewCell{
    
    UIActivityIndicatorView* _activityIndicatorView;
    
    BOOL _animating;
    
    NSString *_title;
}


@property(nonatomic,retain) UIActivityIndicatorView* activityIndicatorView;

@property(nonatomic,assign) BOOL animating;

@property(nonatomic,retain) NSString *title;


@end
