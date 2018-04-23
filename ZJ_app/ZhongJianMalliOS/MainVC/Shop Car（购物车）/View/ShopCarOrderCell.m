//
//  ShopCarOrderCell.m
//  ZhongJianMalliOS
//
//  Created by 段 on 2018/3/3.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "ShopCarOrderCell.h"

@implementation ShopCarOrderCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self creatView];
    }
    return self;
}
- (void)creatView {
    self.backgroundColor = [UIColor whiteColor];
    UILabel *freightLabel = [self creatLabeltext:@"运费" textColor:lightgrayTextColor textFont:[UIFont systemFontOfSize:11]];
    [self addSubview:freightLabel];
    [freightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(10);
        make.top.mas_offset(5);
        make.height.mas_offset(20);
    }];
    _freightMoney = [self creatLabeltext:@"免邮" textColor:lightBlackTextColor textFont:[UIFont systemFontOfSize:11]];
    _freightMoney.textAlignment = 2;
    [self addSubview:_freightMoney];
    [_freightMoney mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-10);
        make.top.mas_offset(5);
        make.height.mas_offset(20);
    }];
    
    UIView *grayView = [[UIView alloc] init];
    grayView.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];
    [self addSubview:grayView];
    [grayView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(0);
        make.height.mas_offset(10);
        make.top.equalTo(_freightMoney.mas_bottom).offset(0);
        make.width.mas_offset(KWIDTH);
    }];
    
    _redMoneyPay = [self creatLabeltext:@"可用现金红包￥0" textColor:lightBlackTextColor textFont:[UIFont systemFontOfSize:12]];
    [self addSubview:_redMoneyPay];
    [_redMoneyPay mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(10);
        make.height.mas_offset(21);
        make.top.equalTo(grayView.mas_bottom).offset(0);
    }];
//    _redSwich = [[UISwitch alloc] init];
//    _redSwich.on = YES;
//    _redSwich.onTintColor = [UIColor colorWithHexString:@"6493fe"];
//    [_redSwich addTarget:self action:@selector(redMoneySwitchAction:) forControlEvents:UIControlEventValueChanged];
//    [self addSubview:_redSwich];
//    [_redSwich mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.mas_offset(-25);
//        make.width.mas_offset(35);
//        make.height.mas_offset(21);
//        make.centerY.equalTo(_redMoneyPay.mas_centerY).offset(0);
//    }];
    _shopMoneyPay = [self creatLabeltext:@"可用购物币" textColor:lightBlackTextColor textFont:[UIFont systemFontOfSize:12]];
    [self addSubview:_shopMoneyPay];
    [_shopMoneyPay mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(10);
        make.height.mas_offset(21);
        make.top.equalTo(_redMoneyPay.mas_bottom).offset(0);
    }];
//    _shopSwich = [[UISwitch alloc] init];
//    _shopSwich.on = YES;
//    _shopSwich.onTintColor = [UIColor colorWithHexString:@"6493fe"];
//    [_shopSwich addTarget:self action:@selector(shopMoneySwitchAction:) forControlEvents:UIControlEventValueChanged];
//    [self addSubview:_shopSwich];
//    [_shopSwich mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.mas_offset(-25);
//        make.width.mas_offset(35);
//        make.height.mas_offset(21);
//        make.centerY.equalTo(_shopMoneyPay.mas_centerY).offset(0);
//    }];
    _readyMoneyPay = [self creatLabeltext:@"可用现金币￥0" textColor:lightBlackTextColor textFont:[UIFont systemFontOfSize:12]];
    [self addSubview:_readyMoneyPay];
    [_readyMoneyPay mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(10);
        make.height.mas_offset(21);
        make.top.equalTo(_shopMoneyPay.mas_bottom).offset(0);
    }];
