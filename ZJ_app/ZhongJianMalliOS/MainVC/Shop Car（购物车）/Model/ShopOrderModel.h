//
//  ShopOrderModel.h
//  ZhongJianMalliOS
//
//  Created by hismobile on 2018/3/9.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShopOrderModel : NSObject
//freight":0,  //邮费直接传0
//"memo":"", //备注
//"orderLines":[
//{
//    "productId":516, //商品ID
//    "productNum":1,
//    "specId":1237  //规格ID
//}
//              ],
//"producername":"西域美农", //商家名称
//"producerno":"01",    //商家号
//"producertel":"18668975234", //商家电话
//"realPay":0,                           //该单实付金额
//"totalAmount":39,        //该单总金额
//"useCoupon":6,//该单红包金额
//"useElecNum":0,//该单现金金额
//"usePointNum":33,//该单购物币金额
//"useVIPRemainNum":0//该单积分金额 （这个直接传0就好）
@property (nonatomic,strong) NSString *producername;
@property (nonatomic,strong) NSString *producerno;
@property (nonatomic,strong) NSString *producertel;
@property (nonatomic,strong) NSString *freight;
@property (nonatomic,strong) NSString *memo;
@property (nonatomic,strong) NSArray *orderLines;


@property (nonatomic,strong) NSString *realPay;
@property (nonatomic,strong) NSString *totalAmount;

@property (nonatomic,strong) NSString *useCoupon;
@property (nonatomic,strong) NSString *useElecNum;
@property (nonatomic,strong) NSString *usePointNum;
@property (nonatomic,strong) NSString *useVIPRemainNum;


@end
