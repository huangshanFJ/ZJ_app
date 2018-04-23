//
//  MyCourseDetailLogic.m
//  ZhongJianMalliOS
//
//  Created by mac_fj on 2018/4/12.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "MyCourseDetailLogic.h"
#import "MyCouresDetailApi.h"
#import "MyCourseDetailCellModel.h"

@interface MyCourseDetailLogic ()
{
    NSString *_type;
}
@end

@implementation MyCourseDetailLogic

- (void)requestMyCourseDatailWithType:(MyCoursesType)type page:(NSInteger)page pageNum:(NSInteger)pageNum {
    
    switch (type) {
        case MyCoursesTypeALL:
            _type = @"all";
            break;
        case MyCoursesTypeWait:
            _type = @"wait";
            break;
        case MyCoursesTypeStart:
            _type = @"start";
            break;
        case MyCoursesTypeOver:
            _type = @"over";
            break;
    }
    
    MyCouresDetailApi *api = [[MyCouresDetailApi alloc] initWithType:_type page:page pageNum:pageNum];
    [api startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        MyCouresDetailApi *requestApi = (MyCouresDetailApi *)request;
        NSDictionary *dic = requestApi.result;
        MyCourseModels *model = [MyCourseModels mj_objectWithKeyValues:dic];
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(requestMyCourseDatailCompletedWithCourseModels:)]) {
            [self.delegate requestMyCourseDatailCompletedWithCourseModels:model];
        }
        
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        
    }];
    
}

@end
