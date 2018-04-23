//
//  NewsTableViewCell.m
//  ZhongJianMalliOS
//
//  Created by 段 on 2017/11/14.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "NewsTableViewCell.h"

@implementation NewsTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initCellView];
    }
    return self;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)initCellView {
    
    _headImage = [[UIImageView alloc] init];
    [self addSubview:_headImage];
    [_headImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(11);
        make.top.mas_offset(20);
        make.height.mas_offset(30);
        make.width.mas_offset(30);
    }];
    _redHeadImage = [[UIImageView alloc] init];
    _redHeadImage.layer.cornerRadius = 5;
    _redHeadImage.layer.masksToBounds = YES;
    _redHeadImage.backgroundColor = [UIColor redColor];
    [self addSubview:_redHeadImage];
    [_redHeadImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_headImage.mas_top).offset(0);
        make.centerX.equalTo(_headImage.mas_right).offset(0);
        make.height.mas_offset(10);
        make.width.mas_offset(10);
    }];
    
    _headLabel = [UILabel new];
    _headLabel.text = @"系统消息";
    _headLabel.font = [UIFont systemFontOfSize:14];
    _headLabel.textColor = [UIColor colorWithHexString:@"444444"];
    [self addSubview:_headLabel];
    [_headLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_headImage.mas_right).offset(10);
        make.height.mas_offset(20);
        make.top.mas_offset(15);
        
    }];
    _timerLabel = [UILabel new];
    _timerLabel.textColor = [UIColor colorWithHexString:@"999999"];
    _timerLabel.font = [UIFont systemFontOfSize:11];
    _timerLabel.textAlignment = 2;
    [self addSubview:_timerLabel];
    [_timerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-10);
        make.top.mas_offset(20);
        make.height.mas_offset(10);
//        make.
    }];
    
    _messageLabel = [UILabel new];
    _messageLabel.font = [UIFont systemFontOfSize:12];
    _messageLabel.textColor = [UIColor colorWithHexString:@"999999"];
    [self addSubview:_messageLabel];
    [_messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_headImage.mas_right).offset(10);
        make.height.mas_offset(15);
        make.right.mas_offset(-50);
        make.top.equalTo(_headLabel.mas_bottom).offset(9);
    }];
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];
    [self addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(0);
        make.right.mas_offset(0);
        make.height.mas_offset(0.5);
        make.bottom.equalTo(self.mas_bottom).offset(-1);
    }];
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
