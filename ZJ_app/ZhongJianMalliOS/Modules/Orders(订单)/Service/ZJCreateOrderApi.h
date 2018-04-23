//
//  ZJCreateOrderApi.h
//  ZhongJianMalliOS
//
//  Created by mac_fj on 2018/4/3.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "BaseRequestApi.h"

@interface ZJCreateOrderApi : BaseRequestApi

- (instancetype)initWithOrderParams:(NSDictionary *)params;

@end
