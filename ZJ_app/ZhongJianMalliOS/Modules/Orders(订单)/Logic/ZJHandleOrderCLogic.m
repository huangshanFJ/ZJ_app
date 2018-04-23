//
//  ZJHandleOrderCLogic.m
//  ZhongJianMalliOS
//
//  Created by mac_fj on 2018/3/31.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "ZJHandleOrderCLogic.h"
#import "ZJHandleOrderCApi.h"

@implementation ZJHandleOrderCLogic

- (void)handleOrderNoC:(NSString *)ordecNoC {
    
    ZJHandleOrderCApi *request = [[ZJHandleOrderCApi alloc] initWithOrderNoC:ordecNoC];
    [request startWithCompletionBlockWithSuccess:^(__kindof BaseRequestApi * _Nonnull request) {
        
        if ([request.error_code isEqualToString:@"0"]) {
            if (self.delegate && [self.delegate respondsToSelector:@selector(handleOrderCCompleted)]) {
                [self.delegate handleOrderCCompleted];
            }
        } else {
            //未处理
            NSLog(@"订单 error_code != 0 的情况未进行处理");
        }
        
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        //请求失败
    }];
}

@end
