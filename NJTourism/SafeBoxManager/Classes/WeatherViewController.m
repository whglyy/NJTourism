//
//  WeatherViewController.m
//  FatFisht
//
//  Created by lyywhg on 12-4-29.
//  Copyright (c) 2012年 FatFish. All rights reserved.
//

#import "WeatherViewController.h"

#import "TransferDateToWeekday.h"


@interface WeatherViewController()

@property (weak, nonatomic) IBOutlet UILabel *cityNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *weekdayLabel;
@property (weak, nonatomic) IBOutlet UIImageView *todayWeatherImageView;
@property (weak, nonatomic) IBOutlet UILabel *weatherLabel;
@property (weak, nonatomic) IBOutlet UILabel *temptureLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalTemptureLabel;
@property (weak, nonatomic) IBOutlet UILabel *moistureLabel;
@property (weak, nonatomic) IBOutlet UILabel *windLabel;

@property (weak, nonatomic) IBOutlet UILabel *ultravioletRaysLabel;

@property (weak, nonatomic) IBOutlet UILabel *onedayAfterLabel;
@property (weak, nonatomic) IBOutlet UILabel *twodayAfterLabel;
@property (weak, nonatomic) IBOutlet UILabel *threedayAfterLabel;

@property (weak, nonatomic) IBOutlet UIImageView *onedayAfterWeatherImage;
@property (weak, nonatomic) IBOutlet UIImageView *twodayAfterWeatherImage;
@property (weak, nonatomic) IBOutlet UIImageView *threedayAfterWeatherImage;
@property (weak, nonatomic) IBOutlet UILabel *onedayAfterTemptureLabel;
@property (weak, nonatomic) IBOutlet UILabel *twodayAfterTemptureLabel;
@property (weak, nonatomic) IBOutlet UILabel *threedayAfterTemptureLabel;


@end

@implementation WeatherViewController

@synthesize popoverCityController;
@synthesize popoverRemainCityController;
@synthesize resoure;
@synthesize scrollView;
@synthesize remainCityModel;
@synthesize baseAlert;

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
}

#pragma mark-
#pragma mark Init & Add
- (UIImageView *)backgroundImageView
{
    if (!_backgroundImageView)
    {
        _backgroundImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"NJT_Weather_Background.png"]];
        
    }
    return _backgroundImageView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.backgroundImageView.frame = self.view.frame;
    self.backgroundImageView.image = [UIImage imageNamed:@"NJT_Weather_Background.png"];
    
    
    
    [self canPush];
   
    
    [self initalToolbar];
    //实例化 获取天气的实例类
    resoure=[[weatherResoure alloc]init];
    resoure.delegate=self;
    ScreenWidth=768;
    ScreenHeight=1024;
    
    [self citySelected:@"南京"];
    
}

//初始化工具条
- (void)initalToolbar
{
	UIBarButtonItem *btnRefresh = [[UIBarButtonItem alloc]initWithTitle:@"更新" style:UITabBarSystemItemContacts target:self action:@selector(refreshCityBtnClicked:)];
    self.navigationItem.rightBarButtonItem =btnRefresh;
}

-(void)loading
{
	baseAlert = [[UIAlertView alloc] initWithTitle:@"正在获取天气数据，请稍候！" message:nil delegate:self cancelButtonTitle:nil otherButtonTitles: nil];
    [baseAlert show];
	
	// Create and add the activity indicator
	UIActivityIndicatorView *aiv = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
	aiv.center = CGPointMake(baseAlert.bounds.size.width / 2.0f, baseAlert.bounds.size.height - 40.0f);
	[aiv startAnimating];
	[baseAlert addSubview:aiv];
}

//隐藏加载动画窗口
- (void) loadingDismiss
{
	[baseAlert dismissWithClickedButtonIndex:0 animated:NO];
}

