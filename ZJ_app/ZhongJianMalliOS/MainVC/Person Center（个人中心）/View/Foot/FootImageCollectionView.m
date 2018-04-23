//
//  FootImageCollectionView.m
//  ZhongJianMalliOS
//
//  Created by 段 on 2017/11/6.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "FootImageCollectionView.h"

@implementation FootImageCollectionView


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self creatUI];
    }
    return self;
}
- (void)creatUI {
    
    UIView *footView = [[UIView alloc] init];
    footView.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];
    
    [self addSubview:footView];
    [footView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(0);
        make.top.mas_offset(0);
        make.bottom.mas_offset(0);
        make.right.mas_offset(0);
    }];
}
@end
