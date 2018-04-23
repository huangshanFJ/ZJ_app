//
//  UpgradeViewController.m
//  ZhongJianMalliOS
//
//  Created by 段 on 2017/12/28.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "UpgradeViewController.h"

@interface UpgradeViewController () 

@property (nonatomic,strong)UITableView *upgradeTable;
@end

@implementation UpgradeViewController


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
    title.text = @"直接充值";
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
    
    UIImageView *headImage = [[UIImageView alloc] init];
    headImage.layer.cornerRadius = 5;
    headImage.layer.masksToBounds = YES;
    headImage.image = [UIImage imageNamed:@"icon_zfbzf"];
    [topView addSubview:headImage];
    [headImage mas_makeConstraints:^(MASConstraintMaker *make) {
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
        make.left.equalTo(headImage.mas_right).offset(11);
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
        make.height.mas_offset(15);
        make.width.mas_offset(KWIDTH);
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
    
    UILabel *upgradeVIPLabel = [self creatLabelString:@"升级到vip" textFont:[UIFont systemFontOfSize:17] textColor:lightBlackTextColor];
    [whiteView addSubview:upgradeVIPLabel];
    [upgradeVIPLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(10);
        make.centerY.equalTo(whiteView.mas_centerY).offset(0);
        make.height.mas_offset(50);
    }];
    
    UIButton *upgradeVIPButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [upgradeVIPButton setBackgroundImage:[UIImage imageNamed:@"choose"] forState:UIControlStateNormal];
    [upgradeVIPButton addTarget:self action:@selector(upgradeVIPButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [whiteView addSubview:upgradeVIPButton];
    [upgradeVIPButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-10);
        make.centerY.equalTo(whiteView.mas_centerY).offset(0);
        make.height.mas_offset(22);
        make.width.mas_offset(22);
    }];
    
    UIImageView *line = [[UIImageView alloc] init];
    line.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];
    [whiteView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(0);
        make.height.mas_offset(0.5);
        make.width.mas_offset(KWIDTH);
        make.bottom.equalTo(whiteView.mas_bottom).offset(-0.5);
    }];
    
    UIView *whiteBottom = [[UIView alloc] init];
    whiteBottom.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:whiteBottom];
    [whiteBottom mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(0);
        make.height.mas_offset(63);
        make.top.equalTo(whiteView.mas_bottom).offset(0);
        make.width.mas_offset(KWIDTH);
    }];
    
    UILabel *upgradeAgencyLabel = [self creatLabelString:@"升级到代理" textFont:[UIFont systemFontOfSize:17] textColor:lightBlackTextColor];
    [whiteBottom addSubview:upgradeAgencyLabel];
    [upgradeAgencyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(10);
        make.centerY.equalTo(whiteBottom.mas_centerY).offset(0);
        make.height.mas_offset(50);
    }];
    
    UIButton *upgradeAgencyButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [upgradeAgencyButton setBackgroundImage:[UIImage imageNamed:@"choose"] forState:UIControlStateNormal];
    [upgradeAgencyButton addTarget:self action:@selector(upgradeAgencyButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [whiteBottom addSubview:upgradeAgencyButton];
    [upgradeAgencyButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-10);
        make.centerY.equalTo(whiteBottom.mas_centerY).offset(0);
        make.height.mas_offset(22);
        make.width.mas_offset(22);
    }];
    
    UIView *bottomView = [[UIView alloc] init];
    bottomView.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];
    [self.view addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(0);
        make.width.mas_offset(KWIDTH);
        make.height.mas_offset(KHEIGHT-64*4);
        make.top.equalTo(whiteBottom.mas_bottom).offset(0);
    }];
    
    UIImageView *titleImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"forget_gray"]];
    [bottomView addSubview:titleImage];
    [titleImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(10);
        make.top.equalTo(bottomView.mas_top).offset(20);
        make.width.mas_offset(16);
        make.height.mas_offset(16);
    }];
    
    UILabel *titleLabel = [self creatLabelString:@"升级金额将进入消费积分" textFont:[UIFont systemFontOfSize:12] textColor:lightgrayTextColor];
    [bottomView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(titleImage.mas_right).offset(6);
        make.height.mas_offset(16);
        make.centerY.equalTo(titleImage.mas_centerY).offset(0);
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
        make.top.equalTo(titleLabel.mas_bottom).offset(60);
    }];
    
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
- (void)upgradeVIPButtonClick:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (sender.selected == YES) {
        [sender setBackgroundImage:[UIImage imageNamed:@"fullin_blue"] forState:UIControlStateSelected];
    }else{
        [sender setBackgroundImage:[UIImage imageNamed:@"choose"] forState:UIControlStateNormal];
    };
}
- (void)upgradeAgencyButtonClick:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (sender.selected == YES) {
        [sender setBackgroundImage:[UIImage imageNamed:@"fullin_blue"] forState:UIControlStateSelected];
    }else{
        [sender setBackgroundImage:[UIImage imageNamed:@"choose"] forState:UIControlStateNormal];
    };
}
- (void)sureClick:(UIButton *)sender {
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (UILabel *)creatLabelString:(NSString *)text textFont:(UIFont *)font textColor:(UIColor *)color {
    UILabel *label = [[UILabel alloc] init];
    label.textColor = color;
    label.text = text;
    label.font = font;
    
    return label;
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
