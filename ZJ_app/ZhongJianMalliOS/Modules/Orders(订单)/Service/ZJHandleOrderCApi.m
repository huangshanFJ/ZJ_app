//
//  ZJHandleOrderCApi.m
//  ZhongJianMalliOS
//
//  Created by mac_fj on 2018/3/31.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "ZJHandleOrderCApi.h"

@interface ZJHandleOrderCApi ()
{
    NSString *_oderNoC;
}
@end

@implementation ZJHandleOrderCApi

- (instancetype)initWithOrderNoC:(NSString *)orderNoC {
    self = [super init];
    if (self) {
        _oderNoC = orderNoC;
    }
    return self;
}

- (NSString *)requestUrl {
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *token = [user objectForKey:@"userToken"];
    return [NSString stringWithFormat:@"%@/%@",@"zjapp/v1/PersonalCenter/syncHandleOrderC",token];
}

- (id)requestArgument {
   return @{
      @"orderNoC":_oderNoC
      };
}

@end
