//
//  SignupForCourseApi.m
//  ZhongJianMalliOS
//
//  Created by mac_fj on 2018/4/13.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "SignupForCourseApi.h"

@interface SignupForCourseApi ()
{
    NSString *_courseid;
    NSString *_elecnum;
    NSString *_realpay;
}
@end

@implementation SignupForCourseApi

- (instancetype)initWithCourseid:(NSString *)courseid elecnum:(NSString *)elecnum realpay:(NSString *)realpay {
    if (self = [super init]) {
        _courseid = courseid;
        _elecnum = elecnum;
        _realpay = realpay;
    }
    return self;
}

- (NSString *)requestUrl {
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *token = [user objectForKey:@"userToken"];
    return [NSString stringWithFormat:@"%@%@",@"/zjapp/v2/commercialcollege/signupforcourse/",token];
}

- (id)requestArgument {
    return @{
             @"courseId":_courseid,
             @"elecnum":_elecnum,
             @"realpay":_realpay
             };
}

@end
