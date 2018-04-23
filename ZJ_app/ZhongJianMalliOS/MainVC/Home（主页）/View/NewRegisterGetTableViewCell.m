//
//  NewRegisterGetTableViewCell.m
//  ZhongJianMalliOS
//
//  Created by 段 on 2017/11/13.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "NewRegisterGetTableViewCell.h"

@implementation NewRegisterGetTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initHeadView];
    }
    return self;
}
- (void)initHeadView {
    
    UIImageView *bgImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"coupon"]];
    [self addSubview:bgImage];
    [bgImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(5);
        make.right.mas_offset(-5);
        make.top.mas_offset(0);
        make.height.mas_offset(126);
    }];
    
    _couponLabel = [[UILabel alloc] init];
    _couponLabel.text = @"全场通用券";
    _couponLabel.font = [UIFont fontWithName:@"Arial Rounded MT Bold" size:17];
    _couponLabel.textColor = [UIColor colorWithHexString:@"444444"];
    [bgImage addSubview:_couponLabel];
    [_couponLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(26);
        make.top.mas_offset(27);
        make.height.mas_offset(20);
//        make.width.mas_offset(80);
    }];
    
    _priceLabel = [[UILabel alloc] init];
    _priceLabel.textColor = [UIColor colorWithHexString:@"444444"];
    _priceLabel.font = [UIFont systemFontOfSize:12];
    [bgImage addSubview:_priceLabel];
    [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(26);
        make.top.equalTo(_couponLabel.mas_bottom).offset(12);
        make.height.mas_offset(20);
        make.width.mas_offset(80);
    }];
    
    _priceNumber = [[UILabel alloc] init];
    _priceNumber.textColor = [UIColor colorWithHexString:@"fa3636"];
    _priceNumber.textAlignment = 2;
    [bgImage addSubview:_priceNumber];
    [_priceNumber mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-28);
        make.top.mas_offset(27);
        make.height.mas_offset(30);
    }];
    
    _timerLabel = [[UILabel alloc] init];
    _timerLabel.textColor = [UIColor colorWithHexString:@"999999"];
    _timerLabel.font = [UIFont systemFontOfSize:12];
    [bgImage addSubview:_timerLabel];
    [_timerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(26);
        make.height.mas_offset(20);
        make.bottom.mas_offset(-14);
    }];
    
    _getCoupon = [UIButton buttonWithType:UIButtonTypeCustom];
    _getCoupon.backgroundColor = [UIColor colorWithHexString:@"fa3636"];
    _getCoupon.layer.cornerRadius = 5;
    _getCoupon.layer.masksToBounds = YES;
    [_getCoupon setTitle:@"立即领取" forState:UIControlStateNormal];
    _getCoupon.titleLabel.font = [UIFont systemFontOfSize:12];
    [bgImage addSubview:_getCoupon];
    [_getCoupon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_timerLabel.mas_centerY).offset(0);
        make.height.mas_offset(20);
        make.width.mas_offset(65);
        make.right.mas_offset(-28);
    }];
    
    UIView *footView = [[UIView alloc] init];
    [self addSubview:footView];
    [footView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(0);
        make.top.equalTo(bgImage.mas_bottom).offset(0);
        make.height.mas_offset(12);
        make.right.mas_offset(0);
    }];
    self.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];
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
