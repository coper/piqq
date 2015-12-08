//
//  SignInViewController.m
//  patientv1.0
//
//  Created by liyongli on 15-7-1.
//  Copyright (c) 2015年 ask. All rights reserved.
//

#import "SignInViewController.h"
#import "RegisterViewController.h"
#import "RecoverViewController.h"
#import "YsnPickImage.h"
#import "RequestInfo.h"



#define URL @"http://hq.sinajs.cn/list=s_sz300006"
//#define URL @"http://blog.csdn.net/simon803/article/details/7784682"




@interface SignInViewController ()
{
    InsetsTextField *_text;
    UIView *loadView;
    UIImageView *logoImage;
    
    
    YsnPickImage *_ysnPickImage;
}
@end

@implementation SignInViewController

#pragma mark -- life cycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth,kScreenHeight)];
    [scrollView setBackgroundColor:[UIColor whiteColor]];
    scrollView.scrollEnabled = NO;
    [self.view addSubview:scrollView];
    //头像view
    UIView *hearView = [[UIView alloc]initWithFrame:CGRectMake(0,0,kScreenWidth,kScreenHeight/11*4)];
    [hearView setBackgroundColor:[UIColor colorWithRed:246/255.0 green:75/255.0 blue:80/255.0 alpha:1]];
    hearView.userInteractionEnabled = YES;
    [scrollView addSubview:hearView];
    
    //logo
    logoImage = [[UIImageView alloc]initWithFrame:CGRectMake(0,0,H(hearView)/5*2,H(hearView)/5*2)];
    //logoImage.image = [UIImage imageNamed:@"logo"];
    logoImage.image = [UIImage imageNamed:@"logoY"];
    logoImage.center = CGPointMake(W(hearView)/2, H(hearView)/2+kStatusH);
    [hearView addSubview:logoImage];
    
    
    
    //循环创建TextField
    for(int i=0;i<2;i++){
        UIView *addImageView = [[UIView alloc]initWithFrame:CGRectMake(kNavH*0.7,(H(self.view)/11+kScreenHeight/22)*i+YH(hearView)+kScreenHeight/15,kScreenWidth-kNavH*1.5, H(self.view)/11)];
        [addImageView setBackgroundColor:[UIColor whiteColor]];
        addImageView.tag = 230+i;
        addImageView.layer.cornerRadius = 5;
        addImageView.layer.borderWidth = 1;
        addImageView.layer.borderColor = [UIColor lightGrayColor].CGColor;
        UIImageView *ioconImage = [[UIImageView alloc]initWithFrame:CGRectMake(0,0,25,25)];
        
        if (i==0) {
            ioconImage.image = [UIImage imageNamed:@"yhm"];
        }else{
            ioconImage.image = [UIImage imageNamed:@"mm"];
            ioconImage.frame = CGRectMake(0, 0,20, 25);
            
        }
        ioconImage.center = CGPointMake(H(self.view)/22, H(addImageView)/2);
        [addImageView addSubview:ioconImage];
        [scrollView addSubview:addImageView];
        //使用工厂类
        
        _text=[[InsetsTextField alloc]initWithFrame:CGRectMake(H(self.view)/15,0,W(self.view)-kNavH*1.5-H(self.view)/11,H(self.view)/11)];
        _text.backgroundColor = [UIColor clearColor];
        _text.font = kFont(18);
        [_text setTextColor:[LibFun hexStringToColor:@"#cccccc"]];
        _text.tag = 130 + i;
        _text.delegate=self;
        _text.returnKeyType  =UIReturnKeyDone;
        _text.selected = YES;
        _text.layer.cornerRadius = 2;
        if(i==0){
            _text.placeholder=@"手机号";
            _text.keyboardType=UIKeyboardTypeNumberPad;
        }
        else{
            _text.placeholder=@"密码";
            
            _text.secureTextEntry=YES;
        }
        [addImageView addSubview:_text];
        
    }

    //创建登录按钮
    UIButton *login=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    [login setTitle:@"登录" forState:(UIControlStateNormal)];
    [login setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    login.backgroundColor = [LibFun hexStringToColor:@"#fa4f51"];
    [login addTarget:self action:@selector(buttonClicked:) forControlEvents:(UIControlEventTouchUpInside)];
    login.layer.cornerRadius = 3;
    login.frame=CGRectMake(kNavH*0.7,YH([self.view viewWithTag:230+1])+H(self.view)/13,W(self.view)-kNavH*1.5, H(self.view)/11);
    login.titleLabel.font = kFont(18);
    [login setTitleColor:[LibFun hexStringToColor:@"#ffffff"] forState:UIControlStateNormal];
    [scrollView addSubview:login];
    
    //注册button
    UIButton *registerButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [registerButton setTitle:@"免费注册" forState:UIControlStateNormal];
    registerButton.titleLabel.adjustsFontSizeToFitWidth=YES;
    
    registerButton.backgroundColor = [UIColor clearColor];
    [registerButton  setTitleColor:[LibFun hexStringToColor:@"#fa4f51"] forState:UIControlStateNormal];
    [registerButton  addTarget:self action:@selector(registerButton:) forControlEvents:UIControlEventTouchUpInside];
    registerButton.frame = CGRectMake(X(login),YH(login)+30, W(login)/4, H(login));
    registerButton.titleLabel.font = kFont(18);
    [scrollView addSubview:registerButton];
    
    //忘记密码
    UIButton *passwordButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [passwordButton setTitle:@"忘记密码?" forState:UIControlStateNormal];
    passwordButton.titleLabel.adjustsFontSizeToFitWidth=YES;
    [passwordButton  setTitleColor:[LibFun hexStringToColor:@"#fa4f51"] forState:UIControlStateNormal];
    [passwordButton addTarget:self action:@selector(passwordButton:) forControlEvents:UIControlEventTouchUpInside];
    passwordButton.titleLabel.font = kFont(18);
    passwordButton.frame = CGRectMake(X(login)+W(login)/4*3-10,YH(login)+30,  W(login)/4+10, H(login));
    [scrollView addSubview:passwordButton];
    scrollView.contentSize = CGSizeMake(kScreenWidth,YH(passwordButton)+10);
    if (YH(passwordButton)<kScreenHeight) {
        scrollView.contentSize = CGSizeMake(kScreenWidth, kScreenHeight+10);
    }
    
    
    _ysnPickImage = [[YsnPickImage alloc] init];
}


