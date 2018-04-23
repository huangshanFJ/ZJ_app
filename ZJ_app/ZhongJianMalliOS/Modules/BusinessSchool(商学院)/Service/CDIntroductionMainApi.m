//
//  CDIntroductionMainApi.m
//  ZhongJianMalliOS
//
//  Created by mac_fj on 2018/4/11.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "CDIntroductionMainApi.h"

@interface CDIntroductionMainApi ()
{
    NSString *_courseid;
}
@end

@implementation CDIntroductionMainApi

- (instancetype)initWithCourseid:(NSString *)courseid {
    if (self = [super init]) {
        _courseid = courseid;
    }
    return self;
}

- (id)requestArgument {
    return @{
             @"courseid":_courseid
             };
}

- (NSString *)requestUrl {
    return @"/zjapp/v2/commercialcollege/coursedetailbrief";
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodGET;
}

@end
