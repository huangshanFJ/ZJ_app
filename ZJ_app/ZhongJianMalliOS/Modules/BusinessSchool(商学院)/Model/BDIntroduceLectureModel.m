//
//  BDIntroduceLectureModel.m
//  ZhongJianMalliOS
//
//  Created by mac_fj on 2018/4/12.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "BDIntroduceLectureModel.h"

@implementation Lecture

@end

@implementation BDIntroduceLectureModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{
             @"lectures":@"data"
             };
}

+ (NSDictionary *)mj_objectClassInArray {
    return @{
             @"lectures":@"Lecture"
             };
}

@end
