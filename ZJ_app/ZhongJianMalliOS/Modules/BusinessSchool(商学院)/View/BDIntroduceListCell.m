//
//  BDIntroduceListCell.m
//  ZhongJianMalliOS
//
//  Created by mac_fj on 2018/4/12.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "BDIntroduceListCell.h"
#import "BDIntroduceListModel.h"

@interface BDIntroduceListCell ()

@property (nonatomic, weak) UILabel *numL;
@property (nonatomic, weak) UILabel *logueL;
@property (nonatomic, weak) UILabel *dayL;

@end

@implementation BDIntroduceListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self internalInit];
    }
    return self;
}

- (void)internalInit {
    
    self.contentView.backgroundColor = [UIColor whiteColor];
    
    __weak typeof(self) weakSelf = self;
    
    UIView *containView = [[UIView alloc] init];
    [self.contentView addSubview:containView];
    containView.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];
    [containView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.contentView.mas_top).offset(5);
        make.bottom.mas_equalTo(weakSelf.contentView.mas_bottom).offset(-5);
        make.left.mas_equalTo(weakSelf.contentView.mas_left);
        make.right.mas_equalTo(weakSelf.contentView.mas_right);
    }];
    
    UILabel *numL = [[UILabel alloc] init];
    [containView addSubview:numL];
    _numL = numL;
    numL.textAlignment = NSTextAlignmentLeft;
    numL.font = [UIFont systemFontOfSize:13];
    numL.textColor = [UIColor colorWithHexString:@"444444"];
    [numL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(containView.mas_left).offset(10);
        make.centerY.mas_equalTo(containView.mas_centerY);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(50);
    }];
    
    UILabel *logueL = [[UILabel alloc] init];
    [containView addSubview:logueL];
    _logueL = logueL;
    logueL.font = [UIFont systemFontOfSize:13];
    logueL.textColor = [UIColor colorWithHexString:@"444444"];
    [logueL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(numL.mas_centerY);
        make.left.mas_equalTo(numL.mas_right);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(180);
    }];
    
    
    UILabel *dataL = [[UILabel alloc] init];
    [containView addSubview:dataL];
    dataL.textAlignment = NSTextAlignmentRight;
    dataL.font = [UIFont systemFontOfSize:13];
    dataL.textColor = [UIColor colorWithHexString:@"444444"];
    _dayL = dataL;
    [dataL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(containView.mas_right).offset(-5);
        make.centerY.mas_equalTo(containView.mas_centerY);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(75);
    }];
    
    
    
}

- (void)updateIntroduceLstWithList:(IntroduceList *)model {
    
    self.numL.text = model.numofclass;
    self.logueL.text = model.catalogue;
    self.dayL.text = model.classday;
    
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
