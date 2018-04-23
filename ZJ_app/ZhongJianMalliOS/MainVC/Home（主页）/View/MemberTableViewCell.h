//
//  MemberTableViewCell.h
//  ZhongJianMalliOS
//
//  Created by 段 on 2018/1/17.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MemberTableViewCell : UITableViewCell
@property (nonatomic,strong)UIImageView *giftImage;//图片
@property (nonatomic,strong)UILabel *giftNameLabel;//商品信息
@property (nonatomic,strong)UILabel *priceLabel;//价格
@property (nonatomic,strong)UILabel *miniteLabel;//红包
@property (nonatomic,strong)UILabel *redpacker;//积分

@end
