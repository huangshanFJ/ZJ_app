//
//  NSString+ZJDecimalNumber.m
//  ZhongJianMalliOS
//
//  Created by mac_fj on 2018/4/13.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "NSString+ZJDecimalNumber.h"

@implementation NSString (ZJDecimalNumber)

+ (NSString *)reviseString:(NSString *)string {
    //直接传入精度丢失有问题的Double类型
    double conversionValue = [string doubleValue];
    NSString *doubleString = [NSString stringWithFormat:@"%lf", conversionValue];
    NSDecimalNumber *decNumber = [NSDecimalNumber decimalNumberWithString:doubleString];
    return [decNumber stringValue];
}


@end
