//
//  CDIntroductionMainLogic.m
//  ZhongJianMalliOS
//
//  Created by mac_fj on 2018/4/11.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "CDIntroductionMainLogic.h"
#import "CDIntroductionMainApi.h"

#import "BDIntroductionMainModel.h"

@interface CDIntroductionMainLogic ()
{
    NSString *_courseid;
}
@end

@implementation CDIntroductionMainLogic

- (void)requestIntroductionMainDataWithCourseid:(NSString *)couresid {
    
//    NSString *courid = [NSString stringWithFormat:@"%@",couresid];
    
    CDIntroductionMainApi *api = [[CDIntroductionMainApi alloc] initWithCourseid:couresid];
    [api startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        
        CDIntroductionMainApi *mainApi = (CDIntroductionMainApi *)request;
        NSDictionary *dic = mainApi.result[@"data"];
        BDIntroductionMainModel *model = [BDIntroductionMainModel mj_objectWithKeyValues:dic];
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(requestIntroductionMainDataCompleted:)]) {
            [self.delegate requestIntroductionMainDataCompleted:model];
        }
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        //
    }];
    
}

@end