//    _readySwich = [[UISwitch alloc] init];
//    _shopSwich.on = YES;
//    _shopSwich.onTintColor = [UIColor colorWithHexString:@"6493fe"];
//    [_shopSwich addTarget:self action:@selector(shopMoneySwitchAction:) forControlEvents:UIControlEventValueChanged];
//    [self addSubview:_shopSwich];
//    [_readySwich mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.mas_offset(-25);
//        make.width.mas_offset(35);
//        make.height.mas_offset(21);
//        make.centerY.equalTo(_readyMoneyPay.mas_centerY).offset(0);
//    }];
    UIView *grayView1 = [[UIView alloc] init];
    grayView1.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];
    [self addSubview:grayView1];
    [grayView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(0);
        make.width.mas_offset(KWIDTH);
        make.height.mas_offset(10);
        make.top.equalTo(_readyMoneyPay.mas_bottom).offset(0);
    }];
    UILabel *orderTotalLabel = [self creatLabeltext:@"订单总金额" textColor:redTextColor textFont:[UIFont systemFontOfSize:12]];
    [self addSubview:orderTotalLabel];
    [orderTotalLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(10);
        make.top.equalTo(grayView1.mas_bottom).offset(0);
        make.height.mas_offset(20);
    }];
    _totalNumber = [self creatLabeltext:@"￥0" textColor:redTextColor textFont:[UIFont systemFontOfSize:12]];
    _totalNumber.textAlignment = 2;
    [self addSubview:_totalNumber];
    [_totalNumber mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-25);
        make.height.mas_offset(20);
        make.top.equalTo(grayView1.mas_bottom).offset(0);
        make.height.mas_offset(20);
    }];
    UILabel *redNumberLabel = [self creatLabeltext:@"现金红包抵用" textColor:redTextColor textFont:[UIFont systemFontOfSize:12]];
    [self addSubview:redNumberLabel];
    [redNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(10);
        make.height.mas_offset(20);
        make.top.equalTo(orderTotalLabel.mas_bottom).offset(0);
    }];
    
    _redNumber = [self creatLabeltext:@"-￥0.00" textColor:redTextColor textFont:[UIFont systemFontOfSize:12]];
    _redNumber.textAlignment = 2;
    [self addSubview:_redNumber];
    [_redNumber mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-10);
        make.height.mas_offset(20);
        make.top.equalTo(orderTotalLabel.mas_bottom).offset(0);
    }];
    UILabel *shop = [self creatLabeltext:@"购物币抵用" textColor:redTextColor textFont:[UIFont systemFontOfSize:12]];
    [self addSubview:shop];
    [shop mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(10);
        make.height.mas_offset(20);
        make.top.equalTo(redNumberLabel.mas_bottom).offset(0);
    }];
    
    _shopNumber = [self creatLabeltext:@"-￥0.00" textColor:redTextColor textFont:[UIFont systemFontOfSize:12]];
    _shopNumber.textAlignment = 2;
    [self addSubview:_shopNumber];
    [_shopNumber mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-10);
        make.height.mas_offset(20);
        make.top.equalTo(redNumberLabel.mas_bottom).offset(0);
    }];
    UILabel *readyNumberLabel = [self creatLabeltext:@"现金币抵用" textColor:redTextColor textFont:[UIFont systemFontOfSize:12]];
    [self addSubview:readyNumberLabel];
    [readyNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(10);
        make.height.mas_offset(20);
        make.top.equalTo(shop.mas_bottom).offset(0);
    }];
    _readyNumber = [self creatLabeltext:@"-￥0.00" textColor:redTextColor textFont:[UIFont systemFontOfSize:12]];
    _readyNumber.textAlignment = 2;
    [self addSubview:_readyNumber];
    [_readyNumber mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-10);
        make.height.mas_offset(20);
        make.top.equalTo(shop.mas_bottom).offset(0);
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
- (UILabel *)creatLabeltext:(NSString *)text textColor:(UIColor *)color textFont:(UIFont *)font  {
    UILabel *label = [[UILabel alloc] init];
    label.textColor = color;
    label.text = text;
    label.font = font;
    label.font = [UIFont systemFontOfSize:13];
    
    return label;
}
@end
