//
//  LectureTableCell.m
//  ZhongJianMalliOS
//
//  Created by mac_fj on 2018/4/12.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "LectureTableCell.h"
#import "BDIntroduceLectureModel.h"
#import "UILabel+ZJAutoSize.h"

@interface LectureTableCell ()
{
    CGFloat _detailLHeght;
}
@property (nonatomic, weak) UIImageView *headerImgV;
@property (nonatomic, weak) UILabel *nameL;
@property (nonatomic, weak) UILabel *detailL;

@end

@implementation LectureTableCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self internalInit];
    }
    return self;
}

- (void)internalInit {
    
    __weak typeof(self) weakSelf = self;
    UIImageView *headerImgV = [[UIImageView alloc] init];
    headerImgV.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];
    [self.contentView addSubview:headerImgV];
    _headerImgV = headerImgV;
    [headerImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.contentView.mas_left).offset(10);
        make.width.and.height.mas_equalTo(70);
        make.top.mas_equalTo(weakSelf.contentView.mas_top).offset(15);
    }];
   
    
    UILabel *nameL = [[UILabel alloc] init];
    [self.contentView addSubview:nameL];
    _nameL = nameL;
    nameL.text = @"ABye";
    nameL.textAlignment = NSTextAlignmentLeft;
    [nameL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(headerImgV.mas_right).offset(10);
        make.top.mas_equalTo(headerImgV.mas_top);
        make.height.mas_equalTo(15);
        make.width.mas_equalTo(100);
    }];
    
    UILabel *detailL = [[UILabel alloc] init];
    [self.contentView addSubview:detailL];
    _detailL = detailL;
    detailL.numberOfLines = 0;
    detailL.font = [UIFont systemFontOfSize:13];
    [detailL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(nameL.mas_left);
//        make.bottom.mas_equalTo(weakSelf.contentView.mas_bottom).offset(25);
        make.right.mas_equalTo(weakSelf.contentView.mas_right).offset(-10);
        make.top.mas_equalTo(nameL.mas_bottom).offset(5);
        make.height.mas_equalTo(80);
    }];
    
    
}


- (void)updateLectureCellWithModel:(Lecture *)model {
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",HTTPUrl,model.headpic]];
    [self.headerImgV setImageWithURL:url placeholder:nil];
    self.headerImgV.layer.masksToBounds = YES;
    self.headerImgV.layer.cornerRadius = 35;
    self.nameL.text = model.name;
    self.detailL.text = model.synopsis;
    //更新detailLabel高度
    CGFloat height = ceilf([_detailL sizeForTextFontMaxSize:CGSizeMake(self.contentView.size.width - 100, 80) font:_detailL.font].height);
    [_detailL mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(height);
    }];
    _detailLHeght = height;
}

//返回cell的高度
//+ (CGFloat)cell_heightForModel:(Lecture *)model {
//    return
//}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
