//
//  OrderDetailCell.m
//  ZhongJianMalliOS
//
//  Created by 段 on 2017/12/19.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "OrderDetailCell.h"

@implementation OrderDetailCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initCellView];
    }
    return self;
}
- (void)initCellView {
    self.kindLabel = [[UILabel alloc] init];
    self.kindLabel.textColor = lightgrayTextColor;
    self.kindLabel.font = [UIFont systemFontOfSize:13];
    [self addSubview:self.kindLabel];
    [self.kindLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(10);
        make.height.mas_offset(45);
        make.top.mas_offset(0);
    }];
    self.stateLabel = [[UILabel alloc] init];
    self.stateLabel.textAlignment = 2;
    self.stateLabel.font = [UIFont systemFontOfSize:13];
    [self addSubview:self.stateLabel];
    [self.stateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-10);
        make.height.mas_offset(45);
        make.top.mas_offset(0);
     }];
    UILabel *line = [UILabel new];
    line.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];
    [self addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(10);
        make.right.mas_offset(0);
        make.bottom.mas_offset(0);
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
