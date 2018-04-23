//
//  ChangeTableCell.m
//  ZhongJianMalliOS
//
//  Created by 段 on 2017/12/14.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "ChangeTableCell.h"

@implementation ChangeTableCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self configCellView];
    }
    return self;
}
- (void)configCellView {
    
    _changeNameLabel = [[UILabel alloc] init];
    _changeNameLabel.textColor = lightBlackTextColor;
    _changeNameLabel.font = [UIFont systemFontOfSize:13];
    [self addSubview:_changeNameLabel];
    [_changeNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(10);
        make.top.mas_offset(0);
//        make.width.mas_offset(50);
        make.bottom.mas_offset(0);
    }];
//    [_headImageButton mas_makeConstraints:^(MASConstraintMaker *make) {
//    }];
    
    _nextImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"next"]];
    _nextImage.hidden = YES;
    [self addSubview:_nextImage];
    [_nextImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-10);
        make.width.mas_offset(12);
        make.height.mas_offset(12);
        make.centerY.mas_offset(0);
    }];
    _detailNameLabel = [[UILabel alloc] init];
    _detailNameLabel.textColor = lightBlackTextColor;
    _detailNameLabel.font = [UIFont systemFontOfSize:13];
    _detailNameLabel.textAlignment = 2;
    _detailNameLabel.hidden = YES;
    [self addSubview:_detailNameLabel];
    [_detailNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_nextImage.mas_left).offset(-7);
        make.height.mas_offset(45);
        make.top.mas_offset(0);
    }];
    _numberLabel = [[UILabel alloc] init];
    _numberLabel.font = [UIFont systemFontOfSize:13];
    _numberLabel.textAlignment = 2;
    _numberLabel.hidden = YES;
    _numberLabel.textColor = lightBlackTextColor;
    [self addSubview:_numberLabel];
    [_numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-10);
        make.height.mas_offset(45);
        make.top.mas_offset(0);
    }];
    _changeTextField = [[UITextField alloc] init];
    _changeTextField.font = [UIFont systemFontOfSize:13];
    _changeTextField.textAlignment = 2;
    _changeTextField.hidden = YES;
    _changeTextField.textColor = lightgrayTextColor;
    [self addSubview:_changeTextField];
    [_changeTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-10);
        make.top.mas_offset(0);
        make.height.mas_offset(45);
        make.width.mas_offset(KWIDTH*0.5);
    }];
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];
    [self addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(0);
        make.bottom.mas_offset(0);
        make.right.mas_offset(0);
        make.height.mas_offset(1);
    }];
    
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)headImageClick:(UIButton *)sender {
    sender.selected = !sender.selected;
    !_selectedPhotoButtonClick ? : _selectedPhotoButtonClick();

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
