//
//  ShopSettleCell.m
//  ZhongJianMalliOS
//
//  Created by hismobile on 2018/3/8.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "ShopSettleCell.h"

@implementation ShopSettleCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self creatView];
    }
    return self;
}
- (void)creatView {
    
    self.backgroundColor = [UIColor whiteColor];
    _headImage = [[UIImageView alloc] init];
    _headImage.layer.cornerRadius = 5;
    _headImage.layer.masksToBounds = YES;
    [self addSubview:_headImage];
    [_headImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(10);
        make.width.mas_offset(70);
        make.height.mas_offset(70);
        make.top.mas_offset(10);
    }];
    
    _headLabel = [[UILabel alloc] init];
    _headLabel.textColor = [UIColor colorWithHexString:@"444444"];
    _headLabel.font = [UIFont systemFontOfSize:13];
    [self addSubview:_headLabel];
    [_headLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_headImage.mas_right).offset(11);
        make.top.mas_offset(10);
        make.right.mas_offset(-15);
    }];
    
    _priceLabel = [[UILabel alloc] init];
    _priceLabel.font = [UIFont systemFontOfSize:15];
    _priceLabel.textColor = [UIColor colorWithHexString:@"ff3a00"];
    [self addSubview:_priceLabel];
    [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_headImage.mas_right).offset(10);
        make.bottom.mas_offset(-10);
        make.height.mas_offset(15);
        
    }];
    _numberLabel = [[UILabel alloc] init];
    _numberLabel.textColor = [UIColor colorWithHexString:@"999999"];
    _numberLabel.font = [UIFont systemFontOfSize:12];
    [self addSubview:_numberLabel];
    [_numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_priceLabel.mas_right).offset(8);
        make.height.mas_offset(10);
        //        make.bottom.mas_offset(-10);
        make.centerY.equalTo(_priceLabel.mas_centerY).offset(0);
        //        make.width.mas_offset(50);
    }];
    UILabel *line = [UILabel new];
    line.backgroundColor = [UIColor colorWithHexString:@"e7e7e7"];
    [self addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(0);
        make.right.mas_offset(0);
        make.height.mas_offset(0.5);
        make.bottom.mas_offset(0);
    }];
    
    
}


@end
