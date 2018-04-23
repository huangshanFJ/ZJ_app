//
//  MyCourseDetailCellModel.m
//  ZhongJianMalliOS
//
//  Created by mac_fj on 2018/4/12.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "MyCourseDetailCellModel.h"

@implementation Photo

@end

@implementation MyCourseDetailCellModel

+ (NSDictionary *)mj_objectClassInArray {
    return @{
             @"coursePhotos":@"Photo"
             };
}

@end

@implementation MyCourseModels

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{
             @"courses":@"data"
             };
}

+ (NSDictionary *)mj_objectClassInArray {
    return @{
             @"courses":@"MyCourseDetailCellModel"
             };
}

@end
