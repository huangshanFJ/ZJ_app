//
//  OrderNumberCell.m
//  ZhongJianMalliOS
//
//  Created by 段 on 2017/11/30.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "OrderNumberCell.h"

@implementation OrderNumberCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self creatOrderView];
    }
    return self;
}
- (void)creatOrderView {
    
//    UILabel *buyNumberLabel = [[UILabel alloc] init];
//    buyNumberLabel.text = @"购买数量";
//    buyNumberLabel.textColor = [UIColor colorWithHexString:@"999999"];
//    buyNumberLabel.font = [UIFont systemFontOfSize:13];
//    [self addSubview:buyNumberLabel];
//    [buyNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_offset(10);
//        make.top.mas_offset(16);
//        make.height.mas_offset(18);
//        make.width.mas_offset(100);
//    }];
//    UIButton *addButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    addButton.layer.borderColor = [UIColor colorWithHexString:@"d4d4d4"].CGColor;
//    addButton.layer.borderWidth = 0.5;
//    addButton.titleLabel.font = [UIFont systemFontOfSize:15];
//    [addButton setTitle:@"+" forState:UIControlStateNormal];
//    [addButton setTitleColor:[UIColor colorWithHexString:@"444444"] forState:UIControlStateNormal];
//    [addButton addTarget:self action:@selector(addButtonClick:) forControlEvents:UIControlEventTouchUpInside];
//    [self addSubview:addButton];
//    [addButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.mas_offset(-10);
//        make.width.mas_offset(27);
//        make.height.mas_offset(27);
//        make.centerY.equalTo(buyNumberLabel.mas_centerY).offset(0);
//    }];
//    _numberLabel = [[UILabel alloc] init];
////    _numberLabel.text = @"1";
//    _numberLabel.font = [UIFont systemFontOfSize:12];
//    _numberLabel.textColor = zjTextColor;
//    _numberLabel.layer.borderColor = [UIColor colorWithHexString:@"d4d4d4"].CGColor;
//    _numberLabel.layer.borderWidth = 0.5;
//    _numberLabel.textAlignment = 1;
//    [self addSubview:_numberLabel];
//    [_numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.equalTo(addButton.mas_left).offset(0);
//        make.width.mas_offset(50);
//        make.height.mas_offset(27);
//        make.top.equalTo(addButton.mas_top).offset(0);
//    }];
//    UIButton *deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    [deleteButton setTitle:@"-" forState:UIControlStateNormal];
//    deleteButton.layer.borderWidth = 0.5;
//    deleteButton.layer.borderColor = [UIColor colorWithHexString:@"d4d4d4"].CGColor;
//    deleteButton.titleLabel.font = [UIFont systemFontOfSize:15];
//    [deleteButton addTarget:self action:@selector(deleteButtonClick:) forControlEvents:UIControlEventTouchUpInside];
//    [deleteButton setTitleColor:[UIColor colorWithHexString:@"444444"] forState:UIControlStateNormal];
//    [self addSubview:deleteButton];
//    [deleteButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.equalTo(_numberLabel.mas_left).offset(0);
//        make.height.mas_offset(27);
//        make.width.mas_offset(27);
//        make.top.equalTo(addButton.mas_top).offset(0);
//    }];
//
    UILabel *costLabel = [[UILabel alloc] init];
    costLabel.text = @"运费";
    costLabel.textColor = [UIColor colorWithHexString:@"999999"];
    costLabel.font = [UIFont systemFontOfSize:13];
    [self addSubview:costLabel];
    [costLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(10);
        make.width.mas_offset(100);
        make.height.mas_offset(18);
        make.bottom.mas_offset(-12);
    }];
    
    _costClassLabel = [[UILabel alloc] init];
    _costClassLabel.textAlignment = 2;
    _costClassLabel.font = [UIFont systemFontOfSize:13];
    _costClassLabel.textColor = [UIColor colorWithHexString:@"444444"];
    [self addSubview:_costClassLabel];
    [_costClassLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-10);
        make.width.mas_offset(100);
        make.height.mas_offset(18);
        make.bottom.mas_offset(-12);
    }];
    
}
- (void)addButtonClick:(UIButton *)sender {
    
    sender.selected = !sender.selected;
    !_addButtonClickBlock ? : _addButtonClickBlock();
}
- (void)deleteButtonClick:(UIButton *)sender {
    sender.selected = !sender.selected;
    !_deleteButtonClickBlock ? : _deleteButtonClickBlock();
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
