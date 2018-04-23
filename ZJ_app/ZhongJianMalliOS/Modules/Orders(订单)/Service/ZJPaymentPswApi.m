//
//  ZJPaymentPswApi.m
//  ZhongJianMalliOS
//
//  Created by mac_fj on 2018/3/31.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "ZJPaymentPswApi.h"

@interface ZJPaymentPswApi ()
{
    NSString *_psw;
}
@end

@implementation ZJPaymentPswApi

- (instancetype)initWithPaymentPsw:(NSString *)psw {
    self = [super init];
    if (self) {
        _psw = psw;
    }
    return self;
}

- (NSString *)requestUrl {
    
    return @"/zjapp/v1/PersonalCenter/verifyPayPassword";
}

- (id)requestArgument {
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *token = [user objectForKey:@"userToken"];
    return @{
             @"toKen":token,
             @"payPassword":_psw
             };
    
}

//-(NSDictionary *)responseHeaders {
//    return @{
//             @"Content-Type":@"application/x-www-form-urlencoded"
//             };
//}

@end
