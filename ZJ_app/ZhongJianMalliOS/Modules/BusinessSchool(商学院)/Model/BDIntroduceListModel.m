//
//  BDIntroduceListModel.m
//  ZhongJianMalliOS
//
//  Created by mac_fj on 2018/4/12.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "BDIntroduceListModel.h"

@implementation IntroduceList

@end

@implementation BDIntroduceListModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{
             @"lists":@"data"
             };
}

+ (NSDictionary *)mj_objectClassInArray {
    return @{
             @"lists":@"IntroduceList"
             };
}

@end


