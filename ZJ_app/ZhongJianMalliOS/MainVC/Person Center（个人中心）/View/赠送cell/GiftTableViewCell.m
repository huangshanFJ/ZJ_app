//
//  GiftTableViewCell.m
//  ZhongJianMalliOS
//
//  Created by 段 on 2018/1/31.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "GiftTableViewCell.h"

@implementation GiftTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (!self) {
        [self initWithCellView];
    }
    return self;
}
- (void)initWithCellView {
    _headImageIcon = [[UIImageView alloc] init];
    _headImageIcon.layer.masksToBounds = YES;
    _headImageIcon.layer.cornerRadius = 30;
    _headImageIcon.backgroundColor = [UIColor blueColor];
    [self addSubview:_headImageIcon];
    [_headImageIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(10);
        make.height.mas_offset(60);
        make.top.mas_offset(10);
        make.width.mas_offset(60);
    }];
    _nameLabel = [[UILabel alloc] init];

    _nameLabel.textColor = lightgrayTextColor;
    _nameLabel.text = @"111";
    _nameLabel.font = [UIFont systemFontOfSize:12];
    [self addSubview:_nameLabel];
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_headImageIcon.mas_right).offset(10);
        make.top.equalTo(_headImageIcon.mas_top).offset(0);
        make.height.mas_offset(20);
        make.width.mas_offset(KWIDTH*0.4);
    }];
    
    _phoneLabel = [[UILabel alloc] init];
    _phoneLabel.textColor = lightgrayTextColor;
    _phoneLabel.font = [UIFont systemFontOfSize:12];
    [self addSubview:_phoneLabel];
    [_phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_headImageIcon.mas_right).offset(10);
        make.height.mas_offset(20);
        make.top.equalTo(_nameLabel.mas_bottom).offset(10);
        make.width.mas_offset(KWIDTH*0.4);
    }];
    
    _zjNumberLabel = [[UILabel alloc] init];
    _zjNumberLabel.font = [UIFont fontWithName:@"Arial Rounded MT Bold"  size:14];
    _zjNumberLabel.textColor = lightBlackTextColor;
    [self addSubview:_zjNumberLabel];
    [_zjNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-10);
        make.height.mas_offset(20);
        make.centerY.mas_offset(0);
        make.width.mas_offset(KWIDTH*0.4);
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
