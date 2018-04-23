//
//  OrderDetailAdressCell.m
//  ZhongJianMalliOS
//
//  Created by 段 on 2017/12/4.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "OrderDetailAdressCell.h"

@implementation OrderDetailAdressCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initCellView];
    }
    
    return self;
}
- (void)initCellView {
    
    UIView *orderBGView = [[UIView alloc] init];
    orderBGView.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];
    [self addSubview:orderBGView];
    [orderBGView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(0);
        make.right.mas_offset(0);
        make.top.mas_offset(0);
        make.bottom.mas_offset(0);
    }];
    
    UIImageView *topImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"adressbg"]];
    [orderBGView addSubview:topImageView];
    [topImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(0);
        make.top.mas_offset(7);
        make.right.mas_offset(0);
        make.height.mas_offset(3);
    }];
    
    _nameLabel = [[UILabel alloc] init];
    _nameLabel.textColor = lightBlackTextColor;
    _nameLabel.font = [UIFont systemFontOfSize:13];
    [orderBGView addSubview:_nameLabel];
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topImageView.mas_bottom).offset(5);
        make.height.mas_offset(25);
        make.left.mas_offset(11);
    }];
    _phoneLabel = [[UILabel alloc] init];
    _phoneLabel.textColor = lightBlackTextColor;
    _phoneLabel.font = [UIFont systemFontOfSize:13];
    [orderBGView addSubview:_phoneLabel];
    [_phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_nameLabel.mas_right).offset(30);
        make.top.equalTo(topImageView.mas_bottom).offset(5);
        make.height.mas_offset(25);
    }];
    _detailAdressLabel = [[UILabel alloc] init];
    _detailAdressLabel.textColor = lightBlackTextColor;
    _detailAdressLabel.font = [UIFont systemFontOfSize:13];
    [orderBGView addSubview:_detailAdressLabel];
    [_detailAdressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(11);
        make.top.equalTo(_nameLabel.mas_bottom).offset(0);
        make.height.mas_offset(25);

    }];
    
    UIImageView *bottomView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"adressbg"]];
    [orderBGView addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(0);
        make.right.mas_offset(0);
        make.height.mas_offset(3);
        make.bottom.mas_offset(0);
    }];
    UIImageView *nextImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"next"]];
    [self addSubview:nextImage];
    [nextImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-10);
        make.centerY.equalTo(self.mas_centerY).offset(0);
        make.width.mas_offset(13);
        make.height.mas_offset(13);
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
