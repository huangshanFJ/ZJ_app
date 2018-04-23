//
//  MyCardViewController.m
//  ZhongJianMalliOS
//
//  Created by 段 on 2018/1/2.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "MyCardViewController.h"
#import "MKQRCode.h"
#import "RuleWebViewController.h"
@interface MyCardViewController () {
    NSDictionary *dataDic;
}


@property (nonatomic,strong)UILabel *nameLabel;
@property (nonatomic,strong)UILabel *nameIDLabel;
@property (nonatomic,strong)UIImageView *QRCodeImage;
@property (nonatomic,strong)UIImageView *headIconImage;



@end

@implementation MyCardViewController


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    self.navigationController.navigationBar.barStyle = UIStatusBarStyleDefault;

}
-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    dataDic = [NSDictionary dictionary];
    [self configNav];
    [self requestData];
    [self configTableView];
//    self.inputString = @"http://192.168.1.70/html/register.html?usercode=106210";
    //创建二维码
//    [self creatQRCodeImage];
    
}
- (void)requestData {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer new];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSString *token = [userDefaults objectForKey:@"userToken"];
    NSString *url = [NSString stringWithFormat:@"%@%@%@",HTTPUrl,@"/zjapp/v1/PersonalCenter/GetPersonalInfo/",token];//,token];
    [manager GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"成功=%@",responseObject);
        if ([responseObject[@"error_code"] intValue] == 0) {
            //        。；
            if (responseObject[@"data"] != nil) {
                    NSDictionary *dict = responseObject[@"data"];
//                NSString *Lev = [NSString stringWithFormat:@"%@",responseObject[@"data"][@"personDataMap"][@"Lev"]];
                _nameLabel.text = [NSString stringWithFormat:@"%@",dict[@"personDataMap"][@"UserName"]];
                _nameIDLabel.text = [NSString stringWithFormat:@"ID: %@",dict[@"personDataMap"][@"SysID"]];
                NSString *usercode = [NSString stringWithFormat:@"%@",dict[@"personDataMap"][@"InviteCode"]];
                _QRCodeImage.image = [self generateImageWithCode:usercode];
                NSString *imageUrl = [NSString stringWithFormat:@"%@%@",HTTPUrl,dict[@"personDataMap"][@"HeadPhoto"]];

                [_headIconImage sd_setImageWithURL:[NSURL URLWithString:imageUrl]];
            }
            dataDic = [NSDictionary dictionaryWithDictionary:responseObject[@"data"]];
            
        }else if ([responseObject[@"error_code"] intValue] == 3) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"该账号已在其他手机登陆" message:@"" preferredStyle:UIAlertControllerStyleAlert];
            //            [alert addAction:[UIAlertAction actionWithTitle: style: handler:nil]];
            [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                [self.navigationController pushViewController:[LoginViewController new] animated:YES];
            }]];
            [self presentViewController:alert animated:YES completion:nil];
        }
        [hud hideAnimated:YES];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"失败=%@",error);
        [hud hideAnimated:YES];
    }];
    
    
}
#pragma mark -- UI
- (void)configNav {
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton addTarget:self action:@selector(backButtonClick) forControlEvents:UIControlEventTouchUpInside];
    backButton.tag = 100;
    [backButton setBackgroundImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [self.view addSubview:backButton];
    [backButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(10);
        make.width.mas_offset(20);
        make.height.mas_offset(20);
        make.top.mas_offset(30);
    }];
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, KWIDTH, 44)];
    title.text = @"我的名片";
    title.textAlignment = 1;
    title.textColor = [UIColor colorWithHexString:@"444444"];
    title.font = [UIFont systemFontOfSize:17];
    [self.view addSubview:title];
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(20);
        make.height.mas_offset(44);
        make.right.mas_offset(-50);
        make.left.mas_offset(50);
    }];
    
//    UILabel *rightLabel = [[UILabel alloc] init];
//    rightLabel.text = @"交易规则";
//    rightLabel.textAlignment = 2;
//    rightLabel.font = [UIFont systemFontOfSize:13];
//    rightLabel.textColor = lightBlackTextColor;
    UIButton *ruleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [ruleBtn setTitle:@"交易规则" forState:UIControlStateNormal];
//    [ruleBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [ruleBtn setAttributedTitle:[[NSMutableAttributedString alloc] initWithString:@"交易规则" attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:13],NSForegroundColorAttributeName : [UIColor blackColor]}] forState:UIControlStateNormal];
    [self.view addSubview:ruleBtn];
    [ruleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-10);
        make.width.mas_equalTo(80);
        make.top.mas_offset(20);
        make.height.mas_offset(44);
    }];
    [ruleBtn addTarget:self action:@selector(clickRuleBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];
    [self.view addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(0);
        make.right.mas_offset(0);
        make.top.mas_offset(63);
        make.height.mas_offset(1);
    }];
    
}
//点击规则
-(void)clickRuleBtn:(UIButton *)btn
{
    RuleWebViewController *vc = [[RuleWebViewController alloc] initWithUrlString:[NSString stringWithFormat:@"%@/html/sysaticle.html?id=3",HTTPUrl]];
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)configTableView {
 
    UIImageView *bgImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"图层7"]];
    bgImageView.userInteractionEnabled = YES;
    bgImageView.frame = CGRectMake(0, 64, KWIDTH, KHEIGHT-64);
    [self.view addSubview:bgImageView];
    [bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.width.mas_equalTo(KWIDTH);
        make.height.mas_equalTo(KHEIGHT-64);
        make.top.mas_equalTo(64);
    }];
    
    _headIconImage = [[UIImageView alloc] init];
    _headIconImage.layer.cornerRadius = 32;
    _headIconImage.layer.masksToBounds = YES;
    _headIconImage.layer.borderWidth = 2;
    _headIconImage.layer.borderColor = zjTextColor.CGColor;
    [bgImageView addSubview:_headIconImage];
    [_headIconImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(KWIDTH*0.258);
        make.top.equalTo(bgImageView.mas_top).offset(70);
        make.width.mas_equalTo(64);
        make.height.mas_equalTo(64);
    }];
    
    _nameLabel = [[UILabel alloc] init];
    _nameLabel.font = [UIFont fontWithName:@"Arial Rounded MT Bold" size:17];
    _nameLabel.textColor = lightBlackTextColor;
