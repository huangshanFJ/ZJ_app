//
//  BDIntroduceLectureApi.m
//  ZhongJianMalliOS
//
//  Created by mac_fj on 2018/4/12.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "BDIntroduceLectureApi.h"

@interface BDIntroduceLectureApi ()
{
    NSString *_courseid;
}
@end

@implementation BDIntroduceLectureApi

- (instancetype)initWithCourseId:(NSString *)courseid {
    if (self = [super init]) {
        _courseid = courseid;
    }
    return self;
}

- (NSString *)requestUrl {
    return @"/zjapp/v2/commercialcollege/coursedetaillecturer";
}

- (id)requestArgument {
    return @{
             @"courseid":_courseid
             };
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodGET;
}

@end
