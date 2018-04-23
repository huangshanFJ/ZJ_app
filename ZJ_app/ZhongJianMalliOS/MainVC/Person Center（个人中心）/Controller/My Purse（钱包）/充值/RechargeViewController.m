//
//  RechargeViewController.m
//  ZhongJianMalliOS
//
//  Created by 段 on 2017/12/26.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "RechargeViewController.h"

@interface RechargeViewController ()

@property (nonatomic,strong)UIImageView *headIconImage;
@property (nonatomic,strong)UITextField *priceNumberText;


@end

@implementation RechargeViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.barStyle = UIStatusBarStyleDefault;

    [self configNav];
    
    [self configTableView];
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
    title.text = @"现金币充值";
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
- (void)configTableView {
    
    UIView *topView = [[UIView alloc] init];
    topView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:topView];
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(0);
        make.height.mas_offset(63);
        make.top.mas_offset(64);
        make.right.mas_offset(0);
    }];
    
    _headIconImage = [[UIImageView alloc] init];
    _headIconImage.layer.cornerRadius = 5;
    _headIconImage.layer.masksToBounds = YES;
    _headIconImage.image = [UIImage imageNamed:@"icon_zfbzf"];
    [topView addSubview:_headIconImage];
    [_headIconImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(10);
        make.centerY.equalTo(topView.mas_centerY).offset(0);
        make.height.mas_offset(40);
        make.width.mas_offset(40);
    }];
    
    UILabel *kindNameLabel = [UILabel new];
    kindNameLabel.text = @"支付宝";
    kindNameLabel.font = [UIFont systemFontOfSize:17];
    kindNameLabel.textColor = lightBlackTextColor;
    [topView addSubview:kindNameLabel];
    [kindNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_headIconImage.mas_right).offset(11);
        make.centerY.equalTo(topView.mas_centerY).offset(0);
        make.height.mas_offset(40);
    }];
    
    UIButton *selectedButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [selectedButton setBackgroundImage:[UIImage imageNamed:@"choose"] forState:UIControlStateNormal];
    [selectedButton addTarget:self action:@selector(selectedButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:selectedButton];
    [selectedButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-10);
        make.centerY.equalTo(topView.mas_centerY).offset(0);
        make.width.mas_offset(22);
        make.height.mas_offset(22);
    }];
    
    UIView *grayView = [[UIView alloc] init];
    grayView.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];
    [self.view addSubview:grayView];
    [grayView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(0);
        make.top.equalTo(topView.mas_bottom).offset(0);
        make.height.mas_offset(40);
        make.width.mas_offset(KWIDTH);
    }];
    UILabel *numberLabel = [[UILabel alloc] init];
    numberLabel.textColor = lightgrayTextColor;
    numberLabel.text = @"充值金额（元）";
    numberLabel.font = [UIFont systemFontOfSize:12];
    [grayView addSubview:numberLabel];
    [numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(10);
        make.height.mas_offset(30);
        make.centerY.equalTo(grayView.mas_centerY).offset(0);
    }];
    
    UIView *whiteView = [[UIView alloc] init];
    whiteView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:whiteView];
    [whiteView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(0);
        make.width.mas_offset(KWIDTH);
        make.height.mas_offset(63);
        make.top.equalTo(grayView.mas_bottom).offset(0);
    }];
    
    UILabel *priceLabel = [UILabel new];
    priceLabel.font = [UIFont systemFontOfSize:17];
    priceLabel.text = @"金额";
    priceLabel.textColor = lightBlackTextColor;
    [whiteView addSubview:priceLabel];
    [priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(10);
        make.centerY.equalTo(whiteView.mas_centerY).offset(0);
        make.height.mas_offset(30);
    }];
    
    _priceNumberText = [[UITextField alloc] init];
    _priceNumberText.textAlignment = 2;
    _priceNumberText.textColor = lightBlackTextColor;
    [whiteView addSubview:_priceNumberText];
    [_priceNumberText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_offset(-10);
        make.width.mas_offset(KWIDTH*0.5);
        make.height.mas_offset(30);
        make.centerY.equalTo(whiteView.mas_centerY).offset(0);
    }];
    
    UIView *bottomView = [[UIView alloc] init];
    bottomView.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];
    [self.view addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.height.mas_equalTo(KHEIGHT-64-40-63-63);
        make.width.mas_equalTo(KWIDTH);
        make.top.equalTo(whiteView.mas_bottom).offset(0);
    }];
    
    UIButton *sureButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [sureButton setTitle:@"确定充值" forState:UIControlStateNormal];
    sureButton.titleLabel.font = [UIFont systemFontOfSize:17];
    [sureButton addTarget:self action:@selector(sureClick:) forControlEvents:UIControlEventTouchUpInside];
    sureButton.backgroundColor = zjTextColor;
    sureButton.layer.cornerRadius = 20;
    sureButton.layer.masksToBounds = YES;
    [bottomView addSubview:sureButton];
    [sureButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.height.mas_equalTo(40);
        make.top.equalTo(bottomView.mas_top).offset(60);
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)backButtonClick {
    self.navigationController.navigationBar.hidden = NO;
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)selectedButtonClick:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (sender.selected == YES) {
        [sender setBackgroundImage:[UIImage imageNamed:@"fullin_blue"] forState:UIControlStateSelected];
    }else{
        [sender setBackgroundImage:[UIImage imageNamed:@"choose"] forState:UIControlStateNormal];
    };
}
- (void)sureClick:(UIButton *)sender {
    NSLog(@"充值");
    if (_priceNumberText.text.length > 0) {
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        manager.responseSerializer = [AFJSONResponseSerializer new];
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
        NSString *token = [user objectForKey:@"userToken"];
        NSString *url = [NSString stringWithFormat:@"%@%@%@",HTTPUrl,@"/zjapp/v1/MemberShip/createCOrder/",token];
        NSDictionary *parame = @{
                                 @"money":_priceNumberText.text
                                 };
        [manager POST:url parameters:parame progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSLog(@"%@",responseObject);
            NSString *code = [NSString stringWithFormat:@"%@",responseObject[@"error_code"]];
            if ([code intValue] == 0) {
                NSString *appScheme = @"com.zhongjianAlipay";
                NSString *orderString = [NSString stringWithFormat:@"%@",responseObject[@"data"]];
                // NOTE: 调用支付结果开始支付
                [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
                    NSLog(@"reslut = %@",resultDic);
                }];
            }
            [hud hideAnimated: YES];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [hud hideAnimated: YES];
            NSLog(@"%@",error);
        }];
        
        
    }else {
        
    }
 
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
