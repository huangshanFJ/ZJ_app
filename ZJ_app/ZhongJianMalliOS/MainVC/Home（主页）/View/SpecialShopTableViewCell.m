//
//  SpecialShopTableViewCell.m
//  ZhongJianMalliOS
//
//  Created by 段 on 2017/11/9.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "SpecialShopTableViewCell.h"

@implementation SpecialShopTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initUI];
    }
    return self;
}
- (void)initUI {
    _shopImage = [[UIImageView alloc] init];
    [self addSubview:_shopImage];
    [_shopImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(0);
        make.width.mas_offset(125);
        make.height.mas_offset(125);
        make.top.mas_offset(8);
    }];
    _shopName = [UILabel new];
    _shopName.font = [UIFont systemFontOfSize:15];
    _shopName.numberOfLines = 0;
    _shopName.textColor = [UIColor colorWithHexString:@"444444"];
    [self addSubview:_shopName];
    [_shopName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_shopImage.mas_right).offset(19);
        make.right.mas_offset(-11);
        make.top.equalTo(_shopImage.mas_top).offset(14);
        make.height.mas_offset(30);
    }];
    UILabel *shipLabel = [[UILabel alloc] init];
    shipLabel.text = @"包邮";
    shipLabel.textColor = [UIColor colorWithHexString:@"999999"];
    shipLabel.font = [UIFont systemFontOfSize:11];
    shipLabel.layer.borderWidth = 0.5;
    shipLabel.layer.borderColor = [UIColor colorWithHexString:@"999999"].CGColor;
    shipLabel.layer.cornerRadius = 7;
    shipLabel.layer.masksToBounds = YES;
    shipLabel.textAlignment = 1;
    [self addSubview:shipLabel];
    [shipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_shopImage.mas_right).offset(19);
        make.height.mas_offset(15);
        make.width.mas_offset(30);
        make.top.mas_offset(72);
    }];
    
    UILabel *freeShopLabel = [[UILabel alloc] init];
    freeShopLabel.textAlignment = 1;
    freeShopLabel.text = @"买1送1";
    freeShopLabel.font = [UIFont systemFontOfSize:11];
    freeShopLabel.layer.borderWidth = 0.5;
    freeShopLabel.layer.borderColor = [UIColor colorWithHexString:@"999999"].CGColor;
    freeShopLabel.layer.cornerRadius = 7;
    freeShopLabel.layer.masksToBounds = YES;
    freeShopLabel.textColor = [UIColor colorWithHexString:@"999999"];
    [self addSubview:freeShopLabel];
    [freeShopLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(shipLabel.mas_right).offset(7);
        make.width.mas_offset(38);
        make.height.mas_offset(15);
        make.top.mas_offset(72);
    }];
    
    _priceLabel = [[UILabel alloc] init];
    [self addSubview:_priceLabel];
    [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_shopImage.mas_right).offset(19);
        make.height.mas_offset(20);
        make.top.equalTo(freeShopLabel.mas_bottom).offset(10);
      
    }];
    
    _peopleLabel = [[UILabel alloc] init];
    _peopleLabel.textColor = [UIColor colorWithHexString:@"999999"];
    _peopleLabel.font = [UIFont systemFontOfSize:11];
    [self addSubview:_peopleLabel];
    [_peopleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_priceLabel.mas_right).offset(10);
        make.centerY.equalTo(_priceLabel.mas_centerY).offset(0);
        make.height.mas_offset(20);
    }];
    
    _miniteLabel = [[UILabel alloc] init];
    _miniteLabel.textColor = [UIColor colorWithHexString:@"ffb11b"];
    [self addSubview:_miniteLabel];
    [_miniteLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-11);
        make.height.mas_offset(20);
        make.centerY.equalTo(_priceLabel.mas_centerY).offset(0);
    }];
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = [UIColor colorWithHexString:@"dcdcdc"];
    [self addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(0);
        make.right.mas_offset(0);
        make.top.equalTo(_shopImage.mas_bottom).offset(7);
        make.height.mas_offset(0.5);
    }];
    
    UIButton *intoShopButton = [UIButton buttonWithType:UIButtonTypeCustom];
    intoShopButton.layer.borderColor = [UIColor colorWithHexString:@"ffb11b"].CGColor;
    intoShopButton.layer.borderWidth = 0.5;
    intoShopButton.layer.masksToBounds = YES;
    intoShopButton.layer.cornerRadius = 10;
//    [intoShopButton addTarget:self action:@selector(intoButtonClick:) forControlEvents:UIControlEventTouchUpInside];
//    [intoShopButton setTitle:@"加入购物车" forState:UIControlStateNormal];
    [intoShopButton setTitle:@"立即购买" forState:UIControlStateNormal];
    
//    intoShopButton.userInteractionEnabled = NO;
//    intoShopButton.backgroundColor = lightgrayTextColor;
   
//    [intoShopButton setTitleColor:[UIColor colorWithHexString:@"ffb11b"] forState:UIControlStateNormal];
    intoShopButton.titleLabel.font = [UIFont systemFontOfSize:12];
    [self addSubview:intoShopButton];
    [intoShopButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-12);
        make.top.equalTo(line.mas_bottom).offset(10);
        make.height.mas_offset(20);
        make.width.mas_offset(65);
    }];
    UIButton *buyButton = [UIButton buttonWithType:UIButtonTypeCustom];
    buyButton.layer.borderColor = [UIColor colorWithHexString:@"fa3636"].CGColor;
    buyButton.layer.borderWidth = 0.5;
    buyButton.layer.masksToBounds = YES;
    buyButton.layer.cornerRadius = 10;
    [buyButton addTarget:self action:@selector(buyButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [buyButton setTitle:@"立即购买" forState:UIControlStateNormal];
//    buyButton.userInteractionEnabled = NO;
//    buyButton.backgroundColor = lightgrayTextColor;
    [buyButton setTitleColor:[UIColor colorWithHexString:@"fa3636"] forState:UIControlStateNormal];
    buyButton.titleLabel.font = [UIFont systemFontOfSize:12];
    [self addSubview:buyButton];
    [buyButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(intoShopButton.mas_left).offset(-10);
        make.top.equalTo(line.mas_bottom).offset(10);
        make.height.mas_offset(20);
        make.width.mas_offset(55);
    }];
    UIView *footView = [UIView new];
    footView.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];
    [self addSubview:footView];
    [footView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(0);
        make.height.mas_offset(8);
        make.width.mas_offset(KWIDTH);
        make.bottom.mas_offset(0);
    }];
    
}
- (void)buyButtonClick:(UIButton *)sender {
    sender.selected = !sender.selected;
    !_buyButtonClick ? : _buyButtonClick();
}
- (void)intoButtonClick:(UIButton *)sender {
    sender.selected = !sender.selected;
    !_purchaseButtonClick ? : _purchaseButtonClick();
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
