//
//  MyCouresDetailApi.h
//  ZhongJianMalliOS
//
//  Created by mac_fj on 2018/4/12.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "BaseRequestApi.h"

@interface MyCouresDetailApi : BaseRequestApi

- (instancetype)initWithType:(NSString *)type page:(NSInteger)page pageNum:(NSInteger)pageNum;

@end
