//
//  ShopCarCell.m
//  ZhongJianMalliOS
//
//  Created by 段 on 2017/12/11.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "ShopCarCell.h"

@implementation ShopCarCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self creatCellView];
    }
    return self;
}
- (void)creatCellView {
    self.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];
    UIView *topView = [[UIView alloc] init];
    topView.backgroundColor = [UIColor whiteColor];
    [self addSubview:topView];
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(0);
        make.height.mas_offset(100);
        make.width.mas_offset(KWIDTH);
        make.top.mas_offset(7);
    }];
    
    _selectedButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_selectedButton setBackgroundImage:[UIImage imageNamed:@"choose"] forState:UIControlStateNormal];
    //[_selectedButton addTarget:self action:@selector(selectedButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:_selectedButton];
    [_selectedButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(10);
        make.centerY.mas_offset(0);
        make.width.mas_offset(16);
        make.height.mas_offset(16);
    }];
    _shopImageView = [[UIImageView alloc] init];
    _shopImageView.layer.cornerRadius = 3;
    _shopImageView.layer.masksToBounds = YES;
    [topView addSubview:_shopImageView];
    [_shopImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_selectedButton.mas_right).offset(12);
        make.width.mas_offset(85);
        make.height.mas_offset(85);
        make.top.mas_offset(10);
    }];
    _shopNameLabel = [[UILabel alloc] init];
    _shopNameLabel.textColor = lightBlackTextColor;
    _shopNameLabel.font = [UIFont systemFontOfSize:13];
    [topView addSubview:_shopNameLabel];
    [_shopNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_shopImageView.mas_right).offset(11);
        make.right.mas_offset(-11);
        make.top.mas_offset(10);
    }];
    
    _shopNormsLabel = [[UILabel alloc] init];
    _shopNormsLabel.textColor = lightgrayTextColor;
    _shopNormsLabel.font = [UIFont systemFontOfSize:12];
    [topView addSubview:_shopNormsLabel];
    [_shopNormsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_shopImageView.mas_right).offset(11);
        make.right.mas_offset(-11);
        make.top.equalTo(_shopNameLabel.mas_bottom).offset(15);
    }];
    
    _priceLabel = [[UILabel alloc] init];
    _priceLabel.textColor = redTextColor;
    [topView addSubview:_priceLabel];
    [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_shopImageView.mas_right).offset(11);
        make.top.equalTo(_shopNormsLabel.mas_bottom).offset(20);
        make.height.mas_offset(18);
    }];

    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didClickTpuchView:)];
    tap.delegate = self;
    [topView addGestureRecognizer:tap];
    UIButton *addButton = [UIButton buttonWithType:UIButtonTypeCustom];
    addButton.layer.borderColor = [UIColor colorWithHexString:@"d4d4d4"].CGColor;
    addButton.layer.borderWidth = 0.5;
    addButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [addButton setTitle:@"+" forState:UIControlStateNormal];
    [addButton setTitleColor:[UIColor colorWithHexString:@"444444"] forState:UIControlStateNormal];
    [addButton addTarget:self action:@selector(addShopButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:addButton];
    [addButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-10);
        make.width.mas_offset(21);
        make.height.mas_offset(21);
        make.centerY.equalTo(_priceLabel.mas_centerY).offset(0);
    }];
    _numberLabel = [[UILabel alloc] init];
    //    _numberLabel.text = @"1";
    _numberLabel.font = [UIFont systemFontOfSize:12];
    _numberLabel.textColor = zjTextColor;
    _numberLabel.layer.borderColor = [UIColor colorWithHexString:@"d4d4d4"].CGColor;
    _numberLabel.layer.borderWidth = 0.5;
    _numberLabel.textAlignment = 1;
    [topView addSubview:_numberLabel];
    [_numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(addButton.mas_left).offset(0);
        make.width.mas_offset(50);
        make.height.mas_offset(21);
        make.top.equalTo(addButton.mas_top).offset(0);
    }];
    UIButton *deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [deleteButton setTitle:@"-" forState:UIControlStateNormal];
    deleteButton.layer.borderWidth = 0.5;
    deleteButton.layer.borderColor = [UIColor colorWithHexString:@"d4d4d4"].CGColor;
    deleteButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [deleteButton addTarget:self action:@selector(deleteShopButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [deleteButton setTitleColor:[UIColor colorWithHexString:@"444444"] forState:UIControlStateNormal];
    [topView addSubview:deleteButton];
    [deleteButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_numberLabel.mas_left).offset(0);
        make.height.mas_offset(21);
        make.width.mas_offset(21);
        make.top.equalTo(addButton.mas_top).offset(0);
    }];
    
    
    
}
-(void)didClickTpuchView:(UITapGestureRecognizer *)tap{
    CGPoint point = [tap locationInView:self];
    if (point.x <= KWIDTH/2) {
        self.selectedButton.selected = !self.selectedButton.selected;
        !_selectedButtonButtonBlock ? : _selectedButtonButtonBlock();
    }
}

//- (void)selectedButtonClick:(UIButton *)sender {
//    sender.selected = !sender.selected;
//    !_selectedButtonButtonBlock ? : _selectedButtonButtonBlock();
//}
- (void)addShopButtonClick:(UIButton *)sender {
    sender.selected = !sender.selected;
    !_addShopButtonClickBlock ? : _addShopButtonClickBlock();
    
}

- (void)deleteShopButtonClick:(UIButton *)sender {
    sender.selected = !sender.selected;
    !_deleteShopButtonClickBlock ? : _deleteShopButtonClickBlock();
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
