//
//  PersonMoneyCell.m
//  ZhongJianMalliOS
//
//  Created by 段 on 2017/11/6.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "PersonMoneyCell.h"

@implementation PersonMoneyCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initUI];
    }
    return self;
}

- (void)initUI {
    UIView *bgView = [[UIView alloc] init];
    bgView.backgroundColor = [UIColor whiteColor];
    [self addSubview:bgView];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(0);
        make.right.mas_offset(0);
        make.bottom.mas_offset(0);
        make.top.mas_offset(0);
    }];
    _moneyLabel = [[UILabel alloc] init];
    _moneyLabel.font = [UIFont fontWithName:@"Arial Rounded MT Bold" size:17];
 
    _moneyLabel.textAlignment = 1;
    _moneyLabel.textColor = [UIColor colorWithHexString:@"444444"];
    [bgView addSubview:_moneyLabel];
    [_moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(0);
        make.right.mas_offset(0);
        make.top.mas_offset(20);
        make.height.mas_offset(24);
    }];
    _kindMoneyLabel = [[UILabel alloc] init];
    _kindMoneyLabel.font = [UIFont systemFontOfSize:11];
    _kindMoneyLabel.textAlignment = 1;
    _kindMoneyLabel.textColor = [UIColor colorWithHexString:@"444444"];
    [bgView addSubview:_kindMoneyLabel];
    [_kindMoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(0);
        make.right.mas_offset(0);
        make.height.mas_offset(18);
        make.top.equalTo(_moneyLabel.mas_bottom).offset(5);
    }];
    UIView *line = [UIView new];
    line.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];
    [bgView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(0);
        make.width.mas_offset(0.5);
        make.top.mas_offset(0);
        make.bottom.mas_offset(0);
    }];
}

@end
