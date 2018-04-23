//
//  DetailClassTableViewCell.m
//  ZhongJianMalliOS
//
//  Created by 段 on 2017/11/23.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "DetailClassTableViewCell.h"

@implementation DetailClassTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _detailClassLabel = [[UILabel alloc] init];
        _detailClassLabel.textColor = [UIColor colorWithHexString:@"444444"];
        _detailClassLabel.font = [UIFont systemFontOfSize:13];
        [self addSubview:_detailClassLabel];
        [_detailClassLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(10);
            make.height.mas_offset(40);
            make.width.mas_offset(KWIDTH*0.5);
            make.top.mas_offset(0);
        }];
        UIImageView *image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"next"]];
        [self addSubview:image];
        [image mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_offset(-11);
            make.width.mas_offset(13);
            make.height.mas_offset(13);
            make.centerY.equalTo(_detailClassLabel.mas_centerY).offset(0);
        }];
        
    }
    return self;
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
