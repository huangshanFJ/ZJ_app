//
//  PurseTableViewCell.m
//  ZhongJianMalliOS
//
//  Created by 段 on 2017/12/21.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "PurseTableViewCell.h"

@implementation PurseTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initWithPurseCellView];
        self.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];
    }
    return self;
}
- (void)initWithPurseCellView {
//    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KWIDTH, 6)];
//    topView.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];
//    [self addSubview:topView];
    
    UIImageView *bgCell = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg-2"]];
    bgCell.userInteractionEnabled = YES;
    [self addSubview:bgCell];
    [bgCell mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(5);
        make.right.mas_offset(-5);
        make.height.mas_offset(74);
        make.top.mas_offset(0);
    }];
    
    _purseImageView = [[UIImageView alloc] init];
    [bgCell addSubview:_purseImageView];
    [_purseImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(20);
        make.centerY.equalTo(bgCell.mas_centerY).offset(0);
        make.width.mas_offset(20);
        make.height.mas_offset(20);
    }];
    _kindPurseLabel = [[UILabel alloc] init];
    _kindPurseLabel.textColor = lightBlackTextColor;
    _kindPurseLabel.font = [UIFont systemFontOfSize:13];
    [bgCell addSubview:_kindPurseLabel];
    [_kindPurseLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_purseImageView.mas_right).offset(10);
        make.centerY.equalTo(bgCell.mas_centerY).offset(0);
        make.height.mas_offset(30);
    }];
    
    
    _nextImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"next"]];
    [bgCell addSubview:_nextImage];
    [_nextImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(bgCell.mas_right).offset(-15);
        make.height.mas_offset(12);
        make.width.mas_offset(12);
        make.centerY.equalTo(bgCell.mas_centerY).offset(0);
    }];
    _priceLabel = [[UILabel alloc] init];
    _priceLabel.font = [UIFont fontWithName:@"Arial Rounded MT Bold" size:17];
    _priceLabel.textColor = lightBlackTextColor;
//    _priceLabel.textAlignment = 2;
    [bgCell addSubview:_priceLabel];
    [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_nextImage.mas_left).offset(-11);
        make.height.mas_offset(30);
        make.centerY.equalTo(bgCell.mas_centerY).offset(0);
    }];
    UILabel *moneyLabel = [[UILabel alloc] init];
    moneyLabel.font = [UIFont fontWithName:@"Arial Rounded MT Bold" size:12];
    moneyLabel.textAlignment = 2;
    moneyLabel.textColor = lightBlackTextColor;
    moneyLabel.text = @"￥";
    [bgCell addSubview:moneyLabel];
    [moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_priceLabel.mas_left).offset(-6);
        make.height.mas_offset(30);
        make.centerY.equalTo(bgCell.mas_centerY).offset(2);
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
