//
//  MyOrderModel.m
//  ZhongJianMalliOS
//
//  Created by 段 on 2018/1/24.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "MyOrderModel.h"

@implementation MyOrderModel
-(instancetype)init{
    
    self = [super init];
    if (self) {
        self.orderlines = [NSArray array];
    }
    return self;
}
//这个方法一定要实现不然，后台返回的数据多或者少的时候就会崩溃
-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
    //如果和后台返回的字段冲突可以使用这个进行转换
    if ([key isEqualToString:@"id"]) {
        self.orderId = value;
    }
    
}
@end
