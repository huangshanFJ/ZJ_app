//
//  EditAdressCell.m
//  ZhongJianMalliOS
//
//  Created by 段 on 2017/12/13.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "EditAdressCell.h"

@implementation EditAdressCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self configCellView];
    }
    return self;
}
- (void)configCellView {
    
    _editNameLabel = [[UILabel alloc] init];
//    _editNameLabel.textAlignment = NSTextAlignmentJustified;
    
    _editNameLabel.textColor = lightgrayTextColor;
    _editNameLabel.font = [UIFont systemFontOfSize:13];
    [self addSubview:_editNameLabel];
    [_editNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(10);
//        make.width.mas_offset(80);
        make.height.mas_offset(45);
        make.top.mas_offset(0);
    }];
//    _editTextField = [[UITextField alloc] init];
//    _editTextField.hidden = YES;
//    _editTextField.font = [UIFont systemFontOfSize:13];
//    [self addSubview:_editTextField];
//    [_editTextField mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(_editNameLabel.mas_right).offset(10);
//        make.height.mas_offset(45);
//        make.top.mas_offset(0);
//        make.width.mas_offset(KWIDTH*0.7);
//    }];
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];
    [self addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(0);
        make.right.mas_offset(0);
        make.bottom.mas_offset(0);
        make.height.mas_offset(1);
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
