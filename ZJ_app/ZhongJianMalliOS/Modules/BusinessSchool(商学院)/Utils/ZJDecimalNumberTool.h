//
//  ZJDecimalNumberTool.h
//  ZhongJianMalliOS
//
//  Created by mac_fj on 2018/4/13.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZJDecimalNumberTool : NSObject

+ (float)floatWithdecimalNumber:(double)num;

+ (double)doubleWithdecimalNumber:(double)num;

+ (NSString *)stringWithDecimalNumber:(double)num;

+ (NSDecimalNumber *)decimalNumber:(double)num;

@end
