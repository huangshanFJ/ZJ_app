//
//  BusniessHomeCellApi.h
//  ZhongJianMalliOS
//
//  Created by mac_fj on 2018/4/9.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "BaseRequestApi.h"

@interface BusniessHomeCellApi : BaseRequestApi

- (instancetype)initWithType:(NSInteger)type page:(NSInteger)page pageNum:(NSInteger)pageNum;

@end
