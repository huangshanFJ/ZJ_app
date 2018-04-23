//
//  CashWithdrawalsViewController.m
//  ZhongJianMalliOS
//
//  Created by 段 on 2017/12/26.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "CashWithdrawalsViewController.h"
#import "ChooseKindViewController.h"
#import "PayPassVerifyViewController.h"

@interface CashWithdrawalsViewController () {
    UILabel *kindNameLabel;
    UILabel *selectedAccountLabel;
    UIView *topView;
}

@property (nonatomic,strong)UIImageView *headIconImage;
@property (nonatomic,strong)UITextField *priceNumberText;

@end

@implementation CashWithdrawalsViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
//    [self requestData];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.barStyle = UIStatusBarStyleDefault;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(selectedAlipay:) name:@"selectedAlipay" object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(selectedBankpay:) name:@"selectedAlipay" object:nil];
    
    [self configNav];
    
    [self configTableView];
    
    [self setCashView];
}
- (void)requestData {

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
    title.text = @"现金币提现";
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
    
    topView = [[UIView alloc] init];
    topView.backgroundColor = [UIColor whiteColor];
    topView.userInteractionEnabled = YES;
    [self.view addSubview:topView];
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(0);
        make.height.mas_offset(63);
        make.top.mas_offset(64);
        make.right.mas_offset(0);
    }];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selctedKind)];
    [topView addGestureRecognizer:tap];
    
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
    
    kindNameLabel = [UILabel new];
    kindNameLabel.text = @"选择提现账号";
    kindNameLabel.font = [UIFont systemFontOfSize:17];
    kindNameLabel.textColor = lightBlackTextColor;
    [topView addSubview:kindNameLabel];
    [kindNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_headIconImage.mas_right).offset(11);
        make.top.equalTo(topView.mas_top).offset(10);
        make.height.mas_offset(40);
    }];
    selectedAccountLabel = [[UILabel alloc] init];
    
//    UIButton *selectedButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    [selectedButton setBackgroundImage:[UIImage imageNamed:@"choose"] forState:UIControlStateNormal];
//    [selectedButton addTarget:self action:@selector(selectedButtonClick:) forControlEvents:UIControlEventTouchUpInside];
//    [topView addSubview:selectedButton];
//    [selectedButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.mas_offset(-10);
//        make.centerY.equalTo(topView.mas_centerY).offset(0);
//        make.width.mas_offset(22);
//        make.height.mas_offset(22);
//    }];
  
}
- (void)setCashView {
    UIView *grayView = [[UIView alloc] init];
    grayView.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];
    [self.view addSubview:grayView];
    [grayView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(0);
        make.top.mas_offset(127);
        make.height.mas_offset(40);
        make.width.mas_offset(KWIDTH);
    }];
    UILabel *numberLabel = [[UILabel alloc] init];
    numberLabel.textColor = lightgrayTextColor;
    numberLabel.text = @"提现金额（元）";
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
    _priceNumberText.keyboardType = UIKeyboardTypeNumberPad;
    _priceNumberText.textColor = lightBlackTextColor;
    [whiteView addSubview:_priceNumberText];
    [_priceNumberText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_offset(-10);
        make.width.mas_offset(KWIDTH*0.5);
        make.height.mas_offset(30);
        make.centerY.equalTo(whiteView.mas_centerY).offset(0);
    }];
    UIView *procedureView = [[UIView alloc] init];
    procedureView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:procedureView];
    [procedureView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.width.mas_equalTo(KWIDTH);
        make.height.mas_equalTo(30);
        make.top.equalTo(whiteView.mas_bottom).offset(0);
    }];
    
    UILabel *line = [UILabel new];
    line.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];
    [procedureView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.width.mas_equalTo(KWIDTH);
        make.height.mas_equalTo(0.5);
        make.top.equalTo(whiteView.mas_bottom).offset(0);
    }];
    
    UILabel *costLabel = [[UILabel alloc] init];
    costLabel.textAlignment = 0;
    costLabel.text = @"手续费3%";
    costLabel.textColor = redTextColor;
    costLabel.font = [UIFont systemFontOfSize:12];
    [procedureView addSubview:costLabel];
    [costLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.height.mas_equalTo(30);
        make.top.equalTo(whiteView.mas_bottom).offset(0);
    }];
    
    UIView *bottomView = [[UIView alloc] init];
    bottomView.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];
    [self.view addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.height.mas_equalTo(KHEIGHT-64-40-63-93);
        make.width.mas_equalTo(KWIDTH);
        make.top.equalTo(procedureView.mas_bottom).offset(0);
    }];
    
    UIButton *sureButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [sureButton setTitle:@"提现" forState:UIControlStateNormal];
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
        make.top.equalTo(procedureView.mas_bottom).offset(60);
    }];
}
- (void)selctedKind {
    
    [self.navigationController pushViewController:[ChooseKindViewController new] animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)backButtonClick {
    self.navigationController.navigationBar.hidden = NO;
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)selectedAlipay:(NSNotification *)notification{
    
    NSLog(@"接受到通知");
    NSDictionary *dic = notification.userInfo;
    NSLog( @"######%@",dic);
    
    // 如果是传多个数据，那么需要哪个数据，就对应取出对应的数据即可
//    UILabel *kindNameLabel;
//    UILabel *selectedAccountLabel;
    kindNameLabel.text = [NSString stringWithFormat:@"%@",dic[@"name"]];
    [kindNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topView.mas_top).offset(10);
        make.height.mas_offset(20);
        make.left.equalTo(_headIconImage.mas_right).offset(11);
    }];
    
    
    selectedAccountLabel.text = [NSString stringWithFormat:@"%@",dic[@"account"]];
    selectedAccountLabel.textColor = lightgrayTextColor;
    [topView addSubview:selectedAccountLabel];
    [selectedAccountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_headIconImage.mas_right).offset(11);
        make.height.mas_offset(20);
//        make.width.mas_offset(40);
        make.top.equalTo(kindNameLabel.mas_bottom).offset(5);
    }];
    
    
}
- (void)selectBankpay:(NSNotification *)notification{
    
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
    NSLog(@"提现");
    NSInteger money = [_priceNumberText.text integerValue];
    double a = [_mostMoney doubleValue]/1.03;
    
//    NSInteger mostMoney = [mostMoney integerValue]/1.03;
    
    
    if (money > a) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"输入金额大于现有提现金额" message:nil preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }]];
        [self presentViewController:alert animated:YES completion:^{
            
        }];
        _priceNumberText.text = [NSString stringWithFormat:@"%ld",(long)a];
        
    }else {
        if (kindNameLabel.text.length > 0 && selectedAccountLabel.text.length > 0 && _priceNumberText.text.length > 0) {
            PayPassVerifyViewController *payVC = [PayPassVerifyViewController new];
            [self presentViewController:payVC animated:YES completion:^{
                payVC.moneyNumber = _priceNumberText.text;
                payVC.cardNo = selectedAccountLabel.text;
                payVC.trueName = kindNameLabel.text;
                
            }];
        }else {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"请选择账号" message:nil preferredStyle:UIAlertControllerStyleAlert];
            [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                
            }]];
            [self presentViewController:alert animated:YES completion:^{
                
            }];
            
        }
    }
    
    
   
    
    
    
    
}
-(void)dealloc{
    //第一种方法.这里可以移除该控制器下的所有通知
    // 移除当前所有通知
    NSLog(@"移除了所有的通知");
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    //第二种方法.这里可以移除该控制器下名称为tongzhi的通知
    //移除名称为tongzhi的那个通知
//    NSLog(@"移除了名称为tongzhi的通知");
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"tongzhi" object:nil];
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
