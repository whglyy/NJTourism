//
//  HttpConstant.h
//  FatFist
//
//  Created by lyywhg on 13-5-24.
//
//


#define HTTP_TIMEOUT    kHttpTimeoutSeconds

typedef enum CmdCode
{
	// 系统命令
	CC_VersionCheck             = 0x0001,//3.8.5 检查版本号 Action:SNMobileGetClientVersionView
	CC_NetCheck					= 0x0002,// 网络检测, 无接口
    //文件接口
    CC_FileDownload             = 0x0011,
    CC_GetDownloadUrl           = 0x0012,
    CC_FIleList                 = 0x0013,//文件列表接口
    CC_FileUpdate               = 0x0014,//重命名文件接口
    CC_FileMove                 = 0x0015,//移动文件接口
    CC_FileDestory              = 0x0016,//删除文件接口
    CC_FileSearch               = 0x0017,//文件查找接口
    CC_FileType                 = 0x0018,//文件分类接口
    CC_FileRecycle              = 0x0019,//回收站文件列表接口
    CC_FileTrash                = 0x001A,//彻底删除文件接口
    CC_FileRecovery             = 0x001B,//还原已删除文件接口
    CC_FileUpload               = 0x001C,//文件上传接口
    CC_FileUploadUrl              = 0x001D,//获取上传文件ip接口
    //文件夹接口
    CC_FolderMethod             = 0x0021,
    CC_BoxMethod                = 0x0022,
    CC_BoxSetMethod             = 0x0023,
    CC_BoxLoginMethod           = 0x0023,
    //用户相关接口
    CC_UserLogin                = 0x0031,
    CC_CapacityInfo             = 0x0032,
    CC_UserCapacityInfo         = 0x0033,
    CC_Register                 = 0x0034,
    CC_VerCode                  = 0x0035,
    CC_GetVerCode               = 0x0036,

    CC_Logout                  = 0x0037,
    CC_BeginVerify             = 0x0038,
    CC_StopVerify              = 0x0039,
    CC_ReadPhone               = 0x0040,
    CC_Upload                  = 0x0041,
    CC_Upgrade                 = 0x0042,

    
} E_CMDCODE;


//需要登录的接口
static const int CC_NEED_LOGIN_QUEUE[] = 
{
    //CmdCodeValue,
};

//需要重写cookie的接口，例如彩票服务器，酒店服务器的域名不同，需要重写下cookie，否则cookie不能带过去
static const int CC_NEED_COOKIE_QUEUE[] = 
{
 //CMDCodeKey,
};
