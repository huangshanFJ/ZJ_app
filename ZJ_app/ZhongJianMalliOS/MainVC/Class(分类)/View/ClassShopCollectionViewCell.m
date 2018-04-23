//
//  ClassShopCollectionViewCell.m
//  ZhongJianMalliOS
//
//  Created by 段 on 2017/11/15.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "ClassShopCollectionViewCell.h"

@implementation ClassShopCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initCellView];
    }
    return self;
}
- (void)initCellView {
    
    _headImageView = [[UIImageView alloc] init];
    
    [self addSubview:_headImageView];
    [_headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        [make.top.mas_equalTo(self)setOffset:5];
        make.size.mas_equalTo(CGSizeMake( self.frame.size.width * 0.85, self.frame.size.width * 0.85));
    }];
    _shopNameLabel = [[UILabel alloc] init];
    _shopNameLabel.font = [UIFont systemFontOfSize:12];
    _shopNameLabel.textAlignment = 1;
    _shopNameLabel.textColor = [UIColor colorWithHexString:@"999999"];
    [self addSubview:_shopNameLabel];
    [_shopNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.width.mas_offset(self.frame.size.width);
        make.top.equalTo(_headImageView.mas_bottom).offset(5);
        make.height.mas_offset(20);
    }];
    
    
}

@end
