
//
//  BDIntroduceListApi.m
//  ZhongJianMalliOS
//
//  Created by mac_fj on 2018/4/12.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "BDIntroduceListApi.h"

@interface BDIntroduceListApi ()
{
    NSString *_couresid;
}
@end

@implementation BDIntroduceListApi

- (instancetype)initWithCourseid:(NSString *)courseid {
  
    self = [super init];
    if (self) {
        _couresid = courseid;
    }
    return self;
}

- (NSString *)requestUrl {
    return @"/zjapp/v2/commercialcollege/coursedetailcatalog";
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodGET;
}

- (id)requestArgument {
    return @{
             @"courseid":_couresid
             };
}

@end
