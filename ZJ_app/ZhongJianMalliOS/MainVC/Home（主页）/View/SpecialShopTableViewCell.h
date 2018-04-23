//
//  SpecialShopTableViewCell.h
//  ZhongJianMalliOS
//
//  Created by 段 on 2017/11/9.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SpecialShopTableViewCell : UITableViewCell

@property (nonatomic,strong) UIImageView *shopImage;//图片
@property (nonatomic,strong) UILabel *shopName;//名字
@property (nonatomic,strong) UILabel *priceLabel;//价格
@property (nonatomic,strong) UILabel *miniteLabel;//分值
@property (nonatomic,strong) UILabel *peopleLabel;//人数

@property (nonatomic,copy) dispatch_block_t buyButtonClick;

@property (nonatomic,copy) dispatch_block_t purchaseButtonClick;

@end