-(void)buttonClicked:(UIButton *)buttvon
{
    //NSArray *arry=[NSArray arrayWithObject:@"sss"];
    //NSLog(@"%@",[arry objectAtIndex:1]);

    //[self pushController:[RecoverViewController class] withInfo:nil withTitle:@"康复"];
    //return;
    //常见异常1---不存在方法引用
    //[self performSelector:@selector(thisMthodDoesNotExist) withObject:nil];
    
    //常见异常2---键值对引用nil
    //[[NSMutableDictionary dictionary] setObject:nil forKey:@"nil"];
    
    //常见异常3---数组越界
    //[[NSArray array] objectAtIndex:1];
    
    //常见异常4---memory warning 级别3以上
    
    //其他大家去想吧
    
    //[LibuiFun showLoadingView:self.view errorMsg:@"加载中..."];

    //loadView = [LibuiFun showLoadingView:scrollView errorMsg:nil];
    //loadView = [LibuiFun showLoadingViewB:scrollView errorMsg:@"手机号码不能为空"];
    
    //[self performSelector:@selector(setPullTableIsRefreshing:) withObject:FALSE afterDelay:3.0];
    
    //选择图片
    //[_ysnPickImage addSelectWithTarget:self action:@selector(selectImageCallBack:)];
    
    
//    //圆角头像
//     UIImageView *_avatarView = new UIImageView(new RectangleF(_blockSpace, _blockSpace, 2 * _avatarRadius, 2 * _avatarRadius));
//    UIImage img = UIImage.FromFile("profile-pic.jpg");
//    _avatarView.Layer.Contents = img.CGImage;
//     
//    _avatarView.Layer.MasksToBounds = true;//如果没有将MasksToBounds设置为true，图片圆角无效
//    _avatarView.Layer.CornerRadius = _avatarRadius;
//     
//     _avatarView.UserInteractionEnabled = true;//用户互动属性()
//    _avatarView.AddGestureRecognizer(new UITapGestureRecognizer(onClickImage));
  
    //Get
    RequestInfo *info = [[RequestInfo alloc]init];
    info.urlStr = @"http://apis.baidu.com/txapi/mvtp/meinv?num=10";
    [info setHeaderField:@"apikey" headValue:@"aacd39c18e81ba3dde231b6f1ba599bf"];
    info.wmDelegate = self;
    [info setParamKey:@"key" paramValue:@"value"];
    [info setParamKey:@"key2" paramValue:@"value"];
    //标记网络请求，可选参数
    info.flagStr = @"login";
    info.localName = @"signInView";
    
    //[[WmHttpRequestManager shareManager] startAsyncHttpGetWithRequestInfo:info];

    
    
    //register
//    RequestInfo *info1 = [[RequestInfo alloc]init];
//    info1.urlStr = @"http://60.221.254.212/ws.cdn.baidupcs.com/file/d33e7e5cff44f6668b05217a45140a15?bkt=p2-qd-950&xcode=1bf0296b6c7302edd7945b2e9c95d646709c6a98b22f9a3dd796109456bd1356&fid=1359978669-250528-696526245503315&time=1438329758&sign=FDTAXERLBH-DCb740ccc5511e5e8fedcff06b081203-7PxzQ7wBalMKapYEWc7yKbcmLbw%3D&to=hc&fm=Nin,B,U,nc&sta_dx=2387&sta_cs=2684&sta_ft=dmg&sta_ct=7&fm2=Ningbo,B,U,nc&newver=1&newfm=1&secfm=1&flow_ver=3&sl=83296335&expires=8h&rt=pr&r=777269120&mlogid=2360637020&vuk=1359978669&vbdid=1347636139&fin=xcode_6_beta.dmg&fn=xcode_6_beta.dmg&slt=pm&uta=0&rtype=1&iv=0&isw=0&wshc_tag=0&wsts_tag=55bb2b9e&wsid_tag=7b790c04&wsiphost=ipdbm";
//    info1.wmDelegate = self;
//    //标记网络请求，可选参数
//    info1.flagStr    = @"register";
//    info1.localName  = @"registerView";
    
    //[[WmHttpRequestManager shareManager] startAsyncHttpGetWithRequestInfo:info1];
    
    //支付
    
    
    
    
}

