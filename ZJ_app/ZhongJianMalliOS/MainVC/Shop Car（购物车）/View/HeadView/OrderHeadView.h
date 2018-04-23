//
//  OrderHeadView.h
//  ZhongJianMalliOS
//
//  Created by 段 on 2017/11/30.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderHeadView : UIView

@property (nonatomic,strong)UIImageView *headImage;//图片
@property (nonatomic,strong)UILabel *headLabel;//名称
@property (nonatomic,strong)UILabel *priceLabel;//价格
@property (nonatomic,strong)UILabel *numberLabel;//数量

@end
