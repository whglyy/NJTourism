//
//  PersonalDataViewController.m
//  SuningIM
//
//  Created by wangbao on 13-6-4.
//
//

#import "PersonalDataViewController.h"
#import "LogOutCommand.h"
#import "FriendListDao.h"
@interface PersonalDataViewController ()

@end

@implementation PersonalDataViewController


- (id)init
{
    self = [super init];
    if (self) {
        // Custom initialization
    }

    return self;
}

-(void)loadView{
    [super loadView];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIView *contentView = self.view;
    CGRect frame = contentView.frame;
    frame.origin.y = 0;
    frame.size.height = frame.size.height  - UINAVIGATIONBAR_HEIGHT - UITABBAR_HEIGHT;
    self.groupTableView.frame = frame;
    [self.view addSubview:self.groupTableView];
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:[tableView indexPathForSelectedRow] animated:YES];
    NSLog(@"%d-%d" , indexPath.section,indexPath.row);
    
    if( indexPath.section == 0 )
    {
        if (indexPath.row == 0) {
            UIActionSheet *logoutActionSheet = [[UIActionSheet alloc]init];
            logoutActionSheet.delegate = self;
            [logoutActionSheet addButtonWithTitle:L(@"拍照")];
            [logoutActionSheet addButtonWithTitle:L(@"选择本地照片")];
            [logoutActionSheet addButtonWithTitle:L(@"取消")];

            [logoutActionSheet setCancelButtonIndex:2];
            [logoutActionSheet showFromRect:CGRectMake(0, self.view.bottom, 320, 120)
                                     inView:self.view animated:YES];
        }
       else if(indexPath.row == 2){
    

       }
    }
    else if( indexPath.section == 1 )
    {
        
    }
}

//每个section的title

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0) {
        [self openCanmera];
    }
    else if (buttonIndex == 1) {
        [self OpenPhoLibray];
    }
}
//打开相机
-(void)openCanmera

{
    
        
        UIImagePickerController *myImagePicker=[[UIImagePickerController alloc] init];
        
        myImagePicker.sourceType=UIImagePickerControllerSourceTypeCamera;
        
        myImagePicker.delegate=self;
        
        [self presentModalViewController:myImagePicker animated:YES];
        
    
}//打开图片库
-(void)OpenPhoLibray
{
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.delegate = self;
    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    imagePicker.allowsEditing = YES;
    imagePicker.delegate = self;
    //imagePicker.allowsImageEditing = YES;    //图片可以编辑
    [self presentModalViewController:imagePicker animated:YES];
    [self.view addSubview:imagePicker.view];
}

- (void)saveImage:(UIImage *)image{

    UIImageView *imageview = [[UIImageView alloc] initWithImage:image];
    [self.view addSubview:imageview];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    [picker dismissModalViewControllerAnimated:YES];
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    [self performSelector:@selector(UploadRequest:) withObject:image afterDelay:0.5];

}

- (void)UploadRequest:(NSDictionary *)dic
{
	NSMutableDictionary *postDataDic = [[NSMutableDictionary alloc] init];
    [postDataDic setObject:@"Description" forKey:@"HTTP Header Column"];
    [postDataDic setObject:_timestamp forKey:@"timestamp"];
    [postDataDic setObject:_jid forKey:@"senderjid"];
    [postDataDic setObject:_md5 forKey:@"md5"];
    [postDataDic setObject:@"certificate" forKey:@"certificate"];
    [postDataDic setObject:@"ContentType" forKey:@"ContentType"];
    [postDataDic setObject:@"Description" forKey:@"HTTP body Column"];
    [postDataDic setObject:@"file"  forKey:@"file"];
    
    NSString *url = @"http://imapp.suning.com/photo/upload.do";
    //    url = [NSString stringWithFormat:@"%@/%@/%@",
    //               kHostAddressForHttp,
    //               ActionArea_Login,ActionArea_SimpleLogin];
    
	SNRequest *request = [self POST:url params:postDataDic];
	request.cmdCode = CC_UserLogin;
    
}



- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissModalViewControllerAnimated:YES];

}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

//返回每一个section有多少个数据
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}


//构建这个视图
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.title = @"个人资料";

    static NSString * cellId = @"cell";
    
    PersonalDataViewCell * cell = (PersonalDataViewCell*)[tableView dequeueReusableCellWithIdentifier:cellId];
    
    if (!cell) {
        UIViewController *temporaryController = [[UIViewController alloc] initWithNibName:@"PersonalDataViewCell" bundle:nil];
        cell = (PersonalDataViewCell *)temporaryController.view;
    }
        
    
    switch(indexPath.section)
    {
        case 0:{
            if (indexPath.row == 0) {
                cell.InfoImage.imageURL = [NSURL URLWithString:[UserCenter defaultCenter].userVCard.photoUrl];
                cell.InfoImage.layer.cornerRadius = 8;
                cell.InfoImage.layer.masksToBounds = YES;
                cell.InfoLabel.text = L(@"头像：");
            }
            if (indexPath.row == 1) {
                cell.InfoLabel.text = L(@"账号：");
                cell.accessoryType = UITableViewCellAccessoryNone;
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.InfoLabelText.text = [UserCenter defaultCenter].userVCard.userName;
            }
            if (indexPath.row == 2) {
                cell.InfoLabel.text = L(@"昵称：");
                cell.InfoLabelText.text = [UserCenter defaultCenter].userVCard.nickname;
                
            }
        }
            break;
        case 1:{
            if (indexPath.row == 0) {
                cell.InfoLabel.text = L(@"性别：");
                if ([UserCenter defaultCenter].userVCard.sex == 0) {
                    cell.InfoLabelText.text = @"女";
                }
                else{
                    cell.InfoLabelText.text = @"男 ";
                }
            }
            if (indexPath.row == 1) {
                cell.InfoLabel.text = L(@"地区：");
                cell.InfoLabelText.text = [UserCenter defaultCenter].userVCard.addressDesc;
            }
            if (indexPath.row == 2) {
                cell.InfoLabel.text = L(@"个性签名：");
                cell.InfoLabelText.text = [UserCenter defaultCenter].userVCard.sign;
            }
        }
            break;
    }
    
    return cell;
}





- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
