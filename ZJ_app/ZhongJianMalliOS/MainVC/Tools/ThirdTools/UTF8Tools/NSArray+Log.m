//
//  NSArray+Log.m
//  数组NSArray
//
//  Created by 609972942 on 14-10-10.
//  Copyright (c) 2014年 ios初学. All rights reserved.
//

#import "NSArray+Log.h"

@implementation NSArray (Log)

//重写NSArray的description方法(按照)
//只要用NSLog(@"%@");方法   系统内部就会调用到下面这个方法中去
- (NSString *)descriptionWithLocale:(id)locale{
    
    NSMutableString *string=[NSMutableString string];
    [string appendString:@"("];
    
//    (NSString * obj in self)
//    (id obj in self)
//    以上两种方法是等价的－－－NSString * obj是说明将要遍历的是字符串,而id obj是说明将要遍历的是任意类型
    
    for (id obj in self) {
        [string appendFormat:@"\n\t\"%@\",",obj];
    }
    [string appendString:@"\n)"];
    return string;
}

@end
