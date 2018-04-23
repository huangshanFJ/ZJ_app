//
//  MyKindUseCell.m
//  ZhongJianMalliOS
//
//  Created by 段 on 2017/11/6.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "MyKindUseCell.h"

@implementation MyKindUseCell
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initUI];
    }
    return self;
}

- (void)initUI {
    
    UIView *bgView = [UIView new];
    bgView.backgroundColor = [UIColor whiteColor];
    [self addSubview:bgView];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(0);
        make.top.mas_offset(0);
        make.right.mas_offset(0);
        make.bottom.mas_offset(0);
    }];
    _kindImageView = [[UIImageView alloc] init];
    [bgView addSubview:_kindImageView];
    [_kindImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_offset(0);
        make.width.mas_offset(21);
        make.height.mas_offset(21);
        make.top.mas_equalTo(16);
    }];
    
    
    _numberLabel = [[UILabel alloc] init];
    _numberLabel.backgroundColor = [UIColor redColor];
    _numberLabel.clipsToBounds = YES;
    _numberLabel.hidden = YES;
    _numberLabel.textColor = [UIColor whiteColor];
    _numberLabel.layer.cornerRadius = 5;
    _numberLabel.font = [UIFont systemFontOfSize:7];
    _numberLabel.textAlignment = 1;
    [bgView addSubview:_numberLabel];
    [_numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_kindImageView.mas_right).offset(0);
        make.centerY.equalTo(_kindImageView.mas_top).offset(0);
        make.height.mas_offset(10);
        make.width.mas_offset(10);
    }];
    _kindNameLabel = [[UILabel alloc] init];
    _kindNameLabel.textAlignment = 1;
    _kindNameLabel.textColor = [UIColor colorWithHexString:@"444444"];
    _kindNameLabel.font = [UIFont systemFontOfSize:11];
    [bgView addSubview:_kindNameLabel];
    [_kindNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(0);
        make.top.equalTo(_kindImageView.mas_bottom).offset(8);
        make.right.mas_offset(0);
        make.height.mas_offset(20);
    }];
    UIView *line = [UIView new];
    line.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];
    [bgView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(0);
        make.right.mas_offset(0);
        make.bottom.mas_offset(0);
        make.height.mas_offset(0.5);
    }];
    
}
@end
