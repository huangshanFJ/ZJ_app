//
//  MyOrderFooterView.m
//  ZhongJianMalliOS
//
//  Created by 段 on 2018/1/24.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "MyOrderFooterView.h"

@implementation MyOrderFooterView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initWithFootView];
    }
    return self;
}
- (void)initWithFootView {
    
    UIView *upView = [[UIView alloc] init];
    upView.backgroundColor = [UIColor whiteColor];
    [self addSubview:upView];
    [upView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(0);
        make.width.mas_offset(KWIDTH);
        make.top.mas_offset(0);
        make.height.mas_offset(40);
    }];
    _needPriceLabel = [UILabel new];
    _needPriceLabel.textColor = lightBlackTextColor;
    _needPriceLabel.textAlignment = 2;
    [upView addSubview:_needPriceLabel];
    [_needPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-10);
        make.centerY.equalTo(upView.mas_centerY).offset(0);
        make.height.mas_offset(40);
    }];
    
    _totalNumberLabel = [[UILabel alloc] init];
    _totalNumberLabel.textColor = lightBlackTextColor;
    _totalNumberLabel.textAlignment = 2;
    _totalNumberLabel.font = [UIFont systemFontOfSize:11];
    [upView addSubview:_totalNumberLabel];
    [_totalNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_needPriceLabel.mas_left).offset(-9);
        make.height.mas_offset(40);
        make.centerY.equalTo(upView.mas_centerY).offset(0);
    }];
    
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];
    [upView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(0);
        make.width.mas_offset(KWIDTH);
        make.height.mas_offset(1);
        make.bottom.equalTo(upView.mas_bottom).offset(-1);
    }];
    
    UIView *bottomView = [[UIView alloc] init];
    bottomView.backgroundColor = [UIColor whiteColor];
    [self addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(0);
        make.height.mas_offset(50);
        make.width.mas_offset(KWIDTH);
        make.bottom.mas_offset(0);
    }];
    
    _rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    _rightButton.titleLabel.font = [UIFont systemFontOfSize:12];
    _rightButton.layer.masksToBounds = YES;
    _leftButton.hidden = YES;
    _rightButton.titleLabel.font = [UIFont systemFontOfSize:12];
    _rightButton.layer.cornerRadius = 11;
    _rightButton.layer.borderWidth = 0.5;
    _rightButton.layer.borderColor = [UIColor colorWithHexString:@"bfbfbf"].CGColor;
    _rightButton.backgroundColor = zjTextColor;
    [_rightButton addTarget:self action:@selector(rightButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:_rightButton];
    [_rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-10);
        make.height.mas_offset(23);
        make.width.mas_offset(60);
        make.centerY.equalTo(bottomView.mas_centerY).offset(0);
    }];
    
    _leftButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [_leftButton setTitleColor:[UIColor colorWithHexString:@"444444"] forState:UIControlStateNormal];
    //        [_leftButton setTitle:@"取消订单" forState:UIControlStateNormal];
    _leftButton.backgroundColor = [UIColor whiteColor];
    _leftButton.hidden = YES;
    _leftButton.titleLabel.font = [UIFont systemFontOfSize:12];
    _leftButton.layer.masksToBounds = YES;
    _leftButton.layer.cornerRadius = 11;
    _leftButton.layer.borderWidth = 0.5;
    _leftButton.layer.borderColor = [UIColor colorWithHexString:@"bfbfbf"].CGColor;
    [_leftButton addTarget:self action:@selector(leftlButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:_leftButton];
    [_leftButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_rightButton.mas_left).offset(-7);
        make.height.mas_offset(23);
        make.width.mas_offset(60);
        make.centerY.equalTo(bottomView.mas_centerY).offset(0);
    }];
    
    
    
    
    
 
}
- (void)leftlButtonClick:(UIButton *)sender {
    sender.selected = !sender.selected;
    !_leftButtonClickBlock ? : _leftButtonClickBlock();
}
- (void)rightButtonClick:(UIButton *)sender {
    sender.selected = !sender.selected;
    !_rightButtonClickBlock ? : _rightButtonClickBlock();
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
