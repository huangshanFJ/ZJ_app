//
//  DetailTimerCell.m
//  ZhongJianMalliOS
//
//  Created by 段 on 2018/3/2.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "DetailTimerCell.h"

@implementation DetailTimerCell
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
    
    UILabel *shopTime = [[UILabel alloc] init];
    shopTime.textColor = lightgrayTextColor;
    shopTime.font = [UIFont systemFontOfSize:13];
    shopTime.text = @"物流信息";
    [self addSubview:shopTime];
    [shopTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(10);
        make.top.equalTo(beginTime.mas_bottom).offset(5);
        make.height.mas_offset(20);
    }];
    _shopTimeLabel = [[UILabel alloc] init];
    _shopTimeLabel.font = [UIFont systemFontOfSize:13];
    _shopTimeLabel.textAlignment = 2;
    _shopTimeLabel.textColor = lightBlackTextColor;
    [self addSubview:_shopTimeLabel];
    [_shopTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-10);
        make.top.equalTo(beginTime.mas_bottom).offset(5);
        make.height.mas_offset(20);
    }];
    
    UILabel *expressLabel = [[UILabel alloc] init];
    expressLabel.textColor = lightgrayTextColor;
    expressLabel.font = [UIFont systemFontOfSize:13];
    expressLabel.text = @"发货时间";
    [self addSubview:expressLabel];
    [expressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(10);
        make.top.equalTo(shopTime.mas_bottom).offset(5);
        make.height.mas_offset(20);
    }];
    
    _sendTimeLabel = [[UILabel alloc] init];
    _sendTimeLabel.font = [UIFont systemFontOfSize:13];
    _sendTimeLabel.textAlignment = 2;
    _sendTimeLabel.textColor = lightBlackTextColor;
    [self addSubview:_sendTimeLabel];
    [_sendTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-10);
        make.top.equalTo(shopTime.mas_bottom).offset(5);
        make.height.mas_offset(20);
    }];
    
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
