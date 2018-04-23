//
//  RecordCell.m
//  ZhongJianMalliOS
//
//  Created by 段 on 2017/12/25.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "RecordCell.h"

@implementation RecordCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initCellView];
    }
    return self;
}
- (void)initCellView {
    
//    _headImageView = [[UIImageView alloc] init];
//    _headImageView.layer.cornerRadius = 20;
//    _headImageView.layer.masksToBounds = YES;
//    [self addSubview:_headImageView];
//    [_headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_offset(10);
//        make.centerY.mas_offset(0);
//        make.width.mas_offset(40);
//        make.height.mas_offset(40);
//    }];
    
    _kindNameLabel = [self creatLabelfont:[UIFont fontWithName:@"Arial Rounded MT Bold" size:15] color:[UIColor colorWithHexString:@"444444"]];
    _kindNameLabel.numberOfLines = 2;
    [self addSubview:_kindNameLabel];
    [_kindNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(_headImageView.mas_right).offset(15);
        make.left.mas_offset(10);
//        make.height.mas_offset(25);
        make.width.mas_offset(KWIDTH*0.8);
        make.top.mas_offset(5);
    }];
    _timeLabel = [self creatLabelfont:[UIFont systemFontOfSize:12] color:[UIColor colorWithHexString:@"999999"]];
    [self addSubview:_timeLabel];
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(_headImageView.mas_right).offset(15);
        make.left.mas_offset(10);
        make.height.mas_offset(16);
//        make.bottom.equalTo(_headImageView.mas_bottom).offset(0);
        make.bottom.mas_offset(-5);
    }];
    _priceLabel = [self creatLabelfont:[UIFont fontWithName:@"Arial Rounded MT Bold" size:17] color:[UIColor colorWithHexString:@"444444"]];
    _priceLabel.textAlignment = 2;
    [self addSubview:_priceLabel];
    [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-10);
        make.height.mas_offset(20);
        make.centerY.mas_offset(0);
    }];
    UILabel *line = [UILabel new];
    line.backgroundColor = [UIColor colorWithHexString:@"dcdcdc"];
    [self addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(10);
        make.right.mas_offset(0);
        make.height.mas_offset(0.5);
        make.bottom.mas_offset(0);
    }];
    
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (UILabel *)creatLabelfont:(UIFont *)font color:(UIColor *)color {
    UILabel *label = [[UILabel alloc] init];
//    label.text = text;
    label.textColor = color;
    label.font = font;
    
    return label;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
