//
//  SyncHandleVipOrderApi.m
//  ZhongJianMalliOS
//
//  Created by mac_fj on 2018/4/4.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "SyncHandleVipOrderApi.h"

@interface SyncHandleVipOrderApi ()
{
    NSString *_orderNoc;
}
@end

@implementation SyncHandleVipOrderApi

- (instancetype)initWithOrderNoc:(NSString *)orderNoc {
    self = [super init];
    if (self) {
        _orderNoc = orderNoc;
    }
    return self;
}

- (NSString *)requestUrl {
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *token = [user objectForKey:@"userToken"];
    return [NSString stringWithFormat:@"%@/%@",@"/zjapp/v1/MemberShip/syncHandleVipOrder",token];
}

- (id)requestArgument {
    return @{
             @"orderNo":_orderNoc
             };
}


@end
