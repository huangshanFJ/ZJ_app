//
//  BusniessDatailIsSignApi.m
//  ZhongJianMalliOS
//
//  Created by mac_fj on 2018/4/11.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "BusniessDatailIsSignApi.h"

@interface BusniessDatailIsSignApi ()
{
    NSString *_courseid;
}
@end

@implementation BusniessDatailIsSignApi

- (instancetype)initWithCourseid:(NSString *)courseid {
    if (self = [super init]) {
        _courseid = courseid;
    }
    return self;
}

- (NSString *)requestUrl {
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *token = [user objectForKey:@"userToken"];
    return [NSString stringWithFormat:@"%@%@",@"/zjapp/v2/commercialcollege/courseissignup/",token];
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodGET;
}

- (id)requestArgument {
    return @{
             @"courseid":_courseid
             };
}

@end
