//
//  PersonMoneyReusableView.m
//  ZhongJianMalliOS
//
//  Created by 段 on 2017/11/6.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "PersonMoneyReusableView.h"

@implementation PersonMoneyReusableView
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self creatUI];
    }
    return self;
}
- (void)creatUI {
    
    UIView *bgView = [[UIView alloc] init];
    bgView.backgroundColor = [UIColor whiteColor];
    
    [self addSubview:bgView];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(0);
        make.right.mas_offset(0);
        make.bottom.mas_offset(0);
        make.top.mas_offset(0);
    }];
    
    _kindNameLabel = [[UILabel alloc] init];
    _kindNameLabel.textColor = [UIColor colorWithHexString:@"444444"];
    _kindNameLabel.font = [UIFont systemFontOfSize:15];
    
    [bgView addSubview:_kindNameLabel];
    [_kindNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(10);
        make.top.mas_offset(5);
        make.height.mas_offset(30);
    }];
    UIView *line = [UIView new];
    line.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];
    [bgView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(0);
        make.right.mas_offset(0);
        make.bottom.mas_offset(-1);
        make.height.mas_offset(0.5);
    }];
}

@end
