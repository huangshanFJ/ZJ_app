//
//  SettlementViewController.h
//  ZhongJianMalliOS
//
//  Created by 段 on 2017/11/29.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettlementViewController : UIViewController

@property (nonatomic,strong)NSString *isVIP;//是否为VIP
@property (nonatomic,strong)NSDictionary *orderDiction;//商品的一些信息
@property (nonatomic,strong)NSString *producername;//生产商名字
@property (nonatomic,strong)NSString *producerno;
@property (nonatomic,strong)NSString *producertel;
@property (nonatomic,strong)NSString *memo;//备注
@property (nonatomic,strong)NSString *productname;//商品名字
@property (nonatomic,strong)NSString *productId;//商品ID
// add by zy
@property (nonatomic,assign) BOOL isFromShop;
@property (nonatomic,strong) NSMutableArray *dataArray;



@end
