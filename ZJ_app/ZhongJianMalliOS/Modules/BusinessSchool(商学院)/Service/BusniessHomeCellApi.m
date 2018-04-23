//
//  BusniessHomeCellApi.m
//  ZhongJianMalliOS
//
//  Created by mac_fj on 2018/4/9.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "BusniessHomeCellApi.h"

@interface BusniessHomeCellApi()
{
    NSString *_type;
    NSString *_page;
    NSString *_pageNum;
}
@end

@implementation BusniessHomeCellApi

- (instancetype)initWithType:(NSInteger)type page:(NSInteger)page pageNum:(NSInteger)pageNum {
    self = [super init];
    if (self) {
        _type = [NSString stringWithFormat:@"%ld",type];
        _page = [NSString stringWithFormat:@"%ld",page];
        _pageNum = [NSString stringWithFormat:@"%ld",pageNum];
    }
    return self;
}

- (NSString *)requestUrl {
    return @"/zjapp/v2/commercialcollege/coursesbytype";
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