#pragma mark - WMNetManger  回调方法
- (void)connectionComplete:(NSDictionary *)dic andFlagString:(NSString *)flagStr andResquestInfo:(id)requestInfo
{
    if ([flagStr isEqualToString:@"login"])
    {
        NSLog(@"login  Complete ");
        //[requestInfo errorCode:@"105"];
    }
    if ([flagStr isEqualToString:@"register"])
    {
        NSLog(@"register  Complete ");
    }
}

- (void)connectionFailedWithError:(NSError *)error andResquestInfo:(id)requestInfo
{
    NSLog(@"error = %@", error.localizedDescription);
    [requestInfo connectionFailedWithError:error];
}


-(void)setDownloadProgress:(NSUInteger)bytesWritten totalBytesWritten:(long long)totalBytesWritten totalBytesExpectedToWrite:(long long)totalBytesExpectedToWrite andResquestInfo:(id)requestInfo
{
    NSLog(@"setDownloadProgress = %ld", bytesWritten);
}


-(void)setUploadProgress:(NSUInteger)bytesWritten totalBytesWritten:(long long)totalBytesWritten totalBytesExpectedToWrite:(long long)totalBytesExpectedToWrite andResquestInfo:(id)requestInfo
{
    NSLog(@"setUploadProgress = %ld", bytesWritten);
}
















// 图片已经选中了， 只是还没有处理
-(void)selectImageCallBack:(NSObject *)selectObj
{
    if ([selectObj isKindOfClass:[YsnPickImage class]])
    {
        YsnPickImage *ysnPickImage = (YsnPickImage *)selectObj;
    
        NSLog(@" selectImageCallBack    sizeof(ysnPickImage) %lu", sizeof(ysnPickImage));
        BOOL isOk = [ysnPickImage makeAndSaveImage:logoImage];

        if (isOk)
        {
            NSString *imagePath = [ysnPickImage getSmallImagePath];
            UIImage  *imageObj  = [ysnPickImage getSmallResultImage];
            NSLog(@" selectImageCallBack   !!!!ddeewweewwe  !!!!!imagePath %@", imagePath);
            
            NSString *orignalPath = [ysnPickImage getOrignalImagePath];
            NSLog(@" orignalPath   !!!!ddeewweewwe  !!!!!imagePath %@", orignalPath);
            
            
            NSData * imageData = UIImageJPEGRepresentation(imageObj,1);
            
            long len = [imageData length];

            NSString *sizeStr = [LibFun fileSizeToString:len];
            NSLog(@" 没有base64的 sizeStr   sizeStr  %@", sizeStr);

            NSString *baseStr = [imageData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
            long lenStr = [baseStr length];
            NSString *baseSizeStr = [LibFun fileSizeToString:lenStr];
            NSLog(@" base64之后 base64SizeStr  %@", baseSizeStr);
            
        }
    }
}


//启动header刷新
- (void)setPullTableIsRefreshing:(BOOL)isRefreshing
{
    [loadView removeFromSuperview];
}



-(void)registerButton:(UIButton *)buttvon
{
    
    [self pushController:[RegisterViewController class] withInfo:nil withTitle:@"注册"];
    
    return;
    
//    [self add:3 b:4];
//    [self add:5 b:4];
//    [self add:6 b:4];
//    [self add:7 b:4];
//    [self add:8 b:4];
//    [self add:9 b:4];
    
    return ;
    
//    RequestInfo *info = [[RequestInfo alloc]init];
//    //Get
//    info.method = HttpRequestMethod_GET;
//    info.urlStr = @"http://www.55tuan.com/partner/partnerApi?partner=newwowo&city=beijing";
//    info.wmDelegate = self;
//    //标记网络请求，可选参数
//    info.flagStr = @"register";
//    [[WmHttpRequestManager shareManager] startAsyncHttpRequestWithRequestInfo:info];

}

-(void)passwordButton:(UIButton *)buttvon
{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//设置导航栏
-(BOOL)isHiddenNavBar
{
    return  YES;
}


-(void)add:(int) a b:(int)b
{
    NSLog(@"开始等待5秒执行这里  a = %d  b = %d",  a, b);
    [UIView animateWithDuration:0.0 delay:5.0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
        } completion:^(BOOL finished) {
            //do stuff here
            NSLog(@"之后    执行这里  a = %d  b = %d",  a,  b);
        }];}


@end
