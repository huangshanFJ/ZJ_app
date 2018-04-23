//
//  FansTableViewCell.m
//  ZhongJianMalliOS
//
//  Created by 段 on 2017/12/29.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "FansTableViewCell.h"

@implementation FansTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initCellView];
    }
    return self;
}
- (void)initCellView {
    
    _headIconImage = [[UIImageView alloc] init];
    _headIconImage.layer.cornerRadius = 20;
    _headIconImage.layer.masksToBounds = YES;
    [self addSubview:_headIconImage];
    [_headIconImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(10);
        make.width.mas_offset(40);
        make.height.mas_offset(40);
        make.centerY.mas_offset(0);
    }];
    
    _nameLabel = [[UILabel alloc] init];
    _nameLabel.textColor = lightBlackTextColor;
    _nameLabel.font = [UIFont systemFontOfSize:14];
    [self addSubview:_nameLabel];
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_headIconImage.mas_right).offset(15);
        make.top.equalTo(_headIconImage.mas_top).offset(0);
        make.height.mas_offset(16);
    }];
 
//    _kindLabel = [[UILabel alloc] init];
//    _kindLabel.textColor = zjTextColor;
//    _kindLabel.font = [UIFont systemFontOfSize:12];
//    _kindLabel.layer.cornerRadius = 7;
//    _kindLabel.layer.masksToBounds = YES;
//    _kindLabel.textAlignment = 1;
//    _kindLabel.layer.borderWidth = 0.5;
//    _kindLabel.layer.borderColor = zjTextColor.CGColor;
//    [self addSubview:_kindLabel];
//    [_kindLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(_nameLabel.mas_right).offset(6);
//        make.width.mas_offset(28);
//        make.height.mas_offset(14);
//        make.centerY.equalTo(_nameLabel.mas_centerY).offset(0);
//    }];
    
    _nameID = [[UILabel alloc] init];
    _nameID.textColor = lightgrayTextColor;
    _nameID.font = [UIFont systemFontOfSize:12];
    _nameID.text = @"id: 123456";
    [self addSubview:_nameID];
    [_nameID mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_headIconImage.mas_right).offset(15);
        make.height.mas_offset(16);
        make.bottom.equalTo(_headIconImage.mas_bottom).offset(0);
    }];
    
    _contributionNumberLabel = [[UILabel alloc] init];
    _contributionNumberLabel.textAlignment = 2;
    _contributionNumberLabel.font = [UIFont fontWithName:@"Arial Rounded MT Bold" size:14];
    [self addSubview:_contributionNumberLabel];
    [_contributionNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-10);
        make.centerY.mas_offset(0);
        make.height.mas_offset(20);
    }];
    
    UILabel *contribution = [[UILabel alloc] init];
    contribution.text = @"贡献：";
    contribution.font = [UIFont fontWithName:@"Arial Rounded MT Bold" size:14];
    contribution.textAlignment = 2;
    [self addSubview:contribution];
    [contribution mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-70);
        make.height.mas_offset(20);
        make.centerY.mas_offset(0);
    }];
 
    UILabel *line = [UILabel new];
    line.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];
    [self addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(0);
        make.height.mas_offset(0.5);
        make.bottom.mas_offset(0);
        make.right.mas_offset(0);
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
