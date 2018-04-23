//
//  ShopShowCell.h
//  ZhongJianMalliOS
//
//  Created by 段 on 2017/11/2.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShopShowCell : UICollectionViewCell

@property (nonatomic,strong)UIImageView *shopImage;//图片
@property (nonatomic,strong)UILabel *kindLabel;//状态
@property (nonatomic,strong)UILabel *nameLabel;//名称
@property (nonatomic,strong)UILabel *priceLabel;//价格
@property (nonatomic,strong)UILabel *minitLabel;//分值
@property (nonatomic,strong)UIImageView *redPrice;


@end
