//
//  HttpRequest.m
//  mingtao
//
//  Created by Linlin Ge on 2016/11/24.
//  Copyright © 2016年 Linlin Ge. All rights reserved.
//

#import "HttpRequest.h"
#import "AFHTTPSessionManager.h"
@implementation HttpRequest

#pragma mark -- GET请求 --
+ (void)getWithURLString:(NSString *)URLString
              parameters:(id)parameters
             WithSuccess:(void (^)(id result))success
                    With:(void (^)(NSError *error))falure {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer.timeoutInterval = 10;
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json", @"text/plain", @"text/html", nil];
//    [manager GET:URLString parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
//            success(responseObject);
//        
//    } failure:^(NSURLSessionDataTask *task, NSError *error) {
//        failure(error);
//
//    }];
    
    [manager.requestSerializer setValue:@"application/json"
                     forHTTPHeaderField:@"Content-Type"];
    NSString *url = [NSString stringWithFormat:@"%@%@",HTTPUrl,URLString];
    [manager GET:url parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
         success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        falure(error);
    }];
    
    
}

#pragma mark -- POST请求 --
+ (void)postWithURLString:(NSString *)URLString
               parameters:(id)parameters
              WithSuccess:(void (^)(id result))success
                     With:(void (^)(NSError *error))falure {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer.timeoutInterval = 10;
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json", @"text/plain", @"text/html", nil];
    
    [manager.requestSerializer setValue:@"application/json"
                     forHTTPHeaderField:@"Content-Type"];
    NSLog(@"%@%@",URLString,parameters);
     NSString *url = [NSString stringWithFormat:@"%@%@",HTTPUrl,URLString];
    [manager POST:url parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
         success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
         falure(error);
    }];
//    [manager POST:URLString parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
//
//        success(responseObject);
//
//    } failure:^(NSURLSessionDataTask *task, NSError *error) {
//        failure(error);
//
//    }];
}
// 上传多张图片
+ (void)uploadMostImageWithURLString:(NSString *)URLString
                          parameters:(id)parameters
                         uploadDatas:(NSArray *)uploadDatas
                          uploadName:(NSString *)uploadName
                         WithSuccess:(void (^)(id result))success
                                With:(void (^)(NSError *error))falure{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json", @"text/plain", @"text/html", nil];
    manager.responseSerializer = [AFJSONResponseSerializer new];
//    NSString *url = [NSString stringWithFormat:@"%@%@",HTTPUrl,URLString];
    [manager POST:URLString parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        for (int i = 0; i < uploadDatas.count; i++) {
            UIImage *image = uploadDatas[i];
            NSData *imageData = UIImageJPEGRepresentation(image, 0.5);
            
            // 在网络开发中，上传文件时，是文件不允许被覆盖，文件重名
            // 要解决此问题，
            // 可以在上传时使用当前的系统事件作为文件名
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            // 设置时间格式
            [formatter setDateFormat:@"yyyyMMddHHmmss"];
            
            NSString *dateString = [formatter stringFromDate:[NSDate date]];
            dateString = [NSString stringWithFormat:@"%@", dateString];
            NSString *fileName = [NSString  stringWithFormat:@"%@.jpg", dateString];
            NSLog(@"图片名字========%@",fileName);
            /*
             *该方法的参数
             1. appendPartWithFileData：要上传的照片[二进制流]
             2. name：对应网站上[upload.php中]处理文件的字段（比如upload）
             3. fileName：要保存在服务器上的文件名
             4. mimeType：上传的文件的类型
             */
            [formData appendPartWithFileData:imageData name:@"file" fileName:fileName mimeType:@"image/png/jpg/jpeg"]; //
            
        }
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
         falure(error);
    }];
//    [manager POST:URLString parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
//        for (int i = 0; i < uploadDatas.count; i++) {
//            UIImage *image = uploadDatas[i];
//            NSData *imageData = UIImageJPEGRepresentation(image, 0.5);
//
//            // 在网络开发中，上传文件时，是文件不允许被覆盖，文件重名
//            // 要解决此问题，
//            // 可以在上传时使用当前的系统事件作为文件名
//            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//            // 设置时间格式
//            [formatter setDateFormat:@"yyyyMMddHHmmss"];
//
//            NSString *dateString = [formatter stringFromDate:[NSDate date]];
//            dateString = [NSString stringWithFormat:@"%@", dateString];
//            NSString *fileName = [NSString  stringWithFormat:@"%@.jpg", dateString];
//            NSLog(@"图片名字========%@",fileName);
//            /*
//             *该方法的参数
//             1. appendPartWithFileData：要上传的照片[二进制流]
//             2. name：对应网站上[upload.php中]处理文件的字段（比如upload）
//             3. fileName：要保存在服务器上的文件名
//             4. mimeType：上传的文件的类型
//             */
//            [formData appendPartWithFileData:imageData name:@"file" fileName:fileName mimeType:@"image/png/jpg/jpeg"]; //
//
//        }
//    }success:^(NSURLSessionDataTask *task, id responseObject) {
//        success(responseObject);
//
//    } failure:^(NSURLSessionDataTask *task, NSError *error) {
//        failure(error);
//
//    }];
    
    
}

+ (void)uploadWithURLString:(NSString *)URLString
                 parameters:(id)parameters
                 uploadData:(NSData *)uploadData
                 uploadName:(NSString *)uploadName
                    WithSuccess:(void (^)(id result))success
                       With:(void (^)(NSError *error))falure {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json", @"text/plain", @"text/html", nil];
    NSString *url = [NSString stringWithFormat:@"%@%@",HTTPUrl,URLString];
    [manager POST:url parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        // 设置时间格式
        [formatter setDateFormat:@"yyyyMMddHHmmss"];
        
        NSString *dateString = [formatter stringFromDate:[NSDate date]];
        dateString = [NSString stringWithFormat:@"yyyyMMddHHmmss"];
        NSString *fileName = [NSString  stringWithFormat:@"%@.jpg", dateString];
        [formData appendPartWithFileData:uploadData name:@"file" fileName:fileName mimeType:@"image/png"];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
         falure(error);
    }];
    
//    [manager POST:URLString parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
//        // 可以在上传时使用当前的系统事件作为文件名
//        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//        // 设置时间格式
//        [formatter setDateFormat:@"yyyyMMddHHmmss"];
//
//        NSString *dateString = [formatter stringFromDate:[NSDate date]];
//        dateString = [NSString stringWithFormat:@"yyyyMMddHHmmss"];
//        NSString *fileName = [NSString  stringWithFormat:@"%@.jpg", dateString];
//        [formData appendPartWithFileData:uploadData name:@"file" fileName:fileName mimeType:@"image/png"];
//    } success:^(NSURLSessionDataTask *task, id responseObject) {
//          success(responseObject);
//
//    } failure:^(NSURLSessionDataTask *task, NSError *error) {
//       falure(error);
//    }];

}



@end
