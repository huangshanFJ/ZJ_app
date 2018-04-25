//
//  BSegmentChildCell.m
//  ZhongJianMalliOS
//
//  Created by mac_fj on 2018/4/9.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "BSegmentChildCell.h"
#import "BusniessHomeCellModel.h"
#import "UILabel+ZJAutoSize.h"

@interface BSegmentChildCell()
@property (nonatomic, weak) UIImageView *headerImgV;
@property (nonatomic, weak) UILabel *nameLable;
@property (nonatomic, weak) UILabel *tagLable;
@property (nonatomic, weak) UILabel *detailLable;
@property (nonatomic, weak) UILabel *priceLable;
@property (nonatomic, weak) UILabel *timeLable;
@property (nonatomic, weak) UILabel *peopleNumLable;
@end

@implementation BSegmentChildCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self internalInit];
    }
    return self;
}

- (void)internalInit {
    
    __weak typeof(self) weakSelf = self;
    
    UIView *containView = [[UIView alloc] init];
    [self.contentView addSubview:containView];
    [containView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(weakSelf.contentView.mas_width);
        make.left.mas_equalTo(weakSelf.contentView.mas_left);
        make.top.mas_equalTo(weakSelf.contentView.mas_top);
        make.bottom.mas_equalTo(weakSelf.contentView.mas_bottom);
    }];
    
    //头像
    UIImageView *headerImgV = [[UIImageView alloc] init];
    _headerImgV = headerImgV;
    headerImgV.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];
    headerImgV.layer.masksToBounds = YES;
    headerImgV.layer.cornerRadius = 5;
    [containView addSubview:headerImgV];
    [headerImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.and.width.mas_equalTo(81);
        make.left.mas_equalTo(containView.mas_left).offset(11);
        make.centerY.mas_equalTo(containView.mas_centerY);
    }];
    
    //名称
    UILabel *nameLable = [[UILabel alloc] init];
    _nameLable = nameLable;
    nameLable.textAlignment = NSTextAlignmentLeft;
    nameLable.font = [UIFont systemFontOfSize:15];
    nameLable.textColor = [UIColor colorWithHexString:@"444444"];
    [containView addSubview:nameLable];
    [nameLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(headerImgV.mas_top);
        make.left.mas_equalTo(headerImgV.mas_right).offset(12);
//        make.width.mas_equalTo(100);
        make.right.mas_equalTo(containView.mas_right).offset(-5);
        make.height.mas_equalTo(20);
    }];
    
    //详情
    UILabel *detailLable = [[UILabel alloc] init];
    _detailLable = detailLable;
    detailLable.numberOfLines = 0;
    detailLable.font = [UIFont systemFontOfSize:12];
    detailLable.textColor = [UIColor colorWithHexString:@"999999"];
    detailLable.textAlignment = NSTextAlignmentLeft;
    [containView addSubview:detailLable];
    [detailLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(nameLable.mas_left);
        make.top.mas_equalTo(nameLable.mas_bottom).offset(2);
        make.right.mas_equalTo(containView.mas_right).offset(-5);
//        make.height.mas_equalTo(50);
    }];
    
    //价格
    UILabel *priceLable = [[UILabel alloc] init];
    _priceLable = priceLable;
    [containView addSubview:priceLable];
    priceLable.font = [UIFont systemFontOfSize:12];
    priceLable.textAlignment = NSTextAlignmentLeft;
    priceLable.textColor = [UIColor colorWithHexString:@"fb3f45"];
    [priceLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(detailLable.mas_left);
        make.height.mas_equalTo(16);
        make.width.mas_equalTo(100);
        make.bottom.mas_equalTo(headerImgV.mas_bottom);
    }];
    
    //标签
    UILabel *tagLable = [[UILabel alloc] init];
    _tagLable = tagLable;
    tagLable.layer.borderWidth = 1;
    tagLable.layer.borderColor = [UIColor colorWithHexString:@"6493ff"].CGColor;
    tagLable.layer.cornerRadius = 10;
    tagLable.textColor = [UIColor colorWithHexString:@"6493ff"];
    tagLable.textAlignment = NSTextAlignmentCenter;
    tagLable.text = @"立即报名";
    [containView addSubview:tagLable];
    [tagLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(20);
        make.right.mas_equalTo(containView.mas_right).offset(-15);
//        make.bottom.mas_equalTo(priceLable.mas_bottom);
        make.top.mas_equalTo(priceLable.mas_top);
    }];
    
    //时间
