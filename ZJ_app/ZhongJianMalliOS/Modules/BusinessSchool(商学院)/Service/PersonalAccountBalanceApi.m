//
//  PersonalAccountBalanceApi.m
//  ZhongJianMalliOS
//
//  Created by mac_fj on 2018/4/13.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "PersonalAccountBalanceApi.h"

@implementation PersonalAccountBalanceApi

- (NSString *)requestUrl {
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *token = [user objectForKey:@"userToken"];
    return [NSString stringWithFormat:@"%@%@",@"/zjapp/v1/PersonalCenter/GetPersonalInfo/",token];
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodGET;
}

@end
