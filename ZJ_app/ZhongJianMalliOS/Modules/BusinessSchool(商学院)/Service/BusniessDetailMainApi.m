//
//  BusniessDetailMainApi.m
//  ZhongJianMalliOS
//
//  Created by mac_fj on 2018/4/10.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "BusniessDetailMainApi.h"

@interface BusniessDetailMainApi()
{
    NSString *_courseID;
}
@end

@implementation BusniessDetailMainApi

- (instancetype)initWithCourseId:(NSString *)courseId {
    if (self = [super init]) {
        _courseID = courseId;
    }
    return self;
}

- (NSString *)requestUrl {
    return @"/zjapp/v2/commercialcollege/coursedetailmain";
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodGET;
}

- (id)requestArgument {
    return @{
             @"courseid":_courseID
             };
}

@end

