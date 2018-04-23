//
//  ZJServices.m
//  ZhongJianMalliOS
//
//  Created by mac_fj on 2018/3/26.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "ZJServices.h"
#import "ZJServiceConsts.h"

@implementation ZJServices

//+ (AFHTTPSessionManager *)objectManager {
//    return [self objectManager:ZJ_SERVICE_BASE_URL];
//}
//
//+ (AFHTTPSessionManager *)objectManager:(NSString *)baseUrl {
//    AFHTTPSessionManager *manager = [[AFHTTPSessionManager manager] initWithBaseURL:[NSURL URLWithString:baseUrl]];
//    return manager;
//}

//+ (NSString *)serviceUrlWithName:(NSString *)name version:(NSString *)version {
//    return [NSString stringWithFormat:@"%@%@",name,version];
//}


/*
+ (void)verifyPassWord:(NSDictionary *)parameters successBlock:(ZJ_SVC_SUCC_BLOCK)successBlock errorBlock:(ZJ_SVC_ERR_BLOCK)errorBlock {
    
    NSString *servicePath = @"/zjapp/v1/PersonalCenter/verifyPayPassword";
    [self postObjectWithUrl:servicePath parameters:parameters successBlock:successBlock errorBlock:errorBlock];
}

+ (void)syncHandleOrderC:(NSDictionary *)parameters successBlock:(ZJ_SVC_SUCC_BLOCK)successBlock errorBlock:(ZJ_SVC_ERR_BLOCK)errorBlock {
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *token = [user objectForKey:@"userToken"];
    NSString *servicePath = [NSString stringWithFormat:@"%@%@",@"/zjapp/v1/PersonalCenter/syncHandleOrderC/",token];
    [self postObjectWithUrl:servicePath parameters:parameters successBlock:successBlock errorBlock:errorBlock];
}

#pragma mark - BaseRequest

+ (void)getObjectWithUrl:(NSString *)url parameters:(NSDictionary *)parameters successBlock:(ZJ_SVC_SUCC_BLOCK)successBlock errorBlock:(ZJ_SVC_ERR_BLOCK)errorBlock{
    
    [XMCenter sendRequest:^(XMRequest * _Nonnull request) {
        request.url = [NSString stringWithFormat:@"%@%@",ZJ_SERVICE_BASE_URL,url];
        request.parameters = parameters;
        request.httpMethod = kXMHTTPMethodGET;
        request.responseSerializerType = kXMResponseSerializerJSON;
    } onSuccess:^(id  _Nullable responseObject) {
        successBlock(responseObject);
    } onFailure:^(NSError * _Nullable error) {
        errorBlock(error);
    }];
}

+ (void)postObjectWithUrl:(NSString *)url parameters:(NSDictionary *)parameters successBlock:(ZJ_SVC_SUCC_BLOCK)successBlock errorBlock:(ZJ_SVC_ERR_BLOCK)errorBlock {
    
    [XMCenter sendRequest:^(XMRequest * _Nonnull request) {
        request.url = [NSString stringWithFormat:@"%@%@",ZJ_SERVICE_BASE_URL,url];
        request.parameters = parameters;
        request.httpMethod = kXMHTTPMethodPOST;
        request.responseSerializerType = kXMResponseSerializerJSON;
    } onSuccess:^(id  _Nullable responseObject) {
        successBlock(responseObject);
    } onFailure:^(NSError * _Nullable error) {
        errorBlock(error);
    }];
}
 */
 
@end
