//
//  HealthCell.m
//  ZhongJianMalliOS
//
//  Created by 段 on 2017/12/7.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "HealthCell.h"

@implementation HealthCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self ) {
        [self creatCellView];
    }
    return self;
}
- (void)creatCellView {
    self.backgroundColor = [UIColor whiteColor];
    _headImageView = [[UIImageView alloc] init];
    _headImageView.layer.cornerRadius = 5;
    [self addSubview:_headImageView];
    [_headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(10);
        make.right.mas_offset(-10);
        make.top.mas_offset(20);
        make.height.mas_offset(177);
    }];
    
    _headTitleLabel = [[UILabel alloc] init];
    _headTitleLabel.font = [UIFont fontWithName:@"Arial Rounded MT Bold" size:15];
    _headTitleLabel.textColor = lightBlackTextColor;
    [self addSubview:_headTitleLabel];
    [_headTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(10);
        make.top.equalTo(_headImageView.mas_bottom).offset(10);
        make.height.mas_offset(22);
    }];
    
    _kindNameLabel = [[UILabel alloc] init];
    _kindNameLabel.font = [UIFont systemFontOfSize:11];
    _kindNameLabel.textAlignment = 1;
    [self addSubview:_kindNameLabel];
    [_kindNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_headTitleLabel.mas_right).offset(10);
        make.width.mas_offset(31);
        make.height.mas_offset(15);
        make.centerY.equalTo(_headTitleLabel.mas_centerY).offset(0);
    }];
    _detailTitleLabel = [[UILabel alloc] init];
    _detailTitleLabel.textColor = lightgrayTextColor;
    _detailTitleLabel.font = [UIFont systemFontOfSize:12];
    _detailTitleLabel.numberOfLines = 0;
    [self addSubview:_detailTitleLabel];
    [_detailTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(10);
        make.top.equalTo(_headTitleLabel.mas_bottom).offset(5);
        make.right.mas_offset(-10);
    }];
    
    UIView *bottomView = [[UIView alloc] init];
    bottomView.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];
    [self addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(0);
        make.right.mas_offset(0);
        make.height.mas_offset(7);
        make.bottom.mas_offset(0);
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
