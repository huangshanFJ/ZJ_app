//
//  MyOrderViewCell.m
//  ZhongJianMalliOS
//
//  Created by 段 on 2017/12/15.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "MyOrderViewCell.h"

@implementation MyOrderViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initCellView];
    }
    return self;
}
- (void)initCellView {
    UIView *grayView = [[UIView alloc] init];
    grayView.backgroundColor = [UIColor colorWithHexString:@"fbfbfb"];
    [self addSubview:grayView];
    [grayView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(0);
        make.top.mas_offset(0);
        make.right.mas_offset(0);
        make.height.mas_offset(90);
    }];
    
    _headImage = [[UIImageView alloc] init];
    _headImage.layer.borderWidth = 0.5;
    _headImage.layer.borderColor = [UIColor colorWithHexString:@"f2f2f2"].CGColor;
    [grayView addSubview:_headImage];
    [_headImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(10);
        make.top.equalTo(grayView.mas_top).offset(15);
        make.width.mas_offset(70);
        make.height.mas_offset(70);
    }];
    _orderPriceLabel = [[UILabel alloc] init];
    _orderPriceLabel.textColor = lightgrayTextColor;
    _orderPriceLabel.text = @"￥ 128";
    _orderPriceLabel.textAlignment = 2;
    _orderPriceLabel.font = [UIFont systemFontOfSize:13];
    [grayView addSubview:_orderPriceLabel];
    [_orderPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-10);
        make.top.equalTo(grayView.mas_top).offset(15);
        make.height.mas_offset(14);
    }];
    
    _orderNumberLabel = [[UILabel alloc] init];
    _orderNumberLabel.textColor = lightgrayTextColor;
    _orderNumberLabel.font = [UIFont systemFontOfSize:13];
    _orderNumberLabel.textAlignment = 2;
    [grayView addSubview:_orderNumberLabel];
    [_orderNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-10);
        make.top.equalTo(_orderPriceLabel.mas_bottom).offset(5);
        make.height.mas_offset(14);
    }];
    
    _orderNameLabel = [[UILabel alloc] init];
    _orderNameLabel.textColor = lightBlackTextColor;
    _orderNameLabel.font = [UIFont systemFontOfSize:13];
    [grayView addSubview:_orderNameLabel];
    [_orderNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_headImage.mas_right).offset(10);
        make.right.equalTo(_orderNumberLabel.mas_left).offset(-20);
        make.top.equalTo(grayView.mas_top).offset(15);
    }];
    
//
    
    
}
//- (void)payButtonClick:(UIButton*)sender {
//    
//}
//- (void)cancelButtonClick:(UIButton *)sender {
//    sender.selected = !sender.selected;
//    !_cancelButtonButtonBlock ? : _cancelButtonButtonBlock();
//}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
