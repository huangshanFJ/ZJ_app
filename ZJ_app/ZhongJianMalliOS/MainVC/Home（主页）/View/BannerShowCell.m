//
//  BannerShowCell.m
//  ZhongJianMalliOS
//
//  Created by 段 on 2017/11/3.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "BannerShowCell.h"

@implementation BannerShowCell 

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initUI];
    }
    return self;
}
- (void)initUI {
    
    _bannerView = [[UIImageView alloc] init];
    [self addSubview:_bannerView];
    [_bannerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(0);
        make.height.mas_offset(151);
        make.right.mas_offset(0);
        make.top.mas_offset(0);
    }];
}
@end
