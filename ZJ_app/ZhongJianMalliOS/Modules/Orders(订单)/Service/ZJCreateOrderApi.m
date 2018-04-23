//
//  ZJCreateOrderApi.m
//  ZhongJianMalliOS
//
//  Created by mac_fj on 2018/4/3.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "ZJCreateOrderApi.h"

@interface ZJCreateOrderApi ()
{
    NSDictionary *_params;
}
@end

@implementation ZJCreateOrderApi

-(instancetype)initWithOrderParams:(NSDictionary *)params {
    self = [super init];
    if (self) {
        _params = params;
    }
    return self;
}

- (NSString *)requestUrl {
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *token = [user objectForKey:@"userToken"];
    return [NSString stringWithFormat:@"%@/%@",@"/zjapp/v1/PersonalCenter/createBOrder",token];
}

- (id)requestArgument {
    return _params;
}


- (YTKRequestSerializerType)requestSerializerType {
    return YTKRequestSerializerTypeJSON;
}

//
- (NSDictionary<NSString *,NSString *> *)requestHeaderFieldValueDictionary {
    return @{
             @"Content-Type":@"application/json;charset=UTF-8"
             };
}

//- (NSURLRequest *)buildCustomUrlRequest {
//
//
//    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",HTTPUrl,self.requestUrl]]];
//
//    NSString *contentStr = [self.requestArgument jsonStringEncoded];
//
//    [request setHTTPMethod:@"POST"];
//
////    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
//
//    NSData *bodyData = [contentStr dataUsingEncoding:NSUTF8StringEncoding];
//
//    [request setHTTPBody:bodyData];
//    return request;
//
//
//
//}


@end
