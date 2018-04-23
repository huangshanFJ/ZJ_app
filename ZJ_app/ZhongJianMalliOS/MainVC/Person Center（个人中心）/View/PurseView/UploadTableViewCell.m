//
//  UploadTableViewCell.m
//  ZhongJianMalliOS
//
//  Created by 段 on 2018/1/2.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "UploadTableViewCell.h"

@implementation UploadTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initCellView];
    }
    return self;
}
- (void)initCellView {
    _kindNameLabel = [[UILabel alloc] init];
    _kindNameLabel.font = [UIFont systemFontOfSize:13];
    _kindNameLabel.textColor = lightBlackTextColor;
    [self addSubview:_kindNameLabel];
    [_kindNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(10);
        make.height.mas_offset(20);
        make.top.mas_offset(15);
    }];
//    UIButton *selctedPhotoButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    selctedPhotoButton.layer.cornerRadius = 5;
//    selctedPhotoButton.layer.masksToBounds = YES;
//    selctedPhotoButton.layer.borderWidth = 1;
//    selctedPhotoButton.layer.borderColor = [UIColor colorWithHexString:@"dcdcdc"].CGColor;
//    [selctedPhotoButton setImage:[UIImage imageNamed:@"addto-2"] forState:UIControlStateNormal];
//    [selctedPhotoButton addTarget:self action:@selector(selectedButtonClick:) forControlEvents:UIControlEventTouchUpInside];
//    [self addSubview:selctedPhotoButton];
//    [selctedPhotoButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_offset(80);
//        make.top.equalTo(_kindNameLabel.mas_bottom).offset(5);
//        make.width.mas_offset(75);
//        make.height.mas_offset(50);
//    }];
//    _deleteButtonOne = [UIButton buttonWithType:UIButtonTypeCustom];
//    [_deleteButtonOne setBackgroundImage:[UIImage imageNamed:@"delete"] forState:UIControlStateNormal];
//    _deleteButtonOne.hidden = YES;
//    [selctedPhotoButton addSubview:_deleteButtonOne];
//    [_deleteButtonOne mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.equalTo(selctedPhotoButton.mas_right).offset(0);
//        make.centerY.equalTo(selctedPhotoButton.mas_top).offset(0);
//        make.width.mas_equalTo(15);
//        make.height.mas_equalTo(15);
//    }];
//
//    _identityButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    [_identityButton setImage:[UIImage imageNamed:@"addto-2"] forState:UIControlStateNormal];
//    _identityButton.layer.cornerRadius = 5;
//    _identityButton.hidden = YES;
//    _identityButton.layer.masksToBounds = YES;
//    _identityButton.layer.borderWidth = 1;
//    _identityButton.layer.borderColor = [UIColor colorWithHexString:@"dcdcdc"].CGColor;
//    [_identityButton addTarget:self action:@selector(identityButtonClick:) forControlEvents:UIControlEventTouchUpInside];
//    [self addSubview:_identityButton];
//    [_identityButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(selctedPhotoButton.mas_right).offset(15);
//        make.top.equalTo(_kindNameLabel.mas_bottom).offset(5);
//        make.width.mas_offset(75);
//        make.height.mas_offset(50);
//    }];
//    _deleteButtonTwo = [UIButton buttonWithType:UIButtonTypeCustom];
//    [_deleteButtonTwo setBackgroundImage:[UIImage imageNamed:@"delete"] forState:UIControlStateNormal];
//    _deleteButtonTwo.hidden = YES;
//    [_identityButton addSubview:_deleteButtonTwo];
//    [_deleteButtonTwo mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.equalTo(_identityButton.mas_right).offset(0);
//        make.centerY.equalTo(_identityButton.mas_top).offset(0);
//        make.width.mas_equalTo(15);
//        make.height.mas_equalTo(15);
//    }];
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = [UIColor colorWithHexString:@"dcdcdc"];
    [self addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.bottom.mas_equalTo(-0.5);
        make.height.mas_equalTo(0.5);
        make.right.mas_equalTo(0);
    }];
}
- (void)selectedButtonClick:(UIButton*)sender {
    sender.selected = !sender.selected;
    !_selectedPhotoClick ? : _selectedPhotoClick();
    
}
- (void)identityButtonClick:(UIButton*)sender {
    sender.selected = !sender.selected;
    !_selectedIdentityClick ? : _selectedIdentityClick();
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
