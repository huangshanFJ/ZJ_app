//
//  OrderStateTableViewCell.m
//  ZhongJianMalliOS
//
//  Created by 段 on 2017/12/19.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "OrderStateTableViewCell.h"

@implementation OrderStateTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initStateView];
    }
    return self;
}
- (void)initStateView {
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = zjTextColor;
    [self addSubview:lineView];
    
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(10);
        make.centerY.mas_offset(0);
        make.width.mas_offset(3);
        make.height.mas_offset(17);
    }];
    _stateLabel = [[UILabel alloc] init];
    _stateLabel.text = @"订单已取消";
    _stateLabel.font = [UIFont systemFontOfSize:14];
    _stateLabel.textColor = lightBlackTextColor;
    [self addSubview:_stateLabel];
    [_stateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(lineView.mas_right).offset(8);
        make.top.mas_offset(0);
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
