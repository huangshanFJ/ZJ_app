//
//  OrderCouponNumberCell.m
//  ZhongJianMalliOS
//
//  Created by 段 on 2017/12/4.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "OrderCouponNumberCell.h"

@implementation OrderCouponNumberCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self creatCellView];
    }
    return self;
}
- (void)creatCellView {
    _kindNameLabel = [[UILabel alloc] init];
    _kindNameLabel.textColor = [UIColor colorWithHexString:@"444444"];
    _kindNameLabel.font = [UIFont systemFontOfSize:13];
    [self addSubview:_kindNameLabel];
    [_kindNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(10);
        make.width.mas_offset(KWIDTH*0.4);
        make.height.mas_offset(50);
        make.top.mas_offset(0);
    }];
    UIImageView *nextImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"next"]];
    [self addSubview:nextImage];
    [nextImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-10);
        make.width.mas_offset(13);
        make.height.mas_offset(13);
        make.centerY.mas_offset(0);
    }];
    _kindNumberLabel = [[UILabel alloc] init];
    _kindNumberLabel.textColor = [UIColor colorWithHexString:@"444444"];
    _kindNumberLabel.font = [UIFont systemFontOfSize:13];
    _kindNumberLabel.textAlignment = 2;
    [self addSubview:_kindNumberLabel];
    [_kindNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(nextImage.mas_left).offset(-10);
        make.width.mas_offset(100);
        make.height.mas_offset(50);
        make.top.mas_offset(0);
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
