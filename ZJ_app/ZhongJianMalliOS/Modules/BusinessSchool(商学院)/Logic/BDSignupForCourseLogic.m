//
//  BDSignupForCourseLogic.m
//  ZhongJianMalliOS
//
//  Created by mac_fj on 2018/4/13.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "BDSignupForCourseLogic.h"
#import "SignupForCourseApi.h"
#import "SynchandleOrderccApi.h"

@implementation BDSignupForCourseLogic

- (void)requetSignupForCourseWithCourseid:(NSString *)courseid elecnum:(NSString *)elecnum realpay:(NSString *)realpay {
    
    SignupForCourseApi *api = [[SignupForCourseApi alloc] initWithCourseid:courseid elecnum:elecnum realpay:realpay];
    [api startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
       
        SignupForCourseApi *requestApi = (SignupForCourseApi *)request;
        if ([requestApi.error_code isEqualToString:@"0"]) {
            NSDictionary *dic = requestApi.result[@"data"];
            NSString *type = dic[@"type"];
            NSString *info = dic[@"info"];
            if (self.delegate && [self.delegate respondsToSelector:@selector(requetSignupForCourseCompletedWithType:info:)]) {
                [self.delegate requetSignupForCourseCompletedWithType:type info:info];
            }
        } else if ([requestApi.error_code isEqualToString:@"1"]) {
            //提示课程已经报名
            NSString *message = requestApi.error_message;
            if (self.delegate && [self.delegate respondsToSelector:@selector(signupForCourseCompletedWithErrormessage:)]) {
                [self.delegate signupForCourseCompletedWithErrormessage:message];
            }
        } else {
            //暂不做处理
        }
      
        
        
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        
    }];
    
}

- (void)syncHandleOrderccWithOrderNo:(NSString *)orderNo {
    
    SynchandleOrderccApi *api = [[SynchandleOrderccApi alloc] initWithOrderNo:orderNo];
    [api startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        
        SynchandleOrderccApi *requestApi = (SynchandleOrderccApi *)request;
        NSString *message = requestApi.error_message;
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(syncHandleOrderccCompleted:)]) {
            [self.delegate syncHandleOrderccCompleted:message];
        }
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        
    }];
}

@end
