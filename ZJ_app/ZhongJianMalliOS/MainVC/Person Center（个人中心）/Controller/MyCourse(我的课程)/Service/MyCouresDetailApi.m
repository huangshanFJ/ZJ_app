//
//  MyCouresDetailApi.m
//  ZhongJianMalliOS
//
//  Created by mac_fj on 2018/4/12.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "MyCouresDetailApi.h"

@interface MyCouresDetailApi ()
{
    NSString *_type;
    NSString *_page;
    NSString *_pageNum;
}
@end

@implementation MyCouresDetailApi

- (instancetype)initWithType:(NSString *)type page:(NSInteger)page pageNum:(NSInteger)pageNum {
    if (self = [super init]) {
        _type = type;
        _page = [NSString stringWithFormat:@"%ld",page];
        _pageNum = [NSString stringWithFormat:@"%ld",pageNum];
    }
    return self;
}

- (NSString *)requestUrl {
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *token = [user objectForKey:@"userToken"];
    return [NSString stringWithFormat:@"%@%@",@"/zjapp/v2/commercialcollege/myCourses/",token];
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodGET;
}

- (id)requestArgument {
    return @{
             @"type":_type,
             @"page":_page,
             @"pageNum":_pageNum
             };
}

@end
