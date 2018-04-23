
//
//  BDIntroduceListLogic.m
//  ZhongJianMalliOS
//
//  Created by mac_fj on 2018/4/12.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "BDIntroduceListLogic.h"
#import "BDIntroduceListApi.h"
#import "BDIntroduceListModel.h"

@implementation BDIntroduceListLogic

- (void)requestIntroduceListWithCourseid:(NSString *)courseif {
    
    BDIntroduceListApi *api = [[BDIntroduceListApi alloc] initWithCourseid:courseif];
    [api startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        
        BDIntroduceListApi *requestApi = (BDIntroduceListApi *)request;
        NSDictionary *dic = requestApi.result;
        BDIntroduceListModel *model = [BDIntroduceListModel mj_objectWithKeyValues:dic];
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(requestIntroduceListDataCompletedWithList:)]) {
            [self.delegate requestIntroduceListDataCompletedWithList:model];
        }
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        
    }];
    
}

@end
