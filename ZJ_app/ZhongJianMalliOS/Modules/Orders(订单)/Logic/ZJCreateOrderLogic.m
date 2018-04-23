//
//  ZJCreateOrderLogic.m
//  ZhongJianMalliOS
//
//  Created by mac_fj on 2018/4/3.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "ZJCreateOrderLogic.h"
#import "ZJCreateOrderApi.h"

@interface ZJCreateOrderLogic ()
{
    CreateOrderPaymentMode _payMode;
    NSString *_params;
}
@end

@implementation ZJCreateOrderLogic

- (void)createOrderWithParams:(NSDictionary *)params {
    
    ZJCreateOrderApi *api = [[ZJCreateOrderApi alloc] initWithOrderParams:params];
    [api start];
    [api startWithCompletionBlockWithSuccess:^(__kindof BaseRequestApi * _Nonnull api) {

        NSDictionary *bodyData = api.result[@"data"];//此时data是一个字典
        
        NSString *type = [NSString stringWithFormat:@"%@",bodyData[@"type"]];
        if ([type intValue] == 1) {
            //购物币支付
            _params = [NSString stringWithFormat:@"%@",bodyData[@"orderNoC"]];
            _payMode = CreateOrderPaymentModeByGold;
        } else if ([type intValue] == 2) {
            //支付宝支付
            _params = [NSString stringWithFormat:@"%@",bodyData[@"singData"]];
            _payMode = CreateOrderPaymentModeByAlipay;
        } else if ([type intValue] == 3) {
            //混合支付
            _params = [NSString stringWithFormat:@"%@",bodyData[@"singData"]];
            _payMode = CreateOrderPaymentModeByMixed;
        }

        if (self.delegate && [self.delegate respondsToSelector:@selector(createOrderCompleted:params:)]) {
            [self.delegate createOrderCompleted:_payMode params:_params];
        }
    
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        //
    }];
}

@end
