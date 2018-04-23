//
//  NewRegistHeadView.m
//  ZhongJianMalliOS
//
//  Created by 段 on 2017/11/13.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "NewRegistHeadView.h"

@implementation NewRegistHeadView

- (instancetype)initWithFrame:(CGRect)frame {
  
    self = [super initWithFrame:frame];
    if (self) {
        [self creatHeadView];
    }
    return self;
}
- (void)creatHeadView {
    UIView *headView = [UIView new];
    headView.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];
    [self addSubview:headView];
    [headView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(0);
        make.bottom.mas_offset(0);
        make.right.mas_offset(0);
        make.top.mas_offset(0);
    }];
    
    UIView *bgView = [[UIView alloc] init];
    bgView.backgroundColor = [UIColor whiteColor];
    [headView addSubview:bgView];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(0);
        make.top.mas_offset(7);
        make.height.mas_offset(150);
        make.right.mas_offset(0);
    }];
    
    UILabel *newPeopleLabel = [[UILabel alloc] init];
    newPeopleLabel.text = @"新人专享红包";
    newPeopleLabel.textColor = [UIColor colorWithHexString:@"fa8d00"];
    newPeopleLabel.font = [UIFont fontWithName:@"Arial Rounded MT Bold" size:21];
    [bgView addSubview:newPeopleLabel];
    [newPeopleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(32);
        make.top.mas_offset(46);
        make.height.mas_offset(28);
    }];
    
    UIButton *getButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [getButton setTitle:@"立即领取" forState:UIControlStateNormal];
    getButton.backgroundColor = [UIColor colorWithHexString:@"fa8f00"];
    getButton.layer.cornerRadius = 23/2;
    getButton.layer.masksToBounds = YES;
    getButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [bgView addSubview:getButton];
    [getButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(32);
        make.top.equalTo(newPeopleLabel.mas_bottom).offset(12);
        make.height.mas_offset(23);
        make.width.mas_offset(85);
    }];
    
    UIImageView *bgImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg-1"]];
    [bgView addSubview:bgImage];
    [bgImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-12);
        make.height.mas_offset(123);
        make.width.mas_offset(190);
        make.top.mas_offset(12);
    }];
    
    UILabel *mycoupon = [[UILabel alloc] init];
    mycoupon.text = @"我的优惠券";
    mycoupon.font = [UIFont systemFontOfSize:14];
    mycoupon.textAlignment = 1;
    mycoupon.textColor = [UIColor colorWithHexString:@"444444"];
    [headView addSubview:mycoupon];
    [mycoupon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_offset(0);
        make.width.mas_offset(80);
        make.height.mas_offset(25);
        make.top.equalTo(bgView.mas_bottom).offset(20);
    }];
 
    UILabel *line = [UILabel new];
    line.backgroundColor = [UIColor colorWithHexString:@"d2d2d2"];
    [headView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(mycoupon.mas_left).offset(-7);
        make.width.mas_offset(77);
        make.height.mas_offset(0.5);
        make.centerY.equalTo(mycoupon.mas_centerY).offset(0);
    }];
    
    UILabel *line1 = [[UILabel alloc] init];
    line1.backgroundColor = [UIColor colorWithHexString:@"d2d2d2"];
    [headView addSubview:line1];
    [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(mycoupon.mas_right).offset(7);
        make.width.mas_offset(77);
        make.height.mas_offset(0.5);
        make.centerY.equalTo(mycoupon.mas_centerY).offset(0);
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
