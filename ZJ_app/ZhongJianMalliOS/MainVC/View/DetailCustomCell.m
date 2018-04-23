//
//  DetailCustomCell.m
//  ZhongJianMalliOS
//
//  Created by 段 on 2017/11/22.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "DetailCustomCell.h"

@implementation DetailCustomCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self creatView];
    }
    return self;
}
- (void)creatView {
    _detailNameLabel = [[UILabel alloc] init];
    _detailNameLabel.font = [UIFont fontWithName:@"Arial Rounded MT Bold" size:15];
    _detailNameLabel.textColor = [UIColor colorWithHexString:@"444444"];
    [self addSubview:_detailNameLabel];
    [_detailNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(10);
        make.top.mas_offset(10);
        make.height.mas_offset(30);
    }];
    _priceLabel = [[UILabel alloc] init];
    _priceLabel.textColor = [UIColor colorWithHexString:@"ff3a00"];
    [self addSubview:_priceLabel];
    [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(10);
        make.top.equalTo(_detailNameLabel.mas_bottom).offset(5);
        make.height.mas_offset(20);
        make.width.mas_offset(KWIDTH*0.5);
    }];
    _miniteLabel = [[UILabel alloc] init];
    _miniteLabel.font = [UIFont systemFontOfSize:11];
    _miniteLabel.textColor = [UIColor colorWithHexString:@"999999"];
    [self addSubview:_miniteLabel];
    UIImageView *redpackeImageV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"redpacket"]];
    [self addSubview:redpackeImageV];
    [redpackeImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(10);
        make.width.mas_offset(12);
        make.height.mas_offset(12);
        make.top.equalTo(_priceLabel.mas_bottom).offset(5);
    }];
    [_miniteLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(redpackeImageV.mas_right);
        make.width.mas_offset(KWIDTH*0.3);
        make.height.mas_offset(12);
        make.top.equalTo(_priceLabel.mas_bottom).offset(5);
    }];
    _reserveLable = [[UILabel alloc] init];
    _reserveLable.font = [UIFont systemFontOfSize:11];
    _reserveLable.textColor = [UIColor colorWithHexString:@"999999"];
    _reserveLable.textAlignment = 1;
    [self addSubview:_reserveLable];
    [_reserveLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_miniteLabel.mas_right).offset(0);
        make.width.mas_offset(KWIDTH*0.4);
        make.height.mas_offset(12);
        make.top.equalTo(_priceLabel.mas_bottom).offset(5);
    }];
    _placeLable = [[UILabel alloc] init];
    _placeLable.font = [UIFont systemFontOfSize:11];
    _placeLable.textAlignment = 2;
    _placeLable.textColor = [UIColor colorWithHexString:@"999999"];
    [self addSubview:_placeLable];
    [_placeLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-10);
        make.width.mas_offset(KWIDTH*0.3);
        make.height.mas_offset(12);
        make.top.equalTo(_priceLabel.mas_bottom).offset(5);
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
