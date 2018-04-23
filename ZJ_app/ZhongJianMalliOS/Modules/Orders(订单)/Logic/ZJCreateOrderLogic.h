//
//  ZJCreateOrderLogic.h
//  ZhongJianMalliOS
//
//  Created by mac_fj on 2018/4/3.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, CreateOrderPaymentMode) {
    CreateOrderPaymentModeNuknow = 0,
    CreateOrderPaymentModeByGold = 1,//平台购物币
    CreateOrderPaymentModeByAlipay = 2,
    CreateOrderPaymentModeByMixed = 3,//混合支付
};

@protocol CreateOrderLogicDelegate <NSObject>
@optional
- (void)createOrderCompleted:(CreateOrderPaymentMode)payMode params:(NSString *)params;
@end

@interface ZJCreateOrderLogic : NSObject

@property (nonatomic, weak) id <CreateOrderLogicDelegate> delegate;

- (void)createOrderWithParams:(NSDictionary *)params;

@end
