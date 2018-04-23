//
//  OrderCouponCell.m
//  ZhongJianMalliOS
//
//  Created by 段 on 2017/12/1.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "OrderCouponCell.h"

@implementation OrderCouponCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initWithCellView];
    }
    return self;
}
- (void)initWithCellView {
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.textColor = [UIColor colorWithHexString:@"444444"];
    _titleLabel.font = [UIFont systemFontOfSize:13];
    [self addSubview:_titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(10);
        make.height.mas_offset(50);
        make.top.mas_offset(0);
    }];
//    if (_isSelected == YES) {
 
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = [UIColor colorWithHexString:@"d4d4d4"];
    [self addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(0);
        make.height.mas_offset(0.5);
        make.bottom.mas_offset(-0.5);
        make.right.mas_offset(0);
    }];
    
}
-(void)switchAction:(UISwitch *)sender
{
//    UISwitch *switchButton = (UISwitch*)sender;
    BOOL isButtonOn = [sender isOn];
    if (isButtonOn) {
        NSLog(@"开");
    }else {
        NSLog(@"关");
    }
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
