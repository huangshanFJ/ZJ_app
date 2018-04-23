//
//  SiftCollectionView.m
//  ZhongJianMalliOS
//
//  Created by 段 on 2017/11/20.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "SiftCollectionView.h"

@implementation SiftCollectionView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        [self creatSiftView];
    }
    return self;
}
- (void)creatSiftView {
    
    UIView *cellView = [[UIView alloc] init];
    [self addSubview:cellView];
    [cellView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(0);
//        make.width.mas_offset(KWIDTH*0.76/3);
        make.right.mas_offset(0);
        make.height.mas_offset(40);
        make.top.mas_offset(0);
    }];
    
    _placeLabel = [[UILabel alloc] init];
    _placeLabel.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];
    _placeLabel.textColor = [UIColor colorWithHexString:@"444444"];
    _placeLabel.font = [UIFont systemFontOfSize:12];
    _placeLabel.layer.cornerRadius = 5;
    _placeLabel.textAlignment = 1;
    _placeLabel.layer.masksToBounds = YES;
    [cellView addSubview:_placeLabel];
    [_placeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(cellView.mas_left).offset(10);
        make.height.mas_offset(27);
        make.top.equalTo(cellView.mas_top).offset(5);
        make.right.equalTo(cellView.mas_right).offset(-5);
    }];
    
    
    
    
    
}

@end
