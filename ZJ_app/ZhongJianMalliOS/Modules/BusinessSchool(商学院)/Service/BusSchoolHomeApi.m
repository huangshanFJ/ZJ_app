//
//  BusSchoolHomeApi.m
//  ZhongJianMalliOS
//
//  Created by mac_fj on 2018/4/9.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "BusSchoolHomeApi.h"

@implementation BusSchoolHomeApi

- (NSString *)requestUrl {
    return @"/zjapp/v2/commercialcollege/homepage";
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodGET;
}


@end
