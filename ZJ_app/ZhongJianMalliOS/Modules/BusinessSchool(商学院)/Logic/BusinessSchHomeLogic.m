//
//  BusinessSchHomeLogic.m
//  ZhongJianMalliOS
//
//  Created by mac_fj on 2018/4/9.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "BusinessSchHomeLogic.h"
#import "BusSchoolHomeApi.h"
#import "BusinessHomeSegmentModel.h"

@implementation BusinessSchHomeLogic

- (void)requestBusinessSchHomepageData {
    BusSchoolHomeApi *api = [[BusSchoolHomeApi alloc] init];
    [api startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
       
        BusSchoolHomeApi *api = (BusSchoolHomeApi *)request;
        NSDictionary *bodyData = api.result[@"data"];
        NSArray *segments = bodyData[@"commercialCollegeCourse"];
        NSString *picUrl = bodyData[@"commercialCollegePic"];
        
        NSMutableArray *segArr = [NSMutableArray array];
        for (NSDictionary *dic in segments) {
            BusinessHomeSegmentModel *segmentModel = [BusinessHomeSegmentModel segmentModelWithDictionary:dic];
            [segArr addObject:segmentModel];
        }
        
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(requestBusinessSchHomepageDataCompletedSegment:picture:)]) {
            [self.delegate requestBusinessSchHomepageDataCompletedSegment:segArr picture:picUrl];
        }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        //
    }];
    
}

@end
