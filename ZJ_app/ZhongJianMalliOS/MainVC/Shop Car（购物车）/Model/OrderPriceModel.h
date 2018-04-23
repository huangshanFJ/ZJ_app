//
//  OrderPriceModel.h
//  ZhongJianMalliOS
//
//  Created by 段 on 2018/3/4.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OrderPriceModel : NSObject


@property (nonatomic,strong)NSMutableArray *productList;//商家订单数量
@property (nonatomic,copy)NSString *producerName;//商家名称
- (instancetype)initWithDic:(NSDictionary *)dic;


@end
