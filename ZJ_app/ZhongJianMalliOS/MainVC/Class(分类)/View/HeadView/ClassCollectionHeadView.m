//
//  ClassCollectionHeadView.m
//  ZhongJianMalliOS
//
//  Created by 段 on 2017/11/15.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "ClassCollectionHeadView.h"

@implementation ClassCollectionHeadView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initHeadView];
    }
    return self;
}
- (void)initHeadView {
    
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.textColor = [UIColor colorWithHexString:@"444444"];
    _titleLabel.font = [UIFont systemFontOfSize:13];
    [self addSubview:_titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(10);
        make.height.mas_offset(20);
        make.top.mas_offset(5);
    }];
    
    _rightLabel = [[UILabel alloc] init];
    _rightLabel.textColor = [UIColor colorWithHexString:@"999999"];
    _rightLabel.textAlignment = 2;
    _rightLabel.text = @"更多...";
    _rightLabel.font = [UIFont systemFontOfSize:11];
    [self addSubview:_rightLabel];
    [_rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-20);
        make.top.mas_offset(5);
        make.height.mas_offset(20);
    }];
   
}

@end
