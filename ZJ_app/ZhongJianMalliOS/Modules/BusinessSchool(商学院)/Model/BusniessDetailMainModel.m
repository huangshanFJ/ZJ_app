//
//  BusniessDetailMainModel.m
//  ZhongJianMalliOS
//
//  Created by mac_fj on 2018/4/11.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "BusniessDetailMainModel.h"

@implementation PhotoModel

@end

@implementation CourseTypeBean

@end


@implementation BusniessDetailMainModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{
             @"identification":@"id"
             };
}

+ (NSDictionary *)mj_objectClassInArray {
    return @{
             @"coursePhotos" : @"PhotoModel"
             };
}

@end
