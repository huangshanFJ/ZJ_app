//
//  FansNumberCell.m
//  ZhongJianMalliOS
//
//  Created by 段 on 2018/2/2.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "FansNumberCell.h"

@implementation FansNumberCell

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
        make.left.mas_offset(15);
        make.height.mas_offset(45);
        make.centerY.mas_offset(0);
        
    }];
    
    UIImageView *image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"next"]];
    [self addSubview:image];
    [image mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-11);
        make.width.mas_offset(13);
        make.height.mas_offset(13);
        make.centerY.equalTo(_kindNameLabel.mas_centerY).offset(0);
    }];
    
    _numberLabel = [[UILabel alloc] init];
    _numberLabel.font = [UIFont systemFontOfSize:13];
    _numberLabel.textAlignment = 2;
    _numberLabel.textColor = lightBlackTextColor;
    [self addSubview:_numberLabel];
    [_numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(image.mas_left).offset(-10);
        make.height.mas_offset(45);
        make.centerY.mas_offset(0);
        
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
