//
//  NOHaveViewController.m
//  ZhongJianMalliOS
//
//  Created by 段 on 2018/2/6.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "NOHaveViewController.h"

@interface NOHaveViewController ()

@end

@implementation NOHaveViewController

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
    title.text = _showTit;
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
    UIImageView *bgImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"5d84b1abf367b607e2d1c1249623b2c7e033e574793f-w8sOy9_fw658"]];
    
    [self.view addSubview:bgImage];
    [bgImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_offset(218);
        make.height.mas_offset(204);
        make.centerX.mas_offset(0);
        make.centerY.mas_offset(0);
    }];
    
    
}
- (void)backButtonClick {
    self.navigationController.navigationBar.hidden = NO;
    [self.navigationController popViewControllerAnimated:YES];
    
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
