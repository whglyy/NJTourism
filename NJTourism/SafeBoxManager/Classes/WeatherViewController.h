//
//  WeatherViewController.h
//  FatFisht
//
//  Created by lyywhg on 12-4-29.
//  Copyright (c) 2012年 FatFish. All rights reserved.
//

#import "weatherResoure.h"
#import "sqlService.h"

@interface WeatherViewController : CommonViewController<WeatherResoureDelegate,UIScrollViewDelegate>
{
   	
    UIPopoverController *popoverCityController;
	UIPopoverController *popoverRemainCityController;
    weatherResoure *resoure;
    UIScrollView *scrollView;
    NSMutableArray *remainCityModel;
    float ScreenWidth;
    float ScreenHeight;
    UIAlertView *baseAlert;
}

@property (strong, nonatomic) IBOutlet UIImageView *backgroundImageView;

@property (nonatomic,retain) UIPopoverController *popoverCityController;
@property (nonatomic,retain) UIPopoverController *popoverRemainCityController;
@property (nonatomic,retain) weatherResoure *resoure;
@property (nonatomic,retain) UIScrollView *scrollView;
@property (nonatomic,retain) NSMutableArray *remainCityModel;
@property (nonatomic,retain) UIAlertView *baseAlert;
- (void)initalToolbar;
- (void) initScrollerView;
-(UIView *)DrawScrollerViews:(float)width WithLength :(float)height WithPosition :(NSInteger)position;
-(NSString *)getWeek:(NSString *)date;
-(void)loading;
- (void) loadingDismiss;
-(void)startUPTheBackgroudJob:(NSString *)cityname;
- (void)startTheBackgroundJob:(NSString *)CityName;
@end
