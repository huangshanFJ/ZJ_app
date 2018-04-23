//
//  DetailOrderPriceModel.h
//  ZhongJianMalliOS
//
//  Created by 段 on 2018/3/4.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DetailOrderPriceModel : NSObject



@property (nonatomic,copy)NSString *orderID;//订单id
@property (nonatomic,copy)NSString *productID;//商家id
@property (nonatomic,copy)NSString *productname;//商品名
@property (nonatomic,copy)NSString *price;//商品价格
@property (nonatomic,copy)NSString *oldprice;//原价
@property (nonatomic,copy)NSString *freight;//邮费
@property (nonatomic,copy)NSString *elecnum;//积分   /2就是红包
@property (nonatomic,copy)NSString *producerno;//商家信息
@property (nonatomic,copy)NSString *producertel;//商家电话
@property (nonatomic,copy)NSString *photo;//商品图片
@property (nonatomic,copy)NSString *productSpecID;//商品id
@property (nonatomic,copy)NSString *specname;//规格
@property (nonatomic,copy)NSString *productnum;//商品数量
@property (nonatomic,copy)NSArray *productphotos;//照片数量


//custom
@property (nonatomic,assign) BOOL selected;

//@property (nonatomic,strong) NSString *selectedNum;

@property (nonatomic,copy) NSString *totalPrice;

//@property (nonatomic,strong) NSString *totlalElecNum;

//- (instancetype)initWithDic:(NSDictionary *)dic;

@end
