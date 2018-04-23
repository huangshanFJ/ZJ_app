//
//  DetailOrderTableViewCell.m
//  ZhongJianMalliOS
//
//  Created by 段 on 2017/12/19.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "DetailOrderTableViewCell.h"

@implementation DetailOrderTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initCellView];
    }
    return self;
}
- (void)initCellView {
//    UILabel *topLabel = [[UILabel alloc] init];
    
    UILabel *orderLabel = [[UILabel alloc] init];
    orderLabel.text = @"订单号";
    orderLabel.textColor = lightgrayTextColor;
    orderLabel.font = [UIFont systemFontOfSize:13];
    [self addSubview:orderLabel];
    [orderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(10);
        make.top.mas_offset(10);
        make.height.mas_offset(20);
    }];
    
    _orderIDLabel = [[UILabel alloc] init];
    _orderIDLabel.textColor = lightBlackTextColor;
    _orderIDLabel.textAlignment = 2;
    _orderIDLabel.font = [UIFont systemFontOfSize:13];
    [self addSubview:_orderIDLabel];
    [_orderIDLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-10);
        make.top.mas_offset(10);
        make.height.mas_offset(20);
    }];
    
    UILabel *beginTime = [[UILabel alloc] init];
    beginTime.text = @"创建时间";
    beginTime.textColor = lightgrayTextColor;
    beginTime.font = [UIFont systemFontOfSize:13];
    [self addSubview:beginTime];
    [beginTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(10);
        make.top.equalTo(orderLabel.mas_bottom).offset(5);
        make.height.mas_offset(20);
    }];
    _creatTimeLabel = [[UILabel alloc] init];
    _creatTimeLabel.font = [UIFont systemFontOfSize:13];
    _creatTimeLabel.textAlignment = 2;
    _creatTimeLabel.textColor = lightBlackTextColor;
    [self addSubview:_creatTimeLabel];
    [_creatTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-10);
        make.top.equalTo(orderLabel.mas_bottom).offset(5);
        make.height.mas_offset(20);
    }];
    
    UILabel *endTime = [[UILabel alloc] init];
    endTime.textColor = lightgrayTextColor;
    endTime.font = [UIFont systemFontOfSize:13];
    endTime.text = @"付款时间";
    [self addSubview:endTime];
    [endTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(10);
        make.top.equalTo(beginTime.mas_bottom).offset(5);
        make.height.mas_offset(20);
    }];
    
//    _payTimeLabel = [[UILabel alloc] init];
//    _payTimeLabel.textColor = lightBlackTextColor;
//    _payTimeLabel.font = [UIFont systemFontOfSize:13];
//    _payTimeLabel.textAlignment = 2;
//    [self addSubview:_payTimeLabel];
//    [_payTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.mas_offset(-10);
//        make.top.equalTo(beginTime.mas_bottom).offset(5);
//        make.height.mas_offset(20);
//    }];
    
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
