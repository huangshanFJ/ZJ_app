//
//  ZJPaymentPswLogic.m
//  ZhongJianMalliOS
//
//  Created by mac_fj on 2018/3/31.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "ZJPaymentPswLogic.h"
#import "ZJPaymentPswApi.h"

@interface ZJPaymentPswLogic () {
    VerfyPaymentPswStatus _status;
    NSString *_orderNoc;
}
@end

@implementation ZJPaymentPswLogic

- (void)verifyPaymentPassWord:(NSString *)psw {
    
    ZJPaymentPswApi *request = [[ZJPaymentPswApi alloc] initWithPaymentPsw:psw];
    NSLog(@"request = %@\nrequest.url = %@",request.currentRequest,request.requestUrl);
    [request startWithCompletionBlockWithSuccess:^(__kindof BaseRequestApi * _Nonnull request) {
        
        ZJPaymentPswApi *api = (ZJPaymentPswApi *)request;
//        if (api.bodyData[@"orderNoc"]) {
//            _orderNoc = api.bodyData[@"orderNoc"];
//        }
        
        if ([request.error_code intValue] == 0) {
            _status = VerfyPaymentPswCorrect;
        } else if ([request.error_code intValue] == -1) {
            _status = VerfyPaymentPswNoSet;
        } else if ([request.error_code intValue] == 1) {
            _status = VerfyPaymentPswError;
        }
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(verfyPaymentPswCompleted:)]) {
            [self.delegate verfyPaymentPswCompleted:_status];
        }
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(verfyPaymentPswCompleted:orderNoc:)]) {
            [self.delegate verfyPaymentPswCompleted:_status orderNoc:_orderNoc];
        }
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        //请求失败
        NSLog(@"request.error = %@\n%@\n%@\%@",request.error.localizedDescription,request.responseObject,request.description,request.responseHeaders);
    }];
}

@end
