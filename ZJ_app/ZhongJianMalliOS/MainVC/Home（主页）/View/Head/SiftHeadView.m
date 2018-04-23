//
//  SiftHeadView.m
//  ZhongJianMalliOS
//
//  Created by 段 on 2017/11/20.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "SiftHeadView.h"

@implementation SiftHeadView


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self creatUI];
    }
    return self;
}
- (void)creatUI {
    
    UILabel *headTitleLabel = [UILabel new];
    headTitleLabel.text = @"城市";
    headTitleLabel.textColor = [UIColor colorWithHexString:@"444444"];
    headTitleLabel.font = [UIFont systemFontOfSize:15];
    [self addSubview:headTitleLabel];
    [headTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(10);
        make.height.mas_offset(40);
        make.top.mas_offset(0);
    }];
    
}
@end
