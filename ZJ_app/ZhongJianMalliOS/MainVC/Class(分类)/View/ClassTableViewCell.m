//
//  ClassTableViewCell.m
//  ZhongJianMalliOS
//
//  Created by 段 on 2017/11/15.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "ClassTableViewCell.h"

@implementation ClassTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initWithCellView];
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];

    }
    return self;
}
- (void)initWithCellView {
    
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.font = [UIFont systemFontOfSize:13];
    _titleLabel.layer.masksToBounds = YES;
    _titleLabel.textAlignment = 1;
    _titleLabel.layer.cornerRadius = 12;
    _titleLabel.backgroundColor = [UIColor colorWithHexString:@"6493ff"]; 
    _titleLabel.textColor = [UIColor whiteColor];
    [self addSubview:_titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(7);
        make.right.mas_offset(-7);
        make.height.mas_offset(25);
        make.top.mas_offset(20);
    }];
    

    
}
- (void)awakeFromNib {
    
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
 
    if (selected) {
        
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.backgroundColor = [UIColor colorWithHexString:@"6493ff"];
    }else{
        _titleLabel.textColor = [UIColor colorWithHexString:@"444444"];
        _titleLabel.backgroundColor = [UIColor whiteColor];
    }
    // Configure the view for the selected state
}

@end