//刷新数据
- (void)refreshCityBtnClicked :(id)sender
{
    [self loading];
    int location=((int)scrollView.contentOffset.x)/((int)ScreenWidth);
    sqlService *sqlservice=[[sqlService alloc]init];
    remainCityModel=[sqlservice getweatherinfo];
    NSString *currentCity=((ModelWeather *)[remainCityModel objectAtIndex:location])._1CityName;
    [NSThread detachNewThreadSelector:@selector(startUPTheBackgroudJob:) toTarget:self withObject:currentCity];
}
//增加一个城市的天气模型
- (void)addWeatherResoure:(ModelWeather *)model
{
    sqlService *sqlservice=[[sqlService alloc]init];
    [sqlservice insertModel:model];
    
    remainCityModel=[sqlservice getweatherinfo];
    for (int i=0; i<[remainCityModel count]-1; i++) {
        [(UIView *)[scrollView viewWithTag:1000+i] removeFromSuperview];
    }
    
    //remainCityModel=[sqlservice getweatherinfo];
    scrollView.contentSize=CGSizeMake(ScreenWidth*[remainCityModel count],ScreenHeight);
    for (int j=0; j<[remainCityModel count]; j++) {
        UIView *uv=[self DrawScrollerViews:ScreenWidth WithLength:ScreenHeight WithPosition:j];
        [scrollView addSubview:uv];
    }
    [scrollView setContentOffset:CGPointMake(ScreenWidth*([remainCityModel count]-1), 0)];
    [self loadingDismiss];
    
}
//选中 所要添加的城市 scorllerview 重绘
- (void)citySelected:(NSString *)cityName;
{
    sqlService *sqlservice=[[sqlService alloc]init];
    NSMutableArray *remainList=[[NSMutableArray alloc]init];
    remainList=[sqlservice getweatherinfo];
    BOOL ISCitySaved=NO;
    for (int i=0; i<[remainList count]; i++)
    {
        if ([((ModelWeather *)[remainList objectAtIndex:i])._1CityName isEqualToString:cityName]) {
            ISCitySaved=YES;
            [scrollView setContentOffset:CGPointMake(ScreenWidth*i, 0) animated:YES];
            break;
        }
    }
    //获取天气源
    //如果没有保存本城市的天气信息,则下载数据
    if (!ISCitySaved)
    {
        [self loading];
        [NSThread detachNewThreadSelector:@selector(startTheBackgroundJob:) toTarget:self withObject:cityName];
    }
    [popoverCityController dismissPopoverAnimated:YES];
    
}
//后台下载城市天气
- (void)startTheBackgroundJob:(NSString *)CityName
{
    @autoreleasepool
    {
        [resoure GetWeatherByCityName:CityName update:NO];
    }
}
//后台更新城市天气
-(void)startUPTheBackgroudJob:(NSString *)cityname
{
    @autoreleasepool
    {
        [resoure GetWeatherByCityName:cityname update:YES];
    }
}

//更新一个城市的天气
- (void)upWeatherResource:(ModelWeather *)model
{
    sqlService *sql=[[sqlService alloc]init];
    [sql updateTestList:model];
    remainCityModel=[sql getweatherinfo];
    for (int i=0; i<[remainCityModel count]; i++) {
        [(UIView *)[scrollView viewWithTag:1000+i] removeFromSuperview];
    }
    scrollView.contentSize=CGSizeMake(ScreenWidth*[remainCityModel count],ScreenHeight);
    for (int j=0; j<[remainCityModel count]; j++)
    {
        UIView *uv=[self DrawScrollerViews:ScreenWidth WithLength:ScreenHeight WithPosition:j];
        [scrollView addSubview:uv];
    }
    [self loadingDismiss];
}

-(void)getweatherfaild
{
    [self loadingDismiss];
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"网络连接失败,请检查网络" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
}

