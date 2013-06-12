//
//  OfflineViewController.m
//  SuningIM
//
//  Created by wangbao on 13-6-5.
//
//

#import "OfflineViewController.h"

@interface OfflineViewController ()

@end

@implementation OfflineViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (IBAction)UploadRequest:(id)sender {
    
    
    NSString *tmpImg = [[NSBundle mainBundle] pathForResource:@"11" ofType:@"jpg"];
    NSDate *MYDate = [NSDate date];
    
    NSMutableData *body = [NSMutableData data];
    
    NSData *md5 = [NSData dataWithContentsOfFile:tmpImg];
    NSString *md5String = [md5 md5HexDigest];
    
    NSMutableURLRequest *httpheader = [[NSMutableURLRequest alloc] init];
    [httpheader addValue:MYDate forHTTPHeaderField:@"timestamp"];
    [httpheader addValue:@"jid1" forHTTPHeaderField:@"senderjid"];
    [httpheader addValue:@"jid2" forHTTPHeaderField:@"receiverjid"];
    [httpheader addValue:md5String forHTTPHeaderField:@"md5"];
    [httpheader addValue:@"false" forHTTPHeaderField:@"isgroup"];
    [httpheader addValue:@"sitopenfireserver01.cnsuning.com" forHTTPHeaderField:@"groupserver"];
    [httpheader addValue:@"ContentType" forHTTPHeaderField:@"ContentType"];
    
    NSMutableURLRequest *httpbody = [[NSMutableURLRequest alloc] init];
    [httpbody setHTTPBody:body];
    
    [httpheader addValue:@"file" forHTTPHeaderField:@"file"];
    

    
    NSString *url = @"http://imapp.suning.com/photo/upload.do";
    //    url = [NSString stringWithFormat:@"%@/%@/%@",
    //               kHostAddressForHttp,
    //               ActionArea_Login,ActionArea_SimpleLogin];
    
	SNRequest *request = [self POST:url params:httpheader];
	request.cmdCode = CC_Upload;

}


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
