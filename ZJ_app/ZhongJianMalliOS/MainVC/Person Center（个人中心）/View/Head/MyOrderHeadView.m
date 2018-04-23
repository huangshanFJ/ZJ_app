
//
//  MyOrderHeadView.m
//  ZhongJianMalliOS
//
//  Created by 段 on 2018/1/24.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "MyOrderHeadView.h"

@implementation MyOrderHeadView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initWithView];
    }
    return self;
}
- (void)initWithView {
    UIView *headView = [[UIView alloc] init];
    headView.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];
    [self addSubview:headView];
    [headView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(0);
        make.top.mas_offset(0);
        make.height.mas_offset(7);
        make.right.mas_offset(0);
    }];
    
    UIView *bottomView = [[UIView alloc] init];
    bottomView.backgroundColor = [UIColor whiteColor];
    [self addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(0);
        make.top.mas_offset(7);
        make.height.mas_offset(30);
        make.right.mas_offset(0);
    }];
    
    _creatTimeLabel = [[UILabel alloc] init];
    _creatTimeLabel.font = [UIFont systemFontOfSize:11];
    _creatTimeLabel.textColor = lightgrayTextColor;
    [bottomView addSubview:_creatTimeLabel];
    [_creatTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(10);
        make.height.mas_offset(30);
        make.centerY.equalTo(bottomView.mas_centerY).offset(0);
    }];
    
    _orderStateKindLabel = [[UILabel alloc] init];
    _orderStateKindLabel.font = [UIFont systemFontOfSize:11];
    _orderStateKindLabel.textAlignment = 2;
    _orderStateKindLabel.textColor = [UIColor colorWithHexString:@"6493ff"];
    [bottomView addSubview:_orderStateKindLabel];
    [_orderStateKindLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-10);
        make.height.mas_offset(30);
        make.centerY.equalTo(bottomView.mas_centerY).offset(0);
    }];

    
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
