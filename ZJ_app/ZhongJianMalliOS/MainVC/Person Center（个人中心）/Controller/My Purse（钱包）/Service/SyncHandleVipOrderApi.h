//
//  SyncHandleVipOrderApi.h
//  ZhongJianMalliOS
//
//  Created by mac_fj on 2018/4/4.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "BaseRequestApi.h"

@interface SyncHandleVipOrderApi : BaseRequestApi

- (instancetype)initWithOrderNoc:(NSString *)orderNoc;

@end
