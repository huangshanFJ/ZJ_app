//
//  HttpRequest.h
//  mingtao
//
//  Created by Linlin Ge on 2016/11/24.
//  Copyright © 2016年 Linlin Ge. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HttpRequest : NSObject
//GET请求
+ (void)getWithURLString:(NSString *)URLString
              parameters:(id)parameters
                 WithSuccess:(void (^)(id result))success
                    With:(void (^)(NSError *error))falure;

// POST请求
+ (void)postWithURLString:(NSString *)URLString
               parameters:(id)parameters
                  WithSuccess:(void (^)(id result))success
                     With:(void (^)(NSError *error))falure;
//+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;

// 上传多张图片
+ (void)uploadMostImageWithURLString:(NSString *)URLString
                          parameters:(id)parameters
                         uploadDatas:(NSArray *)uploadDatas
                          uploadName:(NSString *)uploadName
                             WithSuccess:(void (^)(id result))success
                                With:(void (^)(NSError *error))falure;

+ (void)uploadWithURLString:(NSString *)URLString
                 parameters:(id)parameters
                 uploadData:(NSData *)uploadData
                 uploadName:(NSString *)uploadName
                    WithSuccess:(void (^)(id result))success
                       With:(void (^)(NSError *error))falure;
@end
