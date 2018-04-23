//
//  DetailCollectionView.h
//  ZhongJianMalliOS
//
//  Created by 段 on 2017/11/24.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailCollectionView : UICollectionView
/**
  *  @frame: 外界传来的frame 即collectionView的大小
  *
  *  @itemSize: 即collectionViewCell上的Item大小
  *
  *  @imagerArr: 外界存放UIImage的数组
  */
- (instancetype)initWithFrame:(CGRect)frame collectionViewItemSize:(CGSize)itemSize withImageArr:(NSArray *)imagerArr withHeadImageArray:(NSArray *)headImageArr withHeadName:(NSArray *)headNameArray shopDetailArry:(NSArray *)detailShopArray;

@end
