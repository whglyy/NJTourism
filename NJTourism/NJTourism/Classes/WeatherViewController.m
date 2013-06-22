//
//  WeatherViewController.m
//  FatFisht
//
//  Created by lyywhg on 12-4-29.
//  Copyright (c) 2012年 FatFish. All rights reserved.
//

#import "WeatherViewController.h"

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
    UIToolbar* tools = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 110, 45)]; 
    [tools setBarStyle:UIBarStyleBlack];
    NSMutableArray* buttons = [[NSMutableArray alloc] initWithCapacity:2];
	
	UIBarButtonItem *btnRefresh = [[UIBarButtonItem alloc]initWithTitle:@"更新" style:UITabBarSystemItemContacts target:self action:@selector(refreshCityBtnClicked:)];

    [buttons addObject:btnRefresh]; 
    
	[tools setItems:buttons animated:NO]; 
    
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc] initWithCustomView:tools];
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

-(UIView *)DrawScrollerViews:(float)width WithLength :(float)height WithPosition :(NSInteger)position
{
    /*
     数据处理过程
     */
    //天气模型
    ModelWeather *model=[[ModelWeather alloc]init];
    model=[remainCityModel objectAtIndex:position];
    //截取相应数据 实况数据
    //    NSLog(@"%@",model._8ToForcast);
    NSArray *forcastweather=[model._8ToForcast componentsSeparatedByString:@"；"];
    //现在温度
    NSString *NowTemp=[[forcastweather objectAtIndex:0]substringFromIndex:[[forcastweather  objectAtIndex:0] rangeOfString:@"气温：" ].location+3];
    //现在风向风力
    NSString *NowWind=[[forcastweather objectAtIndex:1]substringFromIndex:[[forcastweather  objectAtIndex:1] rangeOfString:@"风向/风力：" ].location+6];
    //现在湿度
    NSString *NowHumidity=[[forcastweather objectAtIndex:2]substringFromIndex:[[forcastweather  objectAtIndex:2] rangeOfString:@"湿度：" ].location+3];
    
    //空气质量
    NSString *NowAirQuality=[[forcastweather objectAtIndex:3]substringFromIndex:[[forcastweather  objectAtIndex:3] rangeOfString:@"空气质量：" ].location+5];
    //紫外线强度
    NSString *UV=[[forcastweather objectAtIndex:4]substringFromIndex:[[forcastweather  objectAtIndex:4] rangeOfString:@"紫外线强度：" ].location+6];
    //今日总体风向风速
    NSRange rangewind24=[model._6ToWind rangeOfString:@"转"];
    int length24=rangewind24.length;
    if (length24==0) length24=0;
    else length24=rangewind24.location+1;
    NSString *toWind24=[model._6ToWind substringFromIndex:length24];
    //第二天风向风速
    NSRange rangewind48=[model._12SecWind rangeOfString:@"转"];
    int length48=rangewind48.length;
    if (length48==0) length48=0;
    else length48=rangewind48.location+1;
    NSString *toWind48=[model._12SecWind substringFromIndex:length48];
    //第三天风向风速
    NSRange rangewind72=[model._16ThiWind rangeOfString:@"转"];
    int length72=rangewind72.length;
    if (length72==0) length72=0;
    else length72=rangewind72.location+1;
    NSString *toWind72=[model._16ThiWind substringFromIndex:length72];
    
    //今天的天气状况
    NSString *ToWeatherState24;
    NSRange rangestate24=[model._5ToInfo rangeOfString:@"转"];
    int lengthstate24=rangestate24.length;
    if (lengthstate24==0) 
        ToWeatherState24=[model._5ToInfo substringFromIndex:[model._5ToInfo rangeOfString:@"日" ].location+1];
    else
        ToWeatherState24=[model._5ToInfo substringFromIndex:[model._5ToInfo rangeOfString:@"转" ].location+1];
    ToWeatherState24=[ToWeatherState24 stringByReplacingOccurrencesOfString:@" " withString:@""];
    //第二天的天气状态
    NSString *ToWeatherState48;
    NSRange rangestate48=[model._11SecInfo rangeOfString:@"转"];
    int lengthstate48=rangestate48.length;
    if (lengthstate48==0) 
        ToWeatherState48=[model._11SecInfo substringFromIndex:[model._11SecInfo rangeOfString:@"日" ].location+1];
    else
        ToWeatherState48=[model._11SecInfo substringFromIndex:[model._11SecInfo rangeOfString:@"转" ].location+1];
    ToWeatherState48=[ToWeatherState48 stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    //第三天天气状态
    NSString *ToWeatherState72;
    NSRange rangestate72=[model._15ThiInfo rangeOfString:@"转"];
    int lengthstate72=rangestate72.length;
    if (lengthstate72==0) 
        ToWeatherState72=[model._15ThiInfo substringFromIndex:[model._15ThiInfo rangeOfString:@"日" ].location+1];
    else
        ToWeatherState72=[model._15ThiInfo substringFromIndex:[model._15ThiInfo rangeOfString:@"转" ].location+1];
    ToWeatherState72=[ToWeatherState72 stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    /*
     数据可视化过程
     */
    UIView *uv=[[UIView alloc]initWithFrame:CGRectMake(width*position, 0, width, height)];
    uv.tag=1000+position;
    //竖屏
    {
        //城市名字
        UILabel *cityLabel =[[UILabel alloc] initWithFrame:CGRectMake(20, 30, 50, 30)];
        cityLabel.font=[UIFont fontWithName:@"Helvetica" size:20];
        cityLabel.text=[NSString stringWithFormat:@"南京"];
        cityLabel.backgroundColor=[UIColor clearColor];
        cityLabel.textColor=[UIColor whiteColor];
        [cityLabel setAdjustsFontSizeToFitWidth:YES];
        [uv addSubview:cityLabel];
        
        //天气更新时间
        UILabel *updateTime=[[UILabel alloc] initWithFrame:CGRectMake(20, 162, 250, 30)];
        updateTime.font=[UIFont fontWithName:@"Helvetica" size:17];
        updateTime.text=[NSString stringWithFormat:@"更新时间：%@",model._3UpdateTime];
        updateTime.backgroundColor=[UIColor clearColor];
        updateTime.textColor=[UIColor whiteColor];
        [updateTime setAdjustsFontSizeToFitWidth:YES];
        [uv addSubview:updateTime];
        
        //今天温度
        UILabel *ToTemp=[[UILabel alloc] initWithFrame:CGRectMake(20, 65, 139, 21)];
        ToTemp.font=[UIFont fontWithName:@"Helvetica" size:25];
        ToTemp.text=[NSString stringWithFormat:@"温度: %@",model._4ToTemp];
        ToTemp.backgroundColor=[UIColor clearColor];
        ToTemp.textColor=[UIColor whiteColor];
        [ToTemp setAdjustsFontSizeToFitWidth:YES];
        [uv addSubview:ToTemp];
        
        //今天实况风向风速
        UILabel *ToWind=[[UILabel alloc] initWithFrame:CGRectMake(20, 90, 175, 30)];
        ToWind.font=[UIFont fontWithName:@"Helvetica" size:25];
        ToWind.text=[NSString stringWithFormat:@"风力:%@",NowWind];
        ToWind.backgroundColor=[UIColor clearColor];
        ToWind.textColor=[UIColor whiteColor];
        [ToWind setAdjustsFontSizeToFitWidth:YES];
        [uv addSubview:ToWind];
        
        //今天湿度
        UILabel *ToHumidity=[[UILabel alloc] initWithFrame:CGRectMake(20, 128, 139, 21)];
        ToHumidity.font=[UIFont fontWithName:@"Helvetica" size:18];
        ToHumidity.text=[NSString stringWithFormat:@"湿度:%@",NowHumidity];
        ToHumidity.backgroundColor=[UIColor clearColor];
        ToHumidity.textColor=[UIColor whiteColor];
        [ToHumidity setAdjustsFontSizeToFitWidth:YES];
        [uv addSubview:ToHumidity];
        
        //今天的天气状况
        UILabel *ToweatherState=[[UILabel alloc] initWithFrame:CGRectMake(200, 10, 128, 97)];
        ToweatherState.font=[UIFont fontWithName:@"Helvetica" size:45];
        ToweatherState.text=ToWeatherState24;
        ToweatherState.backgroundColor=[UIColor clearColor];
        ToweatherState.textColor=[UIColor whiteColor];
        [ToweatherState setAdjustsFontSizeToFitWidth:YES];
        [uv addSubview:ToweatherState];
        
        //目前的温度实况
        UILabel *Temp=[[UILabel alloc] initWithFrame:CGRectMake( 510, 360, 92, 43)];
        Temp.font=[UIFont fontWithName:@"Helvetica" size:40];
        Temp.text=[NSString stringWithFormat:@"%@",NowTemp];
        Temp.backgroundColor=[UIColor clearColor];
        Temp.textColor=[UIColor colorWithRed:246.0f/255.0f green:131.0f/255.0f blue:22.0f/255.0f alpha:1.0f];
        [Temp setAdjustsFontSizeToFitWidth:YES];
        [uv addSubview:Temp];
        
        
        //今天天气的图片资源
        UIImageView *ToimgView=[[UIImageView alloc] initWithFrame:CGRectMake(220, 100, 60, 60)];
        ToimgView.image=[UIImage imageNamed:[NSString stringWithFormat:@"%@.png",[model._7ToImgState substringToIndex:[model._7ToImgState rangeOfString:@"." ].location]]];
        
        //第一天数据背景图
        [uv addSubview:ToimgView];        
    }
    
    return uv;
}


//对星期进行数据解析翻译
-(NSString *)getWeek:(NSString *)date
{
    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
    [inputFormatter setDateFormat:@"yyyy-MM-dd" ];
    NSDate *formatterDate = [inputFormatter dateFromString:date];
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setDateFormat:@"EEEE"];
    NSString *newDateString = [outputFormatter stringFromDate:formatterDate];
    //    NSLog(@"%@",newDateString);
    if ([newDateString isEqualToString:@"Monday"])
    {
        return @"星期一";
    }
    else if([newDateString isEqualToString:@"Tuesday"])
    {
        return @"星期二";
    }
    else if([newDateString isEqualToString:@"Wednesday"])
    {
      return @"星期三";  
    }
    else if([newDateString isEqualToString:@"Thursday"])
    {
        return @"星期四";
    }
    else if([newDateString isEqualToString:@"Friday"])
    {
        return @"星期五";
    }
    else if([newDateString isEqualToString:@"Saturday"])
    {
        return @"星期六";
    }
    else if([newDateString isEqualToString:@"Sunday"])
    {
        return @"星期日";
    }
    else
    {
        return newDateString;
    }
}

- (void)viewDidUnload
{
    [self setBackgroundImageView:nil];
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
