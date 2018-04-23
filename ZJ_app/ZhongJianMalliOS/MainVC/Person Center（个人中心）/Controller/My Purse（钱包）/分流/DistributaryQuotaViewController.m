//
//  DistributaryQuotaViewController.m
//  ZhongJianMalliOS
//
//  Created by 段 on 2017/12/27.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "DistributaryQuotaViewController.h"
#import "DistributaryViewController.h"
#import "MoneyDisteibutaryViewController.h"

@interface DistributaryQuotaViewController ()

@property (nonatomic,strong)UILabel *priceLabel;

@end

@implementation DistributaryQuotaViewController

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
    title.text = @"分流额度";//_showTitleString;
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
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, KWIDTH, KHEIGHT-64)];
    bottomView.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];
    [self.view addSubview:bottomView];
    
    UIImageView *bgImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg-3"]];
    bgImageView.userInteractionEnabled = YES;
    [bottomView addSubview:bgImageView];
    [bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(5.5);
        make.right.mas_offset(-5.5);
        make.top.equalTo(bottomView.mas_top).offset(6);
        make.height.mas_offset(215);
    }];
    
    _priceLabel = [[UILabel alloc] init];
    _priceLabel.text = _showMoney;
    _priceLabel.font = [UIFont fontWithName:@"Arial Rounded MT Bold" size:24];
    _priceLabel.textAlignment = 1;
    [bgImageView addSubview:_priceLabel];
    [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_offset(0);
        make.height.mas_offset(20);
        make.top.equalTo(bgImageView.mas_top).offset(65);
    }];
    UILabel *priceIcon = [[UILabel alloc] init];
    priceIcon.textAlignment = 2;
    priceIcon.text = @"￥";
    priceIcon.font = [UIFont fontWithName:@"Arial Rounded MT Bold" size:12];
    [bgImageView addSubview:priceIcon];
    [priceIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_priceLabel.mas_left).offset(-3);
        make.bottom.equalTo(_priceLabel.mas_bottom).offset(0);
        make.height.mas_offset(12);
    }];
    UILabel *balance = [UILabel new];
    balance.text = @"分流余额";
    balance.font = [UIFont systemFontOfSize:13];
    balance.textAlignment = 1;
    balance.textColor = lightBlackTextColor;
    [bgImageView addSubview:balance];
    [balance mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_offset(0);
        make.top.equalTo(_priceLabel.mas_bottom).offset(6);
        make.height.mas_offset(13);
    }];
    
    UILabel *line = [[UILabel alloc] init];
    line.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];
    [bgImageView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(0);
        make.right.mas_offset(0);
        make.height.mas_offset(1);
        make.bottom.equalTo(bgImageView.mas_bottom).offset(-63);
    }];
    
    UIView *leftView = [[UIView alloc] init];
    [bgImageView addSubview:leftView];
    [leftView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bgImageView.mas_left).offset(0);
        make.height.mas_offset(45);
        make.width.mas_offset(KWIDTH/2-5.5);
        make.top.equalTo(line.mas_top).offset(0);
    }];
    UITapGestureRecognizer *leftTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(leftTapClick)];
    [leftView addGestureRecognizer:leftTap];
    
    UIImageView *leftImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"documentaryfilm-1"]];
    [leftView addSubview:leftImage];
    [leftImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(leftView.mas_left).offset(25);
        make.centerY.equalTo(leftView.mas_centerY).offset(0);
        make.width.mas_offset(22);
        make.height.mas_offset(22);
    }];
    UILabel *leftLabel = [[UILabel alloc] init];
    leftLabel.text = @"分流记录";
    leftLabel.font = [UIFont systemFontOfSize:13];
    leftLabel.textColor = lightBlackTextColor;
    [leftView addSubview:leftLabel];
    [leftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(leftImage.mas_right).offset(10);
        make.height.mas_offset(22);
        make.centerY.equalTo(leftView.mas_centerY).offset(0);
    }];
    
    UIView *rightView = [[UIView alloc] init];
    [bgImageView addSubview:rightView];
    [rightView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(bgImageView.mas_right).offset(-5.5);
        make.width.mas_offset(KWIDTH/2-5.5);
        make.height.mas_offset(45);
        make.top.equalTo(line.mas_top).offset(0);
    }];
    UILabel *rightLabel = [[UILabel alloc] init];
    rightLabel.text = @"我要分流";
    rightLabel.font = [UIFont systemFontOfSize:13];
    rightLabel.textColor = lightBlackTextColor;
    [rightView addSubview:rightLabel];
    [rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-25);
        make.height.mas_offset(22);
        make.centerY.equalTo(leftView.mas_centerY).offset(0);
    }];

    UITapGestureRecognizer *rightTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(rightTapClick)];
    [rightView addGestureRecognizer:rightTap];
    
    UIImageView *rightImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"shunt"]];
    [rightView addSubview:rightImage];
    [rightImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(rightLabel.mas_left).offset(-10);
        make.width.mas_offset(22);
        make.height.mas_offset(22);
        make.centerY.equalTo(rightView.mas_centerY).offset(0);
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
- (void)rightTapClick {
    NSLog(@"右");
//    [self.navigationController pushViewController:animated:YES];
    MoneyDisteibutaryViewController *moneyVC = [MoneyDisteibutaryViewController new];

    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"分流额度" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    [alert addAction:[UIAlertAction actionWithTitle:@"分流金额￥3000" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        moneyVC.type = @"1";
        [self.navigationController pushViewController:moneyVC animated:YES];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"分流金额￥50000" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
          moneyVC.type = @"2";
        [self.navigationController pushViewController:moneyVC animated:YES];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
         
//        [self.navigationController pushViewController:moneyVC animated:YES];
    }]];
    [self presentViewController:alert animated:YES completion:^{
        
    }];
    
}
- (void)leftTapClick {
     NSLog(@"左");
//    [self.navigationController pushViewController:[DistributaryViewController new] animated:YES];
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
