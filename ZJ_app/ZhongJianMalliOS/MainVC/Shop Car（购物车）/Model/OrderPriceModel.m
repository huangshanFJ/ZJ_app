//
//  OrderPriceModel.m
//  ZhongJianMalliOS
//
//  Created by 段 on 2018/3/4.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "OrderPriceModel.h"
#import "DetailOrderPriceModel.h"

@implementation OrderPriceModel

- (instancetype)initWithDic:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dic];
        //创建一个可变数组加载soldarray
        NSMutableArray *soldArray = [NSMutableArray array];
        for (NSDictionary *dic in self.productList) {
            DetailOrderPriceModel *model = [[DetailOrderPriceModel alloc]init];
            
            //add by zy
            model.productID = [NSString stringWithFormat:@"%@",dic[@"product"][@"id"]];
            model.productSpecID =[NSString stringWithFormat:@"%@",dic[@"productSpec"][@"id"]];
            //end
            
            model.orderID = [NSString stringWithFormat:@"%@",dic[@"id"]];
            model.productname = [NSString stringWithFormat:@"%@",dic[@"product"][@"productname"]];
            
//            productSpec
            //hide by zy
//            model.price = [NSString stringWithFormat:@"%@",dic[@"product"][@"price"]];
            model.price = [NSString stringWithFormat:@"%@",dic[@"productSpec"][@"price"]];
            
            model.oldprice = [NSString stringWithFormat:@"%@",dic[@"product"][@"oldprice"]];
            model.freight = [NSString stringWithFormat:@"%@",dic[@"product"][@"freight"]];
            // hide by zy
//            model.elecnum = [NSString stringWithFormat:@"%@",dic[@"product"][@"elecnum"]];
             model.elecnum = [NSString stringWithFormat:@"%@",dic[@"productSpec"][@"elecNum"]];
            
            
            model.producerno = [NSString stringWithFormat:@"%@",dic[@"product"][@"producerno"]];
            model.producertel = [NSString stringWithFormat:@"%@",dic[@"product"][@"producertel"]];
//            model.productname = [NSString stringWithFormat:@"%@",dic[@"producername"]];
            model.photo = [NSString stringWithFormat:@"%@",dic[@"product"][@"productphotos"][0][@"photo"]];
            model.specname = [NSString stringWithFormat:@"%@",dic[@"productSpec"][@"specname"]];
            model.productnum = [NSString stringWithFormat:@"%@",dic[@"productnum"]];
            model.selected = NO;
            model.productphotos = [NSArray arrayWithArray:dic[@"product"][@"productphotos"]];
            
            NSDecimalNumber *number = [NSDecimalNumber decimalNumberWithString:model.productnum];
            NSDecimalNumber *price = [NSDecimalNumber decimalNumberWithString:model.price];
            NSDecimalNumber *totalPrice = [price decimalNumberByMultiplyingBy:number];
            model.totalPrice = [NSString stringWithFormat:@"%@",totalPrice];
            
            [soldArray addObject:model];
        }
        self.productList = soldArray;
    }
    return self;
}

//这个方法一定要实现不然，后台返回的数据多或者少的时候就会崩溃
-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
    //如果和后台返回的字段冲突可以使用这个进行转换
//    if ([key isEqualToString:@"id"]) {
//        self.orderID = value;
//    }
    
}

@end
