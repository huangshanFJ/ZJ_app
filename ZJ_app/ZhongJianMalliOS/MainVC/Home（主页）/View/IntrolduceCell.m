//
//  IntrolduceCell.m
//  ZhongJianMalliOS
//
//  Created by 段 on 2017/12/5.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "IntrolduceCell.h"

@implementation IntrolduceCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initCellView];
    }
    return self;
}
- (void)initCellView {
    _courseLabel = [[UILabel alloc] init];
    _courseLabel.font = [UIFont systemFontOfSize:17];
    _courseLabel.textColor = lightBlackTextColor;
    [self addSubview:_courseLabel];
    [_courseLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(23);
        make.height.mas_offset(25);
        make.top.mas_offset(12);
    }];
    
    _lecturerLabel = [[UILabel alloc] init];
    _lecturerLabel.font = [UIFont systemFontOfSize:12];
    _lecturerLabel.textColor = lightBlackTextColor;
    [self addSubview:_lecturerLabel];
    [_lecturerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(23);
        make.height.mas_offset(17);
        make.top.equalTo(_courseLabel.mas_bottom).offset(10);
    }];
    
    _timeLabel = [[UILabel alloc] init];
    _timeLabel.font = [UIFont systemFontOfSize:12];
    _timeLabel.textColor = lightBlackTextColor;
    [self addSubview:_timeLabel];
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(23);
        make.height.mas_offset(17);
        make.top.equalTo(_lecturerLabel.mas_bottom).offset(4);
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
