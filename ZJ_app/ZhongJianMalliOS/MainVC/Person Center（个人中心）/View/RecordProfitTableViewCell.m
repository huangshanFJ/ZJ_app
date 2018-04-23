//
//  RecordProfitTableViewCell.m
//  ZhongJianMalliOS
//
//  Created by 段 on 2018/1/2.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "RecordProfitTableViewCell.h"

@implementation RecordProfitTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initViewCell];
    }
    return self;
}
- (void)initViewCell {
    UIImageView *topImage = [[UIImageView alloc] init];
    topImage.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];
    [self addSubview:topImage];
    [topImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.width.mas_equalTo(KWIDTH);
        make.height.mas_equalTo(8);
    }];
    
    UIView *topView = [[UIView alloc] init];
    topView.backgroundColor = [UIColor whiteColor];
    [self addSubview:topView];
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.height.mas_equalTo(40);
        make.width.mas_equalTo(KWIDTH);
        make.top.equalTo(topImage.mas_bottom).offset(0);
    }];
    
    _headIconImage = [[UIImageView alloc] init];
    [topView addSubview:_headIconImage];
    [_headIconImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(20);
        make.centerY.equalTo(topView.mas_centerY).offset(0);
    }];
    
    _kindNameLabel = [self creatLabelText:@"现金币" font:[UIFont systemFontOfSize:14]   color:lightBlackTextColor];
    
    [topView addSubview:_kindNameLabel];
    [_kindNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_headIconImage.mas_right).offset(8);
        make.height.mas_equalTo(40);
        make.centerY.equalTo(topView.mas_centerY).offset(0);
    }];
    
    _timeLabel = [self creatLabelText:@"" font:[UIFont systemFontOfSize:12]  color:lightgrayTextColor];
    _timeLabel.textAlignment = 2;
    [topView addSubview:_timeLabel];
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-10);
        make.height.mas_equalTo(40);
        make.centerY.equalTo(topView.mas_centerY).offset(0);
    }];
    
    UILabel *line = [[UILabel alloc] init];
    line.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];
    [self addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.width.mas_equalTo(KWIDTH);
        make.height.mas_equalTo(1);
        make.top.equalTo(topView.mas_bottom).offset(0);
    }];
    
    UIView *bottomView = [[UIView alloc] init];
    bottomView.backgroundColor = [UIColor whiteColor];
    [self addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.equalTo(line.mas_bottom).offset(0);
        make.height.mas_equalTo(78);
        make.width.mas_equalTo(KWIDTH);
    }];
    
    UILabel *kindOfFansLabel = [self creatLabelText:@"粉丝类型" font:[UIFont systemFontOfSize:13] color:lightBlackTextColor];
    [bottomView addSubview:kindOfFansLabel];
    [kindOfFansLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.height.mas_equalTo(39);
        make.top.equalTo(bottomView.mas_top).offset(0);
    }];
    UILabel *getProfitLabel = [self creatLabelText:@"分润所得" font:[UIFont systemFontOfSize:13] color:lightBlackTextColor];
    [bottomView addSubview:getProfitLabel];
    [getProfitLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.height.mas_equalTo(39);
        make.top.equalTo(kindOfFansLabel.mas_bottom).offset(0);
    }];
    
    _fansKindLabel = [self creatLabelText:@"红粉" font:[UIFont fontWithName:@"Arial Rounded MT Bold" size:13] color:lightBlackTextColor];
    _fansKindLabel.textAlignment = 2;
    [bottomView addSubview:_fansKindLabel];
    [_fansKindLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-10);
        make.height.mas_equalTo(39);
        make.top.equalTo(bottomView.mas_top).offset(0);
    }];
    
    _fansMoneyLabel = [self creatLabelText:@"￥1000" font:[UIFont fontWithName:@"Arial Rounded MT Bold" size:13] color:lightBlackTextColor];
    _fansMoneyLabel.textAlignment = 2;
    [bottomView addSubview:_fansMoneyLabel];
    [_fansMoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-10);
        make.height.mas_equalTo(39);
        make.top.equalTo(kindOfFansLabel.mas_bottom).offset(0);
    }];
    
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (UILabel *)creatLabelText:(NSString *)text font:(UIFont *)font   color:(UIColor *)color {
    UILabel *label = [[UILabel alloc] init];
    label.text = text;
    label.textColor = color;
    label.font = font;
    
    return label;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
