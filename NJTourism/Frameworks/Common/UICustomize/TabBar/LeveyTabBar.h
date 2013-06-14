//
//  LeveyTabBar.h
//  FatFist
//
//  Copyright 2011 FatFish. All rights reserved.
//
//
#import <UIKit/UIKit.h>
@protocol LeveyTabBarDelegate;
@interface LeveyTabBar : UIView
{
	UIImageView *_backgroundView;
	id<LeveyTabBarDelegate> __weak   _delegate;
	NSMutableArray *_buttons;
}
@property (nonatomic, retain) UIImageView *backgroundView;
@property (nonatomic, weak) id<LeveyTabBarDelegate> delegate;
@property (nonatomic, retain) NSMutableArray *buttons;

- (id)initWithFrame:(CGRect)frame buttonImages:(NSArray *)imageArray;
- (void)selectTabAtIndex:(NSInteger)index;
- (void)removeTabAtIndex:(NSInteger)index;
- (void)insertTabWithImageDic:(NSDictionary *)dict atIndex:(NSUInteger)index;
@end
@protocol LeveyTabBarDelegate<NSObject>
@optional
- (void)tabBar:(LeveyTabBar *)tabBar didSelectIndex:(NSInteger)index; 
@end
