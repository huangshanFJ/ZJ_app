//
//  BaseModel.m
//  ZhongJianMalliOS
//
//  Created by mac_fj on 2018/4/23.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "BaseModel.h"

@implementation BaseModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{
             @"uid":@"id"
             };
}

@end
