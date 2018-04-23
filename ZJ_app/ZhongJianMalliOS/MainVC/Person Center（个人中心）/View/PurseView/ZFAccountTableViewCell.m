//
//  ZFAccountTableViewCell.m
//  ZhongJianMalliOS
//
//  Created by 段 on 2018/1/29.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "ZFAccountTableViewCell.h"

@implementation ZFAccountTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initWithView];
    }
    return self;
}
- (void)initWithView {
    
    
    
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
