//
//  BasePhotoModel.m
//  ZhongJianMalliOS
//
//  Created by mac_fj on 2018/4/23.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "BasePhotoModel.h"

@implementation Photo

@end

@implementation BasePhotoModel

+ (NSDictionary *)mj_objectClassInArray {
    return @{
             @"coursePhotos":@"Photo"
             };
}

@end
