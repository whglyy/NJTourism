//
//  UITableViewMoreCell.h
//  FatFist
//
//  Copyright 2011 FatFish. All rights reserved.
//
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