//    UILabel *timeLable = [[UILabel alloc] init];
//    _timeLable = timeLable;
//    [containView addSubview:timeLable];
//    timeLable.textAlignment = NSTextAlignmentLeft;
//    [timeLable mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(detailLable.mas_left);
//        make.height.mas_equalTo(16);
//        make.width.mas_equalTo(100);
//        make.bottom.mas_equalTo(headerImgV.mas_bottom);
//    }];
    
    //人数
//    UILabel *peopleNumLable = [[UILabel alloc] init];
//    _peopleNumLable = peopleNumLable;
//    [containView addSubview:peopleNumLable];
//    peopleNumLable.textAlignment =NSTextAlignmentRight;
//    [peopleNumLable mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.mas_equalTo(detailLable.mas_right);
//        make.bottom.mas_equalTo(headerImgV.mas_bottom);
//        make.width.mas_equalTo(80);
//        make.height.mas_equalTo(16);
//    }];
    
    //底线
    UIView *bottomLine = [[UIView alloc] init];
    [containView addSubview:bottomLine];
    bottomLine.backgroundColor = [UIColor colorWithHexString:@"efefef"];
    [bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(1);
        make.left.mas_equalTo(headerImgV.mas_left);
        make.right.mas_equalTo(containView.mas_right);
        make.bottom.mas_equalTo(containView.mas_bottom);
    }];
    
    
}

- (void)updateCellContent:(BusniessHomeCellModel *)model {
    
    NSArray *photos = model.coursePhotos;
    NSURL *imgUrl;
    if (photos.count > 0) {
        Photo *pic = photos[0];
        NSString *urlStr = [NSString stringWithFormat:@"%@%@",HTTPUrl,pic.photo];
        imgUrl = [NSURL URLWithString:urlStr];
    } else {
        imgUrl = nil;
    }    
    [self.headerImgV sd_setImageWithURL:imgUrl];
    
    self.nameLable.text = model.coursename;
    NSString *price = [NSString stringWithFormat:@"%@",model.courseprice];
    self.detailLable.text = model.coursebrief;
    //更新detailLabel高度
    CGFloat height = ceilf([_detailLable sizeForTextFontMaxSize:CGSizeMake(self.contentView.size.width - 115, 50) font:_detailLable.font].height);
    [_detailLable mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(height);
    }];
    
    
    if (model.canApply == NO) {
        self.priceLable.hidden = YES;
        self.tagLable.hidden = YES;
    } else {
        self.priceLable.hidden = NO;
        self.tagLable.hidden = NO;
        self.priceLable.text = [NSString stringWithFormat:@"￥ %@",price];
        NSString *tag = [NSString stringWithFormat:@"%@",model.curstatus];
        if ([tag isEqualToString:@"1"]) {
            self.tagLable.text = @"授课中";
            self.tagLable.textColor = [UIColor colorWithHexString:@"999999"];
            self.tagLable.layer.borderColor = [UIColor colorWithHexString:@"999999"].CGColor;
        } else {
            self.tagLable.text = @"立即报名";
            self.tagLable.textColor = [UIColor colorWithHexString:@"6493ff"];
            self.tagLable.layer.borderColor = [UIColor colorWithHexString:@"6493ff"].CGColor;
        }
    }
    
}


- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
