//
//  BusniessDetailMainLogic.m
//  ZhongJianMalliOS
//
//  Created by mac_fj on 2018/4/10.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "BusniessDetailMainLogic.h"
#import "BusniessDetailMainApi.h"
#import "BusniessDatailIsSignApi.h"

#import "BusniessDetailMainModel.h"

@interface BusniessDetailMainLogic () 

@property (nonatomic, strong) BusniessDetailMainModel *mainModel;
@property (nonatomic, assign) BOOL isSign;

@end

@implementation BusniessDetailMainLogic

- (void)requestDetailMainDataWithCourseId:(NSString *)courseid {
    
    BusniessDetailMainApi *api = [[BusniessDetailMainApi alloc] initWithCourseId:courseid];
    [api startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        
        BusniessDetailMainApi *mianReu = (BusniessDetailMainApi *)request;
        NSDictionary *dic = mianReu.result[@"data"];
        BusniessDetailMainModel *model = [BusniessDetailMainModel mj_objectWithKeyValues:dic];
        if (self.delegate && [self.delegate respondsToSelector:@selector(busniessDetailMainRequestCompleted:)]) {
            [self.delegate busniessDetailMainRequestCompleted:model];
        }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        
    }];
}

- (void)requestCourseIsSignUp:(NSString *)courseid {
    
    BusniessDatailIsSignApi *api = [[BusniessDatailIsSignApi alloc] initWithCourseid:courseid];
    [api startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        
        BusniessDatailIsSignApi *signupApi = (BusniessDatailIsSignApi *)request;
        NSString *str = [NSString stringWithFormat:@"%@",signupApi.result[@"data"]];
        BOOL isSignup = [str intValue];
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(busniessCouresIsSignup:)]) {
            [self.delegate busniessCouresIsSignup:isSignup];
        }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        //
    }];
}

@end
