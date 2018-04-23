//
//  CommercialCell.m
//  ZhongJianMalliOS
//
//  Created by 段 on 2017/12/5.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "CommercialCell.h"

@implementation CommercialCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self creatCell];
    }
    return self;
    
}
- (void)creatCell {
    
    _iconImage = [[UIImageView alloc] init];
    _iconImage.layer.cornerRadius = 5;
    _iconImage.layer.masksToBounds = YES;
    [self addSubview:_iconImage];
    [_iconImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(11);
        make.width.mas_offset(81);
        make.height.mas_offset(81);
        make.top.mas_offset(16);
    }];
    _headTitleLabel = [[UILabel alloc] init];
    _headTitleLabel.textColor = lightBlackTextColor;
    _headTitleLabel.font = [UIFont systemFontOfSize:15];
    [self addSubview:_headTitleLabel];
    [_headTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_iconImage.mas_right).offset(12);
        make.top.mas_offset(10);
        make.height.mas_offset(20);
    }];
    _isOnLineLabel = [[UILabel alloc] init];
    _isOnLineLabel.textAlignment = 1;
    _isOnLineLabel.font = [UIFont systemFontOfSize:11];
    _isOnLineLabel.layer.cornerRadius = 7;
    _isOnLineLabel.layer.masksToBounds = YES;
    _isOnLineLabel.layer.borderWidth = 0.5;
    [self addSubview:_isOnLineLabel];
    [_isOnLineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_headTitleLabel.mas_right).offset(7);
        make.width.mas_offset(31);
        make.height.mas_offset(15);
        make.centerY.equalTo(_headTitleLabel.mas_centerY).offset(0);
    }];
    _detailTitleLabel = [[UILabel alloc] init];
    _detailTitleLabel.font = [UIFont systemFontOfSize:12];
    _detailTitleLabel.textColor = lightgrayTextColor;
    _detailTitleLabel.numberOfLines = 0;
    [self addSubview:_detailTitleLabel];
    [_detailTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_iconImage.mas_right).offset(12);
        make.top.equalTo(_headTitleLabel.mas_bottom).offset(0);
        make.right.mas_offset(-13);
    }];
    
    _priceLabel = [[UILabel alloc] init];
    _priceLabel.font = [UIFont systemFontOfSize:12];
    [self addSubview:_priceLabel];
    [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_iconImage.mas_right).offset(12);
        make.height.mas_offset(15);
        make.bottom.equalTo(_iconImage.mas_bottom).offset(0);
    }];
    
    _numberPeopleLabel = [[UILabel alloc] init];
    _numberPeopleLabel.textColor = lightBlackTextColor;
    _numberPeopleLabel.textAlignment = 2;
    _numberPeopleLabel.font = [UIFont systemFontOfSize:12];
    [self addSubview:_numberPeopleLabel];
    [_numberPeopleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-13);
        make.height.mas_offset(15);
        make.bottom.equalTo(_iconImage.mas_bottom).offset(0);
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
