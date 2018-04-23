//
//  CourseCell.m
//  ZhongJianMalliOS
//
//  Created by 段 on 2017/12/6.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "CourseCell.h"

@implementation CourseCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self creatCellView];
    }
    return self;
}
- (void)creatCellView {
    
    _headIconImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"curriculum"]];
    
    [self addSubview:_headIconImage];
    [_headIconImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(20);
        make.width.mas_offset(29);
        make.height.mas_offset(29);
        make.centerY.mas_offset(0);
    }];
    
    _headTitleLabel = [[UILabel alloc] init];
    
    [self addSubview:_headTitleLabel];
    [_headTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_headIconImage.mas_right).offset(7);
        make.height.mas_offset(50);
        make.top.mas_offset(0);
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
