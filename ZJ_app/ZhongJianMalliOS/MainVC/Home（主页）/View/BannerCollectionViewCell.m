//
//  BannerCollectionViewCell.m
//  ZhongJianMalliOS
//
//  Created by 段 on 2017/11/1.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "BannerCollectionViewCell.h"

@implementation BannerCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpUI];

    }
    return self;
}

- (void)setUpUI {
//    self.backgroundColor = [UIColor whiteColor];
 
    UIView *cellView = [[UIView alloc] init];
    cellView.backgroundColor = [UIColor whiteColor];
    
    [self addSubview:cellView];
    [cellView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(0);
        make.right.mas_offset(0);
        make.top.mas_offset(0);
        make.bottom.mas_offset(0);
    }];
    
    _newsHeadImage = [[UIImageView alloc] init];
    
    [cellView addSubview:_newsHeadImage];
    [_newsHeadImage mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_offset(22);
        make.centerX.mas_offset(0);
        make.width.mas_offset(44);
        make.height.mas_offset(44);
        make.top.mas_offset(16);
    }];
    
    _newsNameLabel = [[UILabel alloc] init];
    _newsNameLabel.textColor = [UIColor colorWithHexString:@"#444444"];
    _newsNameLabel.font = [UIFont systemFontOfSize:12];
    _newsNameLabel.textAlignment = 1;
    [cellView addSubview:_newsNameLabel];
    [_newsNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_newsHeadImage.mas_centerX).offset(0);
        make.height.mas_offset(18);
        make.top.equalTo(_newsHeadImage.mas_bottom).offset(7);
//        make.width.mas_offset(KWIDTH/3);
    }];

}
@end
