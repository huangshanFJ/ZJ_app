//
//  SpecialgiftTableViewCell.m
//  ZhongJianMalliOS
//
//  Created by 段 on 2017/11/8.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "SpecialgiftTableViewCell.h"

@implementation SpecialgiftTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initUI];
    }
    return self;
}
- (void)initUI {
    _giftImage = [[UIImageView alloc] init];
    [self addSubview:_giftImage];
    [_giftImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(0);
        make.top.mas_offset(7);
        make.width.mas_offset(125);
        make.height.mas_offset(125);
    }];
    _giftNameLabel = [[UILabel alloc] init];
    _giftNameLabel.numberOfLines = 0;
    [self addSubview:_giftNameLabel];
    [_giftNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_giftImage.mas_right).offset(17);
        make.right.mas_offset(20);
        make.top.mas_offset(22);
//        make.height.mas_offset(70);
    }];
    
    _priceLabel = [[UILabel alloc] init];
    
    [self addSubview:_priceLabel];
    [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_giftImage.mas_right).offset(17);
        make.bottom.mas_offset(-30);
        make.height.mas_offset(20);
//        make.width.mas_offset();
    }];
    
    _miniteLabel = [[UILabel alloc] init];
    _miniteLabel.textAlignment = 2;
    [self addSubview:_miniteLabel];
    [_miniteLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-12);
        make.bottom.mas_offset(-30);
        make.height.mas_offset(20);
    }];
    
//    _redPickImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"redPick"]];
//    [self addSubview:_redPickImage];
//    [_redPickImage mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.equalTo(_miniteLabel.mas_left).offset(0);
//        make.width.mas_offset(16);
//        make.height.mas_offset(16);
//        make.centerY.equalTo(_miniteLabel.mas_centerY).offset(0);
//    }];
    
    
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = [UIColor colorWithHexString:@"dcdcdc"];
    [self addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_giftImage.mas_right).offset(17);
        make.right.mas_offset(0);
        make.bottom.mas_offset(-0.5);
        make.height.mas_offset(0.5);
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