//    _nameLabel.text = @"灰灰灰";
    [bgImageView addSubview:_nameLabel];
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_headIconImage.mas_right).offset(15);
        make.top.equalTo(_headIconImage.mas_top).offset(5);
        make.height.mas_equalTo(28);
    }];
    
    _nameIDLabel = [[UILabel alloc] init];
    _nameIDLabel.textColor = lightBlackTextColor;
    _nameIDLabel.font = [UIFont systemFontOfSize:15];
//    _nameIDLabel.text = @"ID:1EW2EHY";
    [bgImageView addSubview:_nameIDLabel];
    [_nameIDLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_headIconImage.mas_right).offset(15);
        make.top.equalTo(_nameLabel.mas_bottom).offset(0);
        make.height.mas_equalTo(28);
//        make
    }];
    
    _QRCodeImage = [[UIImageView alloc] init];
//    NSURL *url = [NSURL URLWithString:@"http://192.168.1.70/html/register.html?usercode=106210"];
//    [_QRCodeImage sd_setImageWithURL:url];
//    _QRCodeImage.backgroundColor = [UIColor redColor];
   
  
    
    [bgImageView addSubview:_QRCodeImage];
    [_QRCodeImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.centerY.mas_equalTo(-20);
        make.height.mas_equalTo(155);
        make.width.mas_equalTo(155);
    }];
    
    UIButton *shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
    shareButton.backgroundColor = [UIColor whiteColor];
    shareButton.layer.cornerRadius = 45/2;
    shareButton.layer.masksToBounds = YES;
    [shareButton setTitle:@"分享" forState:UIControlStateNormal];
    shareButton.titleLabel.font = [UIFont systemFontOfSize:20];
    [shareButton addTarget:self action:@selector(creatshare) forControlEvents:UIControlEventTouchUpInside];
    [shareButton setTitleColor:zjTextColor forState:UIControlStateNormal];
    [bgImageView addSubview:shareButton];
    [shareButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.height.mas_equalTo(45);
        make.bottom.mas_equalTo(-39);
        make.width.mas_equalTo(KWIDTH*0.76);
    }];
    
}
- (void)backButtonClick {
    self.navigationController.navigationBar.hidden = NO;
    [self.navigationController popViewControllerAnimated:YES];
    
}
- (void)creatshare {
    NSLog(@"分享");
    //    NSArray* imageArray = @[[UIImage imageNamed:@"shareImg.png"]];
    NSString *imageUrl = [NSString stringWithFormat:@"%@%@",HTTPUrl,dataDic[@"personDataMap"][@"HeadPhoto"]];
    NSString *usercode = [NSString stringWithFormat:@"%@",dataDic[@"personDataMap"][@"InviteCode"]];
    NSString *info = [NSString stringWithFormat:@"https://appnew.zhongjianmall.com/html/register.html?usercode=%@",usercode];
    NSString *text = [NSString stringWithFormat:@"%@",dataDic[@"personDataMap"][@"UserName"]];

    NSArray* imageArray = @[imageUrl];
    
    //    （注意：图片必须要在Xcode左边目录里面，名称必须要传正确，如果要分享网络图片，可以这样传iamge参数 images:@[@"http://mob.com/Assets/images/logo.png?v=20150320"]）
    if (imageArray) {
        
        NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
        [shareParams SSDKSetupShareParamsByText:text
                                         images:imageArray
                                            url:[NSURL URLWithString:info]
                                          title:@"我的名片"
                                           type:SSDKContentTypeAuto];
        //有的平台要客户端分享需要加此方法，例如微博
        [shareParams SSDKEnableUseClientShare];
        //2、分享（可以弹出我们的分享菜单和编辑界面）
        [ShareSDK showShareActionSheet:nil //要显示菜单的视图, iPad版中此参数作为弹出菜单的参照视图，只有传这个才可以弹出我们的分享菜单，可以传分享的按钮对象或者自己创建小的view 对象，iPhone可以传nil不会影响
                                 items:nil
                           shareParams:shareParams
                   onShareStateChanged:^(SSDKResponseState state, SSDKPlatformType platformType, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error, BOOL end) {
                       
                       switch (state) {
                           case SSDKResponseStateSuccess:
                           {
                               UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享成功"
                                                                                   message:nil
                                                                                  delegate:nil
                                                                         cancelButtonTitle:@"确定"
                                                                         otherButtonTitles:nil];
                               [alertView show];
                               break;
                           }
                           case SSDKResponseStateFail:
                           {
                               UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享失败"
                                                                               message:[NSString stringWithFormat:@"%@",error]
                                                                              delegate:nil
                                                                     cancelButtonTitle:@"OK"
                                                                     otherButtonTitles:nil, nil];
                               [alert show];
                               break;
                           }
                           default:
                               break;
                       }
                   }
         ];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (UIImage *)generateImageWithCode:(NSString *)code {
    MKQRCode *codeImage = [[MKQRCode alloc] init];
    NSString *info = [NSString stringWithFormat:@"https://appnew.zhongjianmall.com/html/register.html?usercode=%@",code];
   [codeImage setInfo:info withSize:300];
    
    return [codeImage generateImage];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
