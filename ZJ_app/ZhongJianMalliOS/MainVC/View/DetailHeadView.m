//
//  DetailHeadView.m
//  ZhongJianMalliOS
//
//  Created by 段 on 2017/11/21.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "DetailHeadView.h"

@implementation DetailHeadView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self creatHeadView];
    }
    return self;
}
- (void)creatHeadView {
    
    _shopClassLabel = [[UILabel alloc] init];
    _shopClassLabel.text = @"商品评价";
    _shopClassLabel.font = [UIFont systemFontOfSize:13];
    _shopClassLabel.textColor = [UIColor colorWithHexString:@"444444"];
    [self addSubview:_shopClassLabel];
    [_shopClassLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(10);
        make.top.mas_offset(10);
        make.height.mas_offset(20);
    }];
    
    _numberLabel = [[UILabel alloc] init];
    _numberLabel.textColor = [UIColor colorWithHexString:@"999999"];
    _numberLabel.font = [UIFont systemFontOfSize:11];
    [self addSubview:_numberLabel];
    [_numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_shopClassLabel.mas_right).offset(8);
        make.bottom.equalTo(_shopClassLabel.mas_bottom).offset(0);
        make.height.mas_offset(18);
    }];
    
    UIImageView *nextImage = [[UIImageView alloc] init];
    nextImage.image = [UIImage imageNamed:@"next"];
    [self addSubview:nextImage];
    [nextImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-11);
        make.width.mas_offset(13);
        make.height.mas_offset(13);
        make.centerY.equalTo(_shopClassLabel.mas_centerY).offset(0);
    }];
    
    
    _praiseLabel = [[UILabel alloc] init];
    _praiseLabel.textColor = [UIColor colorWithHexString:@"ff3a00"];
    _praiseLabel.font = [UIFont systemFontOfSize:11];
    _praiseLabel.textAlignment = 2;
    [self addSubview:_praiseLabel];
    [_praiseLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(nextImage.mas_left).offset(-8);
        make.bottom.equalTo(_shopClassLabel.mas_bottom).offset(0);
        make.height.mas_offset(18);
    }];
    
    UIButton *selectedBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    selectedBtn.backgroundColor = [UIColor clearColor];
    selectedBtn.frame = self.frame;
    [selectedBtn addTarget:self action:@selector(nextButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:selectedBtn];
    
}
- (void)nextButtonClick:(UIButton *)sender {
    sender.selected = !sender.selected;
    
     !_selectedButtonClickNextBlock ? :_selectedButtonClickNextBlock();
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
