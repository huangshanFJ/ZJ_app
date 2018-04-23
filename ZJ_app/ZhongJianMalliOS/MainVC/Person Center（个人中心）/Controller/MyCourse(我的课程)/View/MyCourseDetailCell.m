//
//  MyCourseDetailCell.m
//  ZhongJianMalliOS
//
//  Created by mac_fj on 2018/4/12.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "MyCourseDetailCell.h"
#import "MyCourseDetailCellModel.h"
#import "UILabel+ZJAutoSize.h"

@interface MyCourseDetailCell ()

@property (nonatomic, weak) UIImageView *imageV;
@property (nonatomic, weak) UILabel *nameL;
@property (nonatomic, weak) UILabel *detailL;
@property (nonatomic, weak) UILabel *priceL;
@property (nonatomic, weak) UILabel *tagL;

@end

@implementation MyCourseDetailCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self internalInit];
    }
    return self;
}

- (void)internalInit {
    
    __weak typeof(self) weakSelf = self;
    UIView *containView = [[UIView alloc] init];
    containView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:containView];
    [containView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.contentView.mas_left);
        make.right.mas_equalTo(weakSelf.contentView.mas_right);
        make.top.mas_equalTo(weakSelf.contentView.mas_top);
        make.bottom.mas_equalTo(weakSelf.contentView.mas_bottom);
    }];
    
    UIImageView *imageV = [[UIImageView alloc] init];
    [containView addSubview:imageV];
    imageV.layer.masksToBounds = YES;
    imageV.layer.cornerRadius = 5;
    imageV.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];
    [imageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(containView.mas_left).offset(10);
        make.top.mas_equalTo(containView.mas_top).offset(10);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(90);
    }];
    _imageV = imageV;
    
    UILabel *nameL = [[UILabel alloc] init];
    [containView addSubview:nameL];
    nameL.textColor = [UIColor colorWithHexString:@"444444"];
    nameL.font = [UIFont systemFontOfSize:15];
    nameL.textAlignment = NSTextAlignmentLeft;
    [nameL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(imageV.mas_right).offset(10);
        make.top.mas_equalTo(imageV.mas_top);
        make.height.mas_equalTo(20);
        make.right.mas_equalTo(containView.mas_right).offset(-5);
    }];
    _nameL = nameL;
    
    UILabel *detailL = [[UILabel alloc] init];
    [containView addSubview:detailL];
    detailL.textAlignment = NSTextAlignmentLeft;
    detailL.numberOfLines = 0;
    detailL.textColor = [UIColor colorWithHexString:@"444444"];
    detailL.font = [UIFont systemFontOfSize:14];
    detailL.lineBreakMode = NSLineBreakByTruncatingTail;//结尾为...
    [detailL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(nameL.mas_left);
        make.top.mas_equalTo(nameL.mas_bottom);
        make.right.mas_equalTo(containView.mas_right).offset(-5);
        make.height.mas_equalTo(40);
    }];
    _detailL = detailL;
    
    UILabel *priceL = [[UILabel alloc] init];
    [containView addSubview:priceL];
    priceL.textColor = [UIColor colorWithHexString:@"444444"];
    priceL.font = [UIFont systemFontOfSize:14];
    priceL.textAlignment = NSTextAlignmentLeft;
    [priceL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(nameL.mas_left);
        make.bottom.mas_equalTo(containView.mas_bottom).offset(-10);
        make.height.mas_equalTo(15);
        make.width.mas_equalTo(100);
    }];
    _priceL = priceL;
    
    UILabel *tagL = [[UILabel alloc] init];
    [containView addSubview:tagL];
    tagL.textAlignment = NSTextAlignmentRight;
    tagL.textColor = [UIColor colorWithHexString:@"444444"];
    tagL.font = [UIFont systemFontOfSize:13];
    [tagL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(detailL.mas_right).offset(-5);
        make.height.mas_equalTo(15);
        make.width.mas_equalTo(80);
        make.bottom.mas_equalTo(containView.mas_bottom).offset(-13);
    }];
    _tagL = tagL;
    
}


- (void)updateCourseDetailCellWithModel:(MyCourseDetailCellModel *)model {
    
    NSArray *photoArr = model.coursePhotos;
    if (photoArr.count > 0) {
        Photo *pic = model.coursePhotos[0];
        NSString *picStr = [NSString stringWithFormat:@"%@%@",HTTPUrl,pic.photo];
        [_imageV setImageWithURL:[NSURL URLWithString:picStr] placeholder:nil];
    } else {
        
    }
    
    _nameL.text = model.coursename;
    _detailL.text = model.coursebrief;
    //更新detailLabel高度
    CGFloat height = ceilf([_detailL sizeForTextFontMaxSize:CGSizeMake(self.contentView.size.width - 125, 40) font:_detailL.font].height);
    [_detailL mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(height);
    }];
    _priceL.text = [NSString stringWithFormat:@"￥%@",model.courseprice];
    
    if ([model.curstatus isEqualToString:@"0"]) {
        _tagL.text = @"待开课";
    } else if ([model.curstatus isEqualToString:@"1"]) {
        _tagL.text = @"进行中";
    } else if ([model.curstatus isEqualToString:@"-2"]) {
        _tagL.text = @"已结束";
    }
    
    
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
