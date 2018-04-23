//
//  HeadImageCollection.m
//  ZhongJianMalliOS
//
//  Created by 段 on 2017/11/3.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "HeadImageCollection.h"

@implementation HeadImageCollection

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self creatUI];
    }
    return self;
}
- (void)creatUI {
    UIImageView *bgImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"background"]];
    bgImage.userInteractionEnabled = YES;
    bgImage.frame = CGRectMake(0, 0, KWIDTH, 235);
    [self addSubview:bgImage];
    [bgImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(0);
        make.top.mas_offset(0);
        make.bottom.mas_offset(0);
        make.right.mas_offset(0);
    }];
    UIButton *newsButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [newsButton addTarget:self action:@selector(newsButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [newsButton setBackgroundImage:[UIImage imageNamed:@"setting"] forState:UIControlStateNormal];
    [bgImage addSubview:newsButton];
    [newsButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-15);
        make.top.mas_offset(30);
        make.height.mas_offset(22);
        make.width.mas_offset(22);
    }];
    
    UIImageView *quanImageView = [[UIImageView alloc] init];
    quanImageView.clipsToBounds = YES;
    quanImageView.userInteractionEnabled = YES;
    quanImageView.layer.cornerRadius = 81/2;
    quanImageView.layer.borderWidth = 2;
    quanImageView.layer.borderColor = [UIColor whiteColor].CGColor;
    
    [bgImage addSubview:quanImageView];
    [quanImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(25);
        make.width.mas_offset(81);
        make.height.mas_offset(81);
        make.top.mas_offset(60);
    }];
    /*-------------------------------头像---------------------------------*/
    _headImage = [[UIImageView alloc] init];
    _headImage.userInteractionEnabled = YES;
    [quanImageView addSubview:_headImage];
    [_headImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(2);
        make.width.mas_offset(80);
        make.height.mas_offset(80);
        make.top.equalTo(quanImageView.mas_top).offset(2);
    }];
    _membrelevelLabel = [[UILabel alloc] init];
    _membrelevelLabel.font = [UIFont systemFontOfSize:11];
    _membrelevelLabel.text = @"免费会员";
    _membrelevelLabel.backgroundColor = [UIColor orangeColor];
    _membrelevelLabel.textAlignment = 1;
    _membrelevelLabel.textColor = [UIColor colorWithHexString:@"ffffff"];
    [bgImage addSubview:_membrelevelLabel];
    [_membrelevelLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_headImage.mas_centerX).offset(0);
        make.bottom.equalTo(_headImage.mas_bottom).offset(10);
        make.height.mas_offset(20);
        make.width.mas_offset(60);
    }];
    UIButton *headImageButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    headImageButton.frame = _headImage.frame;
    headImageButton.backgroundColor = [UIColor clearColor];
    [headImageButton addTarget:self action:@selector(headImageButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [_headImage addSubview:headImageButton];
    [headImageButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(0);
        make.right.mas_offset(0);
        make.top.mas_offset(0);
        make.bottom.mas_offset(0);
    }];
    
    _nameLabel = [[UILabel alloc] init];
    _nameLabel.font = [UIFont fontWithName:@"Arial Rounded MT Bold" size:19.0];
    _nameLabel.textColor = [UIColor colorWithHexString:@"ffffff"];
    _nameLabel.text = @"灰灰灰";
    
    [bgImage addSubview:_nameLabel];
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(quanImageView.mas_right).offset(17);
        make.height.mas_offset(24);
        make.top.equalTo(quanImageView.mas_top).offset(15);
    }];
    
//    UIImageView *iconImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"free membership"]];
//    [bgImage addSubview:iconImage];
//    [iconImage mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(_nameLabel.mas_right).offset(12);
//        make.height.mas_offset(28);
//        make.width.mas_offset(32);
//        make.centerY.equalTo(_nameLabel.mas_centerY).offset(-3);
//    }];
    _nameIDLabel = [[UILabel alloc] init];
    _nameIDLabel.text = @"ID: 123456";
    _nameIDLabel.textColor = [UIColor colorWithHexString:@"ffffff"];
    _nameIDLabel.font = [UIFont systemFontOfSize:14];
    [bgImage addSubview:_nameIDLabel];
    [_nameIDLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(quanImageView.mas_right).offset(17);
        make.top.equalTo(_nameLabel.mas_bottom).offset(15);
        make.height.mas_offset(18);
        make.width.mas_offset(150);
    }];
    
 
}
- (void)newsButtonClick:(UIButton *)sender {
    sender.selected = !sender.selected;

    !_newsButtonClickBlock ? : _newsButtonClickBlock();
    
}
- (void)headImageButtonClick:(UIButton *)sender {
    sender.selected = !sender.selected;
    !_headButtonClickBlock ? : _headButtonClickBlock();
}

@end
