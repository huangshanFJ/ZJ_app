//
//  FooterColletionNews.m
//  ZhongJianMalliOS
//
//  Created by 段 on 2017/11/1.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "FooterColletionNews.h"



@implementation FooterColletionNews


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        [self creatFootUI];
    }
    return self;
}
- (void)creatFootUI {
    UILabel *line = [[UILabel alloc] init];
    line.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];
    [self addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(0);
        make.right.mas_offset(0);
        make.top.mas_offset(0);
        make.height.mas_offset(0.5);
    }];
    
    _newsImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg"]];
    _newsImage.frame = CGRectMake(10,15, 74, 25);
    [self addSubview:_newsImage];
    [_newsImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(10);
        make.width.mas_offset(74);
        make.height.mas_offset(28);
        make.top.equalTo(line.mas_bottom).offset(6);
    }];
    
    UILabel *hotLabel = [[UILabel alloc] init];
    hotLabel.frame = CGRectMake(90, 20, 17, 10);
    hotLabel.text = @"HOT";
    hotLabel.textAlignment = 1;
    hotLabel.layer.cornerRadius = 3;
    hotLabel.layer.masksToBounds = YES;
    hotLabel.font = [UIFont systemFontOfSize:8];
    hotLabel.layer.borderColor = [UIColor redColor].CGColor;
    hotLabel.layer.borderWidth = 0.5f;
    hotLabel.textColor = [UIColor redColor];
    [self addSubview:hotLabel];
    
    [hotLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_newsImage.mas_right).offset(10);
        make.width.mas_offset(25);
        make.centerY.equalTo(_newsImage.mas_centerY).offset(2);
        make.height.mas_offset(12);
    }];
    UIView *footColorView = [[UIView alloc] init];
    footColorView.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];
    [self addSubview:footColorView];
    [footColorView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(0);
        make.height.mas_offset(7);
        make.right.mas_offset(0);
        make.top.equalTo(line.mas_bottom).offset(40);
    }];
    
//    UILabel *showLabel = [[UILabel alloc] init];
//    showLabel.text = @"这只是个label";
//    showLabel.frame = CGRectMake(100, 5, 200, 50);
//    showLabel.font = [UIFont systemFontOfSize:12];
//    showLabel.textColor = [UIColor colorWithHexString:@"#444444"];
//    [self addSubview:showLabel];
}
@end
