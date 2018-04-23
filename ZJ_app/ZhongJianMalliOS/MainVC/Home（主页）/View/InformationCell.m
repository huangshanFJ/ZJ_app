//
//  InformationCell.m
//  ZhongJianMalliOS
//
//  Created by 段 on 2017/12/6.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "InformationCell.h"

@implementation InformationCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self creatCellView];
    }
    return self;
}
- (void)creatCellView {
    
    _kindName = [[UILabel alloc] init];
    _kindName.textColor = lightBlackTextColor;
    _kindName.font = [UIFont systemFontOfSize:13];
    [self addSubview:_kindName];
    [_kindName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(10);
        make.top.mas_offset(0);
        make.height.mas_offset(45);
    }];
    
    _informationLabel = [[UILabel alloc] init];
    _informationLabel.font = [UIFont systemFontOfSize:13];
    _informationLabel.textAlignment = 2;
    _informationLabel.hidden = YES;
    [self addSubview:_informationLabel];
    [_informationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-10);
        make.top.mas_offset(0);
        make.height.mas_offset(45);
    }];
    
    _infoTextField = [[UITextField alloc] init];
    _infoTextField.textAlignment = 2;
    _infoTextField.hidden = YES;
    _infoTextField.textColor = lightBlackTextColor;
    _infoTextField.font = [UIFont systemFontOfSize:13];
    [self addSubview:_infoTextField];
    [_infoTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-10);
        make.top.mas_offset(0);
        make.height.mas_offset(45);
    }];
    
//    _getCodeButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    [_getCodeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
//    _getCodeButton.
//
    _nextImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"next"]];
    _nextImage.hidden = YES;
    [self addSubview:_nextImage];
    [_nextImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-10);
        make.centerY.mas_offset(0);
        make.width.mas_offset(11);
        make.height.mas_offset(11);
    }];
    UILabel *line = [[UILabel alloc] init];
    line.backgroundColor = [UIColor colorWithHexString:@"dcdcdc"];
    [self addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(0);
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
