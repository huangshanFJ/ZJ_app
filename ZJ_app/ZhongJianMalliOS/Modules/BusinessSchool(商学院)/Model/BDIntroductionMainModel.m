//
//  BDIntroductionMainModel.m
//  ZhongJianMalliOS
//
//  Created by mac_fj on 2018/4/11.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "BDIntroductionMainModel.h"

@implementation Course
@end

@implementation CourseList
@end

@implementation BDIntroductionMainModel

+ (NSDictionary *)mj_objectClassInArray {
    return @{
             @"coursedatalist":@"CourseList"
             };
}


@end
