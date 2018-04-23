//
//  DetailOrderPriceModel.m
//  ZhongJianMalliOS
//
//  Created by 段 on 2018/3/4.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "DetailOrderPriceModel.h"

@implementation DetailOrderPriceModel
//- (instancetype)initWithDic:(NSDictionary *)dic
//{
//    self = [super init];
//    if (self) {
//        [self setValuesForKeysWithDictionary:dic];
//    }
//    return self;
//}

//这个方法一定要实现不然，后台返回的数据多或者少的时候就会崩溃
-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
    //如果和后台返回的字段冲突可以使用这个进行转换
    //    if ([key isEqualToString:@"id"]) {
    //        self.orderID = value;
    //    }
    
}
@end
