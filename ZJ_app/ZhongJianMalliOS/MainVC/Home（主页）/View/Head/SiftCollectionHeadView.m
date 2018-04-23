//
//  SiftCollectionHeadView.m
//  ZhongJianMalliOS
//
//  Created by 段 on 2017/11/20.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "SiftCollectionHeadView.h"

@implementation SiftCollectionHeadView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self creatUI];
    }
    return self;
}
- (void)creatUI {
    
    UIView *bgView = [[UIView alloc] init];
    bgView.backgroundColor = [UIColor whiteColor];
    [self addSubview:bgView];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(0);
        make.right.mas_offset(0);
        make.top.mas_offset(0);
        make.bottom.mas_offset(0);
    }];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text = @"价格区间（元）";
    titleLabel.font = [UIFont systemFontOfSize:15];
    titleLabel.textColor = [UIColor colorWithHexString:@"444444"];
    [self addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(10);
        make.height.mas_offset(25);
        make.top.mas_offset(20);
    }];
    _maxPriceTF = [[UITextField alloc] init];
    _maxPriceTF.textColor = [UIColor colorWithHexString:@"999999"];
    _maxPriceTF.placeholder = @"最高价";
    _maxPriceTF.textAlignment = 1;
    _maxPriceTF.font = [UIFont systemFontOfSize:12];
    _maxPriceTF.layer.masksToBounds = YES;
    _maxPriceTF.layer.borderWidth = 0.5;
    _maxPriceTF.layer.borderColor = [UIColor colorWithHexString:@"6395ff"].CGColor;
    _maxPriceTF.layer.cornerRadius = 5;
    //    _maxPriceTF.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];
    [self addSubview:_maxPriceTF];
    [_maxPriceTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(10);
        make.top.equalTo(titleLabel.mas_bottom).offset(15);
        make.height.mas_offset(27);
        make.width.mas_offset(123);
    }];
    
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];
    [self addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_maxPriceTF.mas_right).offset(6);
        make.width.mas_offset(7);
        make.centerY.equalTo(_maxPriceTF.mas_centerY).offset(0);
        make.height.mas_offset(1);
    }];
    
    _minPriceTF = [[UITextField alloc] init];
    _minPriceTF.textColor = [UIColor colorWithHexString:@"999999"];
    _minPriceTF.placeholder = @"最低价";
    _minPriceTF.textAlignment = 1;
    _minPriceTF.font = [UIFont systemFontOfSize:12];
    _minPriceTF.layer.masksToBounds = YES;
    _minPriceTF.layer.cornerRadius = 5;
    _minPriceTF.layer.borderWidth = 0.5;
    _minPriceTF.layer.borderColor = [UIColor colorWithHexString:@"6395ff"].CGColor;
    //    _minPriceTF.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];
    [self addSubview:_minPriceTF];
    [_minPriceTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(line.mas_right).offset(6);
        make.width.mas_offset(123);
        make.height.mas_offset(27);
        make.top.equalTo(titleLabel.mas_bottom).offset(15);
    }];
    
    UILabel *line1 = [[UILabel alloc] init];
    line1.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];
    [self addSubview:line1];
    [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(0);
        make.top.equalTo(_maxPriceTF.mas_bottom).offset(20);
        make.height.mas_offset(0.5);
        make.right.mas_offset(0);
    }];
    
    UILabel *placeLabel = [UILabel new];
    placeLabel.text = @"发货地";
    placeLabel.font = [UIFont systemFontOfSize:15];
    
    [self addSubview:placeLabel];
    [placeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(10);
        make.top.equalTo(line1.mas_bottom).offset(20);
        make.height.mas_offset(25);
    }];
    
    UILabel *localLabel = [[UILabel alloc] init];
    localLabel.text = @"杭州";
    localLabel.font = [UIFont systemFontOfSize:12];
    localLabel.textAlignment = 1;
    localLabel.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];
    [self addSubview:localLabel];
    [localLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(10);
        make.width.mas_offset(60);
        make.height.mas_offset(27);
        make.top.equalTo(placeLabel.mas_bottom).offset(15);
    }];
    
    UILabel *line2 = [UILabel new];
    line2.backgroundColor = [UIColor colorWithHexString:@"999999"];
    [self addSubview:line2];
    [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(localLabel.mas_right).offset(10);
        make.centerY.equalTo(localLabel.mas_centerY).offset(0);
        make.height.mas_offset(18);
        make.width.mas_offset(0.5);
    }];
    
    _placeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_placeButton setImage:[UIImage imageNamed:@"location_gray"] forState:UIControlStateNormal];
    [_placeButton setTitle:@"呼和浩特" forState:UIControlStateNormal];
    _placeButton.titleLabel.font = [UIFont systemFontOfSize:12];
    _placeButton.titleLabel.textColor = [UIColor colorWithHexString:@"444444"];
    _placeButton.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];
    [self addSubview:_placeButton];
    [_placeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(line2.mas_right).offset(10);
        make.width.mas_offset(80);
        make.height.mas_offset(27);
        make.top.equalTo(placeLabel.mas_bottom).offset(15);
    }];
    
    UIButton *locationButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [locationButton setTitle:@"定位" forState:UIControlStateNormal];
    [locationButton setTitleColor:[UIColor colorWithHexString:@"6493ff"] forState:UIControlStateNormal];
    locationButton.titleLabel.font = [UIFont systemFontOfSize:12];
    
    [self addSubview:locationButton];
    [locationButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_placeButton.mas_right).offset(10);
        make.centerY.equalTo(localLabel.mas_centerY).offset(0);
        make.height.mas_offset(20);
        make.width.mas_offset(50);
    }];
    
    UILabel *areaLabel = [[UILabel alloc] init];
    areaLabel.text = @"区域";
    areaLabel.font = [UIFont systemFontOfSize:15];
    areaLabel.textColor = [UIColor colorWithHexString:@"444444"];
    
    [self addSubview:areaLabel];
    [areaLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(10);
        make.top.equalTo(localLabel.mas_bottom).offset(20);
        make.height.mas_offset(25);
    }];
}
@end
