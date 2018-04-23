//
//  SendGiftTableViewCell.m
//  ZhongJianMalliOS
//
//  Created by 段 on 2018/1/30.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "SendGiftTableViewCell.h"

@implementation SendGiftTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initCellView];
    }
    return self;
}
- (void)initCellView {
    
    _levLabel = [[UILabel alloc] init];
    _levLabel.textColor = lightBlackTextColor;
//    _levLabel.text = @"等级：VIP";
    _levLabel.font = [UIFont systemFontOfSize:13];
    [self addSubview:_levLabel];
    [_levLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(15);
        make.height.mas_offset(50);
        make.top.mas_offset(0);
    }];
    _sendLabel = [[UILabel alloc] init];
    _sendLabel.textColor = lightBlackTextColor;
    _sendLabel.text = @" ";
    _sendLabel.font = [UIFont systemFontOfSize:13];
    _sendLabel.hidden = YES;
    [self addSubview:_sendLabel];
    [_sendLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_levLabel.mas_right).offset(30);
        make.height.mas_offset(50);
        make.top.mas_offset(0);
    }];
    
    _sendButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    _sendButton setTitle:@"" forState:<#(UIControlState)#>
    _sendButton.titleLabel.font = [UIFont systemFontOfSize:13];
    _sendButton.layer.cornerRadius = 5;
    _sendButton.layer.masksToBounds = YES;
    [_sendButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_sendButton addTarget:self action:@selector(sendButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_sendButton];
    [_sendButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-15);
        make.height.mas_offset(40);
        make.centerY.mas_offset(0);
        make.width.mas_offset(90);
    }];
    
    
    
}
- (void)sendButtonClick:(UIButton *)sender {
    sender.selected = !sender.selected;

    !_sendGiftButtonClickBlock ? : _sendGiftButtonClickBlock();
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
