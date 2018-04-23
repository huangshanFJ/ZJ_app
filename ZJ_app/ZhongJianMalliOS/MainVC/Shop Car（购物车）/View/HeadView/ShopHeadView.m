//
//  ShopHeadView.m
//  ZhongJianMalliOS
//
//  Created by 段 on 2018/1/19.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "ShopHeadView.h"

@implementation ShopHeadView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initHeadView];
    }
    return self;
}
- (void)initHeadView {
    _shopDetailNameLabel = [[UILabel alloc] init];
    _shopDetailNameLabel.textColor = lightBlackTextColor;
    _shopDetailNameLabel.font = [UIFont systemFontOfSize:15];
    [self addSubview:_shopDetailNameLabel];
    [_shopDetailNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(10);
        make.height.mas_offset(30);
        make.centerY.mas_offset(0);
    }];
    
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
