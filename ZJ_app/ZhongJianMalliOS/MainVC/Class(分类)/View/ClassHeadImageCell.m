//
//  ClassHeadImageCell.m
//  ZhongJianMalliOS
//
//  Created by 段 on 2017/11/15.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "ClassHeadImageCell.h"

@implementation ClassHeadImageCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self creatView];
    }
    return self;
}
- (void)creatView {
    
    _headImage = [[UIImageView alloc] init];
    [self addSubview:_headImage];
    [_headImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(10);
        make.right.mas_offset(-10);
        make.top.mas_offset(0);
        make.height.mas_offset(85);
    }];
    
    
}


@end
