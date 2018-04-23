//
//  TitleHeadView.m
//  ZhongJianMalliOS
//
//  Created by 段 on 2017/11/2.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "TitleHeadView.h"

@implementation TitleHeadView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initUI];
    }
    return self;
}

- (void)initUI {
    self.backgroundColor = [UIColor whiteColor];
    UIImageView *rectangleImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"squareness"]];
//    rectangleImage
    [self addSubview:rectangleImage];
    
    
    _titleShowLabel = [[UILabel alloc] init];
    _titleShowLabel.textColor = [UIColor blackColor];
    _titleShowLabel.font = [UIFont systemFontOfSize:18];
    _titleShowLabel.textAlignment = 1;
    _titleShowLabel.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    [self addSubview:_titleShowLabel];
    
    [_titleShowLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_offset(0);
        make.width.mas_offset(90);
        make.height.mas_offset(45);
        make.top.mas_offset(0);
    }];
    [rectangleImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_titleShowLabel.mas_left).offset(-5);
        make.width.mas_offset(14);
        make.height.mas_offset(14);
        make.centerY.mas_offset(0);
    }];
    
    UIImageView *rectangleImage1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"squareness"]];
    //    rectangleImage
    [self addSubview:rectangleImage1];
    
    [rectangleImage1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_titleShowLabel.mas_right).offset(5);
        make.width.mas_offset(14);
        make.height.mas_offset(14);
        make.centerY.mas_offset(0);
    }];
    UIButton *selectedButton = [UIButton buttonWithType:UIButtonTypeCustom];
    selectedButton.backgroundColor = [UIColor clearColor];
    [selectedButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:selectedButton];
    [selectedButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(0);
        make.right.mas_offset(0);
        make.top.mas_offset(0);
        make.bottom.mas_offset(0);
    }];
    
}
- (void)buttonClick:(UIButton *)sender {
    sender.selected = !sender.selected;
    !_headButtonClickBlock ? :_headButtonClickBlock();
}

@end
