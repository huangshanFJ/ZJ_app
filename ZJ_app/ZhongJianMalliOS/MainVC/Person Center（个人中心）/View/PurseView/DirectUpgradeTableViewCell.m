//
//  DirectUpgradeTableViewCell.m
//  ZhongJianMalliOS
//
//  Created by 段 on 2017/12/29.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "DirectUpgradeTableViewCell.h"

@implementation DirectUpgradeTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initCellView];
    }
    return self;
}
- (void)initCellView {
    self.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];
    UIImageView *bgImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg-2"]];
    [self addSubview:bgImage];
    [bgImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(5);
        make.right.mas_offset(-5);
        make.height.mas_offset(80);
        make.top.mas_offset(0);
    }];
    
    _headImageIcon = [[UIImageView alloc] init];
    [bgImage addSubview:_headImageIcon];
    [_headImageIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(15);
        make.centerY.mas_offset(0);
        make.height.mas_offset(20);
        make.width.mas_offset(20);
    }];
    
    _kindNameLabel = [[UILabel alloc] init];
    _kindNameLabel.textColor = lightBlackTextColor;
    _kindNameLabel.font = [UIFont systemFontOfSize:15];
    [bgImage addSubview:_kindNameLabel];
    [_kindNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_headImageIcon.mas_right).offset(11);
        make.height.mas_offset(20);
//        make.top.mas_offset(18);
        make.centerY.mas_offset(0);
        make.width.mas_equalTo(KWIDTH*0.6);
    }];
    
//    _kindDetailLabel = [[UILabel alloc] init];
//    _kindDetailLabel.textColor = lightgrayTextColor;
//    _kindDetailLabel.font = [UIFont systemFontOfSize:12];
//    [bgImage addSubview:_kindDetailLabel];
//    [_kindDetailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(_headImageIcon.mas_right).offset(11);
//        make.height.mas_offset(20);
//        make.top.equalTo(_kindNameLabel.mas_bottom).offset(0);
//    }];
    
    UIImageView *nextImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"next"]];
    [bgImage addSubview:nextImage];
    [nextImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(bgImage.mas_right).offset(-15);
        make.height.mas_offset(12);
        make.width.mas_offset(12);
        make.centerY.equalTo(bgImage.mas_centerY).offset(0);
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
