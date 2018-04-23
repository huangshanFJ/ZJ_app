//
//  SignupForCourseApi.h
//  ZhongJianMalliOS
//
//  Created by mac_fj on 2018/4/13.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "BaseRequestApi.h"

@interface SignupForCourseApi : BaseRequestApi

- (instancetype)initWithCourseid:(NSString *)courseid elecnum:(NSString *)elecnum realpay:(NSString *)realpay;

@end
