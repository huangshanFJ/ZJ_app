//
//  ZJBaseViewController.m
//  ZhongJianMalliOS
//
//  Created by mac_fj on 2018/3/27.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "ZJBaseViewController.h"

@interface ZJBaseViewController ()

@end

@implementation ZJBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configNav];
}

- (void)configNav {
    
    UIView *backView = [[UIView alloc] init];
    UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc] initWithTarget:backView action:@selector(backButtonClick)];
    [backView setUserInteractionEnabled:YES];
    [backView addGestureRecognizer:tap];
    [self.view addSubview:backView];
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(10);
        make.width.mas_offset(40);
        make.height.mas_offset(40);
        make.top.mas_offset(30);
    }];
    
    UIImageView *backImg = [[UIImageView alloc] init];
    [backImg setImage:[UIImage imageNamed:@"back"]];
    [backView addSubview:backImg];
    [backImg mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_offset(10);
        make.center.mas_offset(backView.center);
        make.width.mas_offset(20);
        make.height.mas_offset(20);
//        make.top.mas_offset(30);
    }];
    
}

- (void)backButtonClick {
    
}


@end
