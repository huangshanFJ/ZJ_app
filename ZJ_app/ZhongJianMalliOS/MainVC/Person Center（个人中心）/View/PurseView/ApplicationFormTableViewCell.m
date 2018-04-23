//
//  ApplicationFormTableViewCell.m
//  ZhongJianMalliOS
//
//  Created by 段 on 2018/1/2.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "ApplicationFormTableViewCell.h"

@implementation ApplicationFormTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initCellView];
    }
    return self;
}
- (void)initCellView {
    _kindNameLabel = [[UILabel alloc] init];
    _kindNameLabel.font = [UIFont systemFontOfSize:13];
    _kindNameLabel.textColor = lightBlackTextColor;
    [self addSubview:_kindNameLabel];
    [_kindNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(10);
        make.centerY.mas_offset(0);
        make.height.mas_offset(45);
        make.width.mas_offset(70);
    }];
//    _inputTextField = [[UITextField alloc] init];
//    _inputTextField.textAlignment = 0;
//    _inputTextField.textColor = lightBlackTextColor;
//    _inputTextField.font = [UIFont systemFontOfSize:13];
//    [self addSubview:_inputTextField];
//    [_inputTextField mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(_kindNameLabel.mas_right).offset(0);
//        make.centerY.mas_offset(0);
//        make.height.mas_offset(45);
//        make.width.mas_offset(KWIDTH-120);
//    }];
    _nextImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"next"]];
    _nextImage.hidden = YES;
    [self addSubview:_nextImage];
    [_nextImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-8);
        make.width.mas_offset(13);
        make.height.mas_offset(13);
        make.centerY.mas_offset(0);
    }];
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = [UIColor colorWithHexString:@"dcdcdc"];
    [self addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.bottom.mas_equalTo(-0.5);
        make.height.mas_equalTo(0.5);
        make.right.mas_equalTo(0);
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
