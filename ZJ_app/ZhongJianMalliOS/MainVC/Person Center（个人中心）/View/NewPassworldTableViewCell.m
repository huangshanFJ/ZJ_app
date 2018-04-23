//
//  NewPassworldTableViewCell.m
//  ZhongJianMalliOS
//
//  Created by 段 on 2017/12/14.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "NewPassworldTableViewCell.h"

@implementation NewPassworldTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initViewCell];
    }
    return self;
}
- (void)initViewCell {
    
    _prefixPWNameLabel = [[UILabel alloc] init];
    _prefixPWNameLabel.font = [UIFont systemFontOfSize:13];
    _prefixPWNameLabel.textColor = lightBlackTextColor;
    [self addSubview:_prefixPWNameLabel];
    [_prefixPWNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(10);
        make.top.mas_offset(0);
        make.height.mas_offset(45);
    }];
    _passworldTF = [[UITextField alloc] init];
    _passworldTF.font = [UIFont systemFontOfSize:13];
    _passworldTF.secureTextEntry = YES;
    [self addSubview:_passworldTF];
    [_passworldTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_prefixPWNameLabel.mas_right).offset(10);
        make.width.mas_offset(KWIDTH*0.6);
        make.top.mas_offset(0);
        make.height.mas_offset(45);
    }];
    UILabel *line = [[UILabel alloc] init];
    line.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];
    [self addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(0);
        make.bottom.mas_offset(0);
        make.right.mas_offset(0);
        make.height.mas_offset(1);
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
