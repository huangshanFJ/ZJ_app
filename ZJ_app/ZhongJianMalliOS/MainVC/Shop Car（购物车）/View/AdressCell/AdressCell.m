//
//  AdressCell.m
//  ZhongJianMalliOS
//
//  Created by 段 on 2017/12/13.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "AdressCell.h"

@implementation AdressCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self configCellView];
    }
    return self;
}
- (void)configCellView {
    _adreeNameLabel = [[UILabel alloc] init];
    _adreeNameLabel.textColor = lightBlackTextColor;
//    _nameLabel.text = @"1ehrwqgr";
    _adreeNameLabel.font = [UIFont systemFontOfSize:13];
    [self addSubview:_adreeNameLabel];
    [_adreeNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(11);
        make.top.mas_offset(10);
        make.height.mas_offset(16);
//        make.width.mas_offset(20);
    }];
    _adreePhoneLabel = [UILabel new];
    _adreePhoneLabel.textColor = [UIColor colorWithHexString:@"444444"];
    _adreePhoneLabel.textAlignment = 2;
    _adreePhoneLabel.font = [UIFont systemFontOfSize:13];
    [self addSubview:_adreePhoneLabel];
    [_adreePhoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-10);
        make.top.mas_offset(10);
        make.height.mas_offset(16);
    }];
    _detailAdressLabel = [[UILabel alloc] init];
    _detailAdressLabel.textColor = lightBlackTextColor;
    _detailAdressLabel.font = [UIFont systemFontOfSize:13];
    [self addSubview:_detailAdressLabel];
    [_detailAdressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(11);
        make.top.equalTo(_adreeNameLabel.mas_bottom).offset(10);
        make.height.mas_offset(20);
    }];
    UILabel *line = [[UILabel alloc] init];
    line.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];
    [self addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(0);
        make.width.mas_offset(KWIDTH);
        make.height.mas_offset(1);
        make.top.equalTo(_detailAdressLabel.mas_bottom).offset(10);
    }];
    
//    _selectedImage = [[UIImageView alloc] init];
//    _selectedImage.image = [UIImage imageNamed:@"choose"];
//    [self addSubview:_selectedImage];
//    [_selectedImage mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_offset(11);
//        make.width.mas_offset(13);
//        make.height.mas_offset(13);
//        make.top.equalTo(line.mas_bottom).offset(9);
//    }];
//    _selectedAdress = [[UILabel alloc] init];
//    _selectedAdress.text = @"设为默认";
//    _selectedAdress.font = [UIFont systemFontOfSize:11];
//    _selectedAdress.textColor = lightgrayTextColor;
//    [self addSubview:_selectedAdress];
//    [_selectedAdress mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(_selectedImage.mas_right).offset(6);
////        make.width.mas_offset();
//        make.height.mas_offset(30);
//        make.top.equalTo(line.mas_bottom).offset(0);
//    }];
//    
//    _selectedButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    _selectedButton.backgroundColor = [UIColor clearColor];
// 
//    [_selectedButton addTarget:self action:@selector(selectedButtonClick:) forControlEvents:UIControlEventTouchUpInside];
//    [self addSubview:_selectedButton];
//    [_selectedButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_offset(11);
//        make.width.mas_offset(75);
//        make.top.equalTo(line.mas_bottom).offset(0);
//        make.height.mas_offset(30);
//    }];
    UILabel *deleteLabel = [[UILabel alloc] init];
    deleteLabel.textColor = lightgrayTextColor;
    deleteLabel.text = @"删除";
    deleteLabel.textAlignment = 2;
    deleteLabel.font = [UIFont systemFontOfSize:11];
    [self addSubview:deleteLabel];
    [deleteLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-10);
        make.top.equalTo(line.mas_bottom).offset(0);
        make.height.mas_offset(30);
    }];
    UIImageView *deleteImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"delete"]];
    [self addSubview:deleteImage];
    [deleteImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(deleteLabel.mas_left).offset(-6);
        make.width.mas_offset(13);
        make.height.mas_offset(13);
        make.top.equalTo(line.mas_bottom).offset(9);
    }];
    
    UIButton *deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
    deleteButton.backgroundColor = [UIColor clearColor];
    [deleteButton addTarget:self action:@selector(deleteButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:deleteButton];
    [deleteButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-10);
        make.width.mas_offset(80);
        make.top.equalTo(line.mas_bottom).offset(0);
        make.height.mas_offset(30);
    }];
 
}
- (void)selectedButtonClick:(UIButton *)sender {
    sender.selected = !sender.selected;
    !_selectedButtonButtonBlock ? : _selectedButtonButtonBlock();
}
- (void)deleteButtonClick:(UIButton *)sender {
    sender.selected = !sender.selected;
    !_deleteButtionButtonClick ? : _deleteButtionButtonClick();
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
