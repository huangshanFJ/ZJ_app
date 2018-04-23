//
//  DetailCollectionView.m
//  ZhongJianMalliOS
//
//  Created by 段 on 2017/11/24.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "DetailCollectionView.h"

#define cellID @"cellID"
@interface DetailCollectionView ()<UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, strong) UICollectionViewFlowLayout *layout;
@property (nonatomic, assign) CGSize ItemSize;
@property (nonatomic, strong) NSArray *ImageArray;
@property (nonatomic, strong) NSArray *headImageArray;
@property (nonatomic, strong) NSArray *headNameArray;
@property (nonatomic, strong) NSArray *shopDetailArray;

@end

@implementation DetailCollectionView
- (UICollectionViewFlowLayout *)layout {
    if (!_layout) {
        _layout = [[UICollectionViewFlowLayout alloc] init];
        _layout.itemSize = self.ItemSize;
        _layout.minimumLineSpacing = 10.0;
        _layout.minimumInteritemSpacing = 0.0;
        _layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    }
    return _layout;
}
- (instancetype)initWithFrame:(CGRect)frame collectionViewItemSize:(CGSize)itemSize withImageArr:(NSArray *)imagerArr withHeadImageArray:(NSArray *)headImageArr withHeadName:(NSArray *)headNameArray shopDetailArry:(NSArray *)detailShopArray{
    _ItemSize = itemSize;
    if (self = [super initWithFrame:frame collectionViewLayout:self.layout]) {
        //        [self setLayout:self.layout];
        _ImageArray = imagerArr;
        _headImageArray = headImageArr;
        _headNameArray = headNameArray;
        _shopDetailArray = detailShopArray;
        self.bounces = NO;
        self.pagingEnabled = NO;
        self.backgroundColor = [UIColor whiteColor];
        self.showsHorizontalScrollIndicator = NO;
        self.delegate = self;
        self.dataSource = self;
        [self registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:cellID];
    }
    return self;
}

#pragma mark - UICollectionViewDelegate --- UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.ImageArray.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    UIImageView *shopImage = [[UIImageView alloc] init];
    shopImage.image = [UIImage imageNamed:_ImageArray[indexPath.row]];
    UIImageView *headImage = [[UIImageView alloc] init];
    headImage.image = [UIImage imageNamed:_headImageArray[indexPath.row]];
    UILabel *headName = [[UILabel alloc] init];
    headName.text = [NSString stringWithFormat:@"%@",_headNameArray[indexPath.row]];
    UILabel *detailLabel = [UILabel new];
    detailLabel.text = [NSString stringWithFormat:@"%@",_shopDetailArray[indexPath.row]];
    
    headImage.frame = CGRectMake(12, 12, 24, 24);
    headImage.layer.masksToBounds = YES;
    headImage.layer.cornerRadius = 12;
    
    
    headName.textColor = [UIColor colorWithHexString:@"999999"];
    headName.font = [UIFont systemFontOfSize:11];
    headName.frame = CGRectMake(12+24+10, 12, 90, 24);
    
    detailLabel.font = [UIFont systemFontOfSize:11];
    detailLabel.textColor = [UIColor colorWithHexString:@"444444"];
    detailLabel.numberOfLines = 0;
    detailLabel.frame = CGRectMake(12, 12+24+10, 120, 80);
    
    shopImage.frame = CGRectMake(140, 0, 118, 118);
    
    //    CGRect headImageFrame = headImage.frame;
    //    headImage.frame = headImageFrame;
    //    CGRect imageFrame = imageV.frame;
    //    imageFrame.size = _ItemSize;
    //    imageV.frame = imageFrame;
    
    [cell.contentView addSubview:headImage];
    [cell.contentView addSubview:shopImage];
    [cell.contentView addSubview:headName];
    [cell.contentView addSubview:detailLabel];
    [headImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(12);
        make.width.mas_offset(24);
        make.height.mas_offset(24);
        make.top.mas_offset(12);
    }];
    [headName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(headImage.mas_right).offset(10);
        make.width.mas_offset(80);
        make.height.mas_offset(24);
        make.top.mas_offset(12);
    }];
    [detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(12);
        make.top.equalTo(headImage.mas_bottom).offset(10);
//        make.height.mas_offset();
        make.width.mas_offset(110);
    }];
    [shopImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(0);
        make.height.mas_offset(128);
        make.width.mas_offset(128);
        make.top.mas_offset(0);
    }];
    
   
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"第%ld分区--第%ld个Item", indexPath.section, indexPath.row);
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
