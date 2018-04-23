//
//  MyOrderModel.h
//  ZhongJianMalliOS
//
//  Created by 段 on 2018/1/24.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyOrderModel : NSObject

@property (nonatomic,copy)NSString *createtime;
@property (nonatomic,copy)NSString *curstatus;
@property (nonatomic,copy)NSString *freight;
@property (nonatomic,copy)NSString *orderId;
@property (nonatomic,strong)NSArray *orderlines;
@property (nonatomic,copy)NSString *orderno;
@property (nonatomic,copy)NSString *realpay;
@property (nonatomic,copy)NSString *receivedtime;
@property (nonatomic,copy)NSString *senddate;
@property (nonatomic,copy)NSString *tolnum;
@property (nonatomic,copy)NSString *totalamount;


@end
