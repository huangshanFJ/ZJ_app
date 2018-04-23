//
//  BaseRequestApi.m
//  ZhongJianMalliOS
//
//  Created by mac_fj on 2018/3/31.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "BaseRequestApi.h"

@implementation BaseRequestApi

- (void)start {
    [super start];
    //加菊花
    [MBProgressHUD showActivityMessageInView:@"加载中..."];
}


- (instancetype)init {
    self = [super init];
    if (self) {
        
    }
    return self;
}

#pragma mark ============ 自定义数据 ============
- (NSString *)error_message {
    if (self.error) {
        return self.error.localizedDescription;
    }
    NSString *error_message = [NSString stringWithFormat:@"%@",self.result[@"error_message"]];
    return error_message;
}


- (NSString *)error_code {
    NSLog(@"self.result = %@",self.result);
    NSString *code = [NSString stringWithFormat:@"%@",self.result[@"error_code"]];
    return code;
}

- (BOOL)isSuccess {
    NSString *code = [self error_code];
    BOOL isSuccess = NO;
    if ([code isEqualToString:@"0"]) {
        isSuccess = YES;
    } else if ([code isEqualToString:@"3"]) {
        //token过期或被顶掉处理
    
    }
    
    return isSuccess;
}


#pragma mark ============ 定义返回数据格式 ============
- (YTKResponseSerializerType)responseSerializerType {
    return YTKResponseSerializerTypeJSON;
}

#pragma mark ============ 默认请求方式 post ============
- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

#pragma mark ============ 请求失败过滤器 ============
- (void)requestFailedFilter {
    //失败处理
    [MBProgressHUD hideHUD];
}

#pragma mark ============ 请求成功处理器 ============
- (void)requestCompleteFilter {
    
    [MBProgressHUD hideHUD];
    
    self.result = self.responseObject;
    
    NSLog(@"self.result = %@\nself.responseObject = %@ \nself.responseJSONObject = %@\nresponseHeader = %@",self.result,self.responseObject,self.responseJSONObject,self.responseHeaders);
    
    
    
//    if (self.result) {
//        self.bodyData = self.result[@"data"];
//    }
//    NSLog(@"self.bodyData = %@",self.bodyData);
    
    if (![self isSuccess]) {
        //请求成功，但处理情况
        
    };
    
}



#pragma mark ============ 自定义request ============
- (NSURLRequest *)buildCustomUrlRequest {
    return nil;
}



//临时保留吧，设置响应头信息
//- (NSDictionary *)responseHeaders {
////    return @{
////             @"jsonResponseSerializer.acceptableContentTypes":[NSSet setWithObjects:@"application/json", @"text/plain", @"text/javascript", @"text/json",@"text/html", nil]
////             };
//
//    return @{
//             @"Content-Type":@"application/json;charset=UTF-8"
//             };
//
//}


#pragma mark ============ 传输的头部内容 ============
//默认就是该格式
//- (NSDictionary<NSString *,NSString *> *)requestHeaderFieldValueDictionary {
//    return @{
//             query 格式
//             @"Content-Type":@"application/x-www-form-urlencoded"
//             };
//    return @{
//             boby 格式
//             @"Content-Type":@"application/json"
//             };

//}

#pragma mark ============ 定义请求数据格式 ============
////默认就是该格式
//- (YTKRequestSerializerType)requestSerializerType {
//    return YTKRequestSerializerTypeHTTP; //query格式
//    return YTKRequestSerializerTypeJson; //boby格式
//}


@end
