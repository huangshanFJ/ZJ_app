//
//  DetailClassModel.m
//  ZhongJianMalliOS
//
//  Created by 段 on 2018/1/8.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "DetailClassModel.h"

@implementation DetailClassModel
-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"id"]) {
        _productID = value;
    }
}
@end
