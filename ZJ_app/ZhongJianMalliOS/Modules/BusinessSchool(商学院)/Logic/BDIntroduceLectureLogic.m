//
//  BDIntroduceLectureLogic.m
//  ZhongJianMalliOS
//
//  Created by mac_fj on 2018/4/12.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "BDIntroduceLectureLogic.h"
#import "BDIntroduceLectureApi.h"
#import "BDIntroduceLectureModel.h"

@implementation BDIntroduceLectureLogic

- (void)requsetIntroduceLectureDataWithCourseid:(NSString *)courseid {
    
    BDIntroduceLectureApi *api = [[BDIntroduceLectureApi alloc] initWithCourseId:courseid];
    [api startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        
        BDIntroduceLectureApi *requestApi = (BDIntroduceLectureApi *)request;
        NSDictionary *dic = requestApi.result;
        BDIntroduceLectureModel *model = [BDIntroduceLectureModel mj_objectWithKeyValues:dic];
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(requsetIntroduceLectureDataCompletedWithLecture:)]) {
            [self.delegate requsetIntroduceLectureDataCompletedWithLecture:model];
        }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        //
    }];
}

@end
