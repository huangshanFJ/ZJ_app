//
//  ShopShowCell.m
//  ZhongJianMalliOS
//
//  Created by 段 on 2017/11/2.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "ShopShowCell.h"

@implementation ShopShowCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initUI];
    }
    return self;
}
- (void)initUI {
    _shopImage = [[UIImageView alloc] init];
    [self.contentView addSubview:_shopImage];
    [_shopImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(0);
        make.width.mas_offset(KWIDTH/2 - 4);
        make.height.mas_offset(184);
        make.top.mas_offset(0);
    }];
    
//    _kindLabel = [[UILabel alloc] init];
//    _kindLabel.font = [UIFont systemFontOfSize:12];
//    _kindLabel.layer.cornerRadius = 2;
//    _kindLabel.layer.masksToBounds = YES;
//    _kindLabel.textColor = [UIColor whiteColor];
//    [self addSubview:_kindLabel];
//
//    [_kindLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_offset(10);
//        make.width.mas_offset(28);
//        make.height.mas_offset(12);
//        make.top.equalTo(_shopImage.mas_bottom).offset(10);
//    }];
    
    _nameLabel = [[UILabel alloc] init];
    _nameLabel.font = [UIFont systemFontOfSize:13];
    _nameLabel.numberOfLines = 0;
    _nameLabel.textColor = [UIColor colorWithHexString:@"#444444"];
    
    [self addSubview:_nameLabel];
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(_kindLabel.mas_right).offset(5);
        make.left.mas_offset(10);
        make.top.equalTo(_shopImage.mas_bottom).offset(8);
//        make.height.mas_offset(20);
        make.right.mas_offset(-10);
    }];
    
    _priceLabel = [[UILabel alloc] init];
    _priceLabel.textColor = [UIColor colorWithHexString:@"#ff3a00"];
    _priceLabel.font = [UIFont fontWithName:@"Arial Rounded MT Bold" size:15];
    [self addSubview:_priceLabel];
    
    [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(10);
        make.width.mas_offset(60);
        make.height.mas_offset(18);
        make.bottom.mas_offset(-9);
    }];
    
    _minitLabel = [[UILabel alloc] init];
    _minitLabel.textColor = [UIColor colorWithHexString:@"ffb11b"];
    _minitLabel.font = [UIFont fontWithName:@"Arial Rounded MT Bold" size:15];
    _minitLabel.textAlignment = 2;
    [self addSubview:_minitLabel];

    [_minitLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-10);
        make.bottom.mas_offset(-9);
        make.width.mas_offset(80);

    }];
//    _redPrice = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"redpacket"]];
//    [self addSubview:_redPrice];
//    [_redPrice mas_makeConstraints:^(MASConstraintMaker *make) {
////        make.right.mas_offset(-10);
//        make.right.equalTo(_minitLabel.mas_left).offset(0);
//        make.bottom.mas_offset(-9);
//        make.width.mas_offset(16);
//        make.height.mas_offset(16);
//    }];
    
    
}
@end