//初始化ScrollerView
-(void)initScrollerView
{
    sqlService *sql=[[sqlService alloc]init];
    remainCityModel = [[NSMutableArray alloc]init];
    remainCityModel=[sql getweatherinfo];
    scrollView=[[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
	scrollView.pagingEnabled = YES;
	scrollView.delegate =self;
    scrollView.backgroundColor=[UIColor clearColor];
    [self.view addSubview:scrollView];
    scrollView.contentSize=CGSizeMake(ScreenWidth*[remainCityModel count],ScreenHeight);
    for (int i=0; i<[remainCityModel count]; i++)
    {
        UIView *uv=[self DrawScrollerViews:ScreenWidth WithLength:ScreenHeight WithPosition:i];
        [scrollView addSubview:uv];
    }
    [scrollView setContentOffset:CGPointMake(0, 0)];
}

- (void)updateWeather
{
    _cityNameLabel.text = L(@"南京");
    
    //设置日期
    _dateLabel.text = [TransferDateToWeekday getLocalTodayDate];
    _weekdayLabel.text = [TransferDateToWeekday getWeek:_dateLabel.text];
    
    //天气模型
    ModelWeather *model=[[ModelWeather alloc]init];
    model=[remainCityModel objectAtIndex:0];
    
    //今天的天气状况
    NSString *ToWeatherState24;
    NSRange rangestate24=[model._5ToInfo rangeOfString:@"转"];
    int lengthstate24=rangestate24.length;
    if (lengthstate24==0)
    {
        ToWeatherState24=[model._5ToInfo substringFromIndex:[model._5ToInfo rangeOfString:@"日" ].location+1];
    }
    else
    {
        ToWeatherState24=[model._5ToInfo substringFromIndex:[model._5ToInfo rangeOfString:@"转" ].location+1];
    }
    ToWeatherState24=[ToWeatherState24 stringByReplacingOccurrencesOfString:@" " withString:@""];
    _weatherLabel.text = ToWeatherState24;
    
    //今天天气的图片资源
    _todayWeatherImageView.image=[UIImage imageNamed:[NSString stringWithFormat:@"%@.png",[model._7ToImgState substringToIndex:[model._7ToImgState rangeOfString:@"." ].location]]];
    //气温
    _temptureLabel.text = model._4ToTemp;
    NSArray *tmpArray = [model._4ToTemp componentsSeparatedByString:@"/"];
    _totalTemptureLabel.text = [tmpArray lastObject];
    
    //现在湿度
    NSArray *forcastweather=[model._8ToForcast componentsSeparatedByString:@"；"];
    NSString *NowHumidity=[[forcastweather objectAtIndex:2]substringFromIndex:[[forcastweather  objectAtIndex:2] rangeOfString:@"湿度：" ].location+3];
    _moistureLabel.text = NowHumidity;
    
    //现在风向风力
    NSString *nowWind=[[forcastweather objectAtIndex:1]substringFromIndex:[[forcastweather  objectAtIndex:1] rangeOfString:@"风向/风力：" ].location+6];
    _windLabel.text = nowWind;
    
    //紫外线强度
    NSString *UV=[[forcastweather objectAtIndex:4]substringFromIndex:[[forcastweather  objectAtIndex:4] rangeOfString:@"紫外线强度：" ].location+6];
    _ultravioletRaysLabel.text = [NSString stringWithFormat:@"%@  %@", L(@"紫外线"), UV];
}


-(UIView *)DrawScrollerViews:(float)width WithLength :(float)height WithPosition :(NSInteger)position
{
    [self updateWeather];
    return nil;
}

- (void)viewDidUnload
{
    [self setBackgroundImageView:nil];
    [self setCityNameLabel:nil];
    [self setDateLabel:nil];
    [self setWeekdayLabel:nil];
    [self setTodayWeatherImageView:nil];
    [self setWeatherLabel:nil];
    [self setTemptureLabel:nil];
    [self setTotalTemptureLabel:nil];
    [self setMoistureLabel:nil];
    [self setWindLabel:nil];
    [self setUltravioletRaysLabel:nil];
    [self setOnedayAfterLabel:nil];
    [self setTwodayAfterLabel:nil];
    [self setThreedayAfterLabel:nil];
    [self setOnedayAfterWeatherImage:nil];
    [self setTwodayAfterWeatherImage:nil];
    [self setThreedayAfterWeatherImage:nil];
    [self setOnedayAfterTemptureLabel:nil];
    [self setTwodayAfterTemptureLabel:nil];
    [self setThreedayAfterTemptureLabel:nil];
    
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self initScrollerView];
}

@end
