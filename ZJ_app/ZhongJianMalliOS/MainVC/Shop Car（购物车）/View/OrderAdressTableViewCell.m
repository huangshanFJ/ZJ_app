//
//  OrderAdressTableViewCell.m
//  ZhongJianMalliOS
//
//  Created by 段 on 2017/11/29.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "OrderAdressTableViewCell.h"

@implementation OrderAdressTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initCellView];
    }
    
    return self;
}
- (void)initCellView {
//    _headImage = [[UIImageView alloc] init];
//    _headImage.layer.borderWidth = 0.5;
//    _headImage.layer.borderColor = [UIColor colorWithHexString:@"d4d4d4"].CGColor;
//    [self addSubview:_headImage];
//    [_headImage mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_offset(11);
//        make.width.mas_offset(70);
//        make.height.mas_offset(70);
//        make.top.mas_offset(10);
//    }];
    _adressLabel = [[UILabel alloc] init];
    _adressLabel.textColor = [UIColor colorWithHexString:@"444444"];
    _adressLabel.font = [UIFont systemFontOfSize:14];
    [self addSubview:_adressLabel];
    [_adressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(10);
        make.width.mas_offset(KWIDTH*0.5);
        make.height.mas_offset(44);
        make.top.mas_offset(3);
    }];
    
    UIImageView *nextImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"next"]];
    [self addSubview:nextImage];
    [nextImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-10);
        make.centerY.equalTo(_adressLabel.mas_centerY).offset(0);
        make.width.mas_offset(13);
        make.height.mas_offset(13);
    }];
    
    UIImageView *bottomView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"adressbg"]];
    [self addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(0);
        make.right.mas_offset(0);
        make.height.mas_offset(3);
        make.bottom.mas_offset(0);
    }];
    
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
