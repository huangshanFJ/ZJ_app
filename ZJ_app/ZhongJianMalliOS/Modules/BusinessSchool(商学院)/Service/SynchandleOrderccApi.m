//
//  SynchandleOrderccApi.m
//  ZhongJianMalliOS
//
//  Created by mac_fj on 2018/4/13.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "SynchandleOrderccApi.h"

@interface SynchandleOrderccApi()
{
    NSString *_orderNo;
}
@end

@implementation SynchandleOrderccApi

- (instancetype)initWithOrderNo:(NSString *)orderNo {
    if (self = [super init]) {
        _orderNo = orderNo;
    }
    return self;
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

- (NSString *)requestUrl {
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *token = [user objectForKey:@"userToken"];
    return [NSString stringWithFormat:@"%@%@",@"/zjapp/v2/commercialcollege/synchandleordercc/",token];
}

- (id)requestArgument {
   return @{
      @"orderNo":_orderNo
      };
}

@end
