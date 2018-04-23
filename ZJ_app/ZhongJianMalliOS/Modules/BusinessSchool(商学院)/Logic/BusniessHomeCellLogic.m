//
//  BusniessHomeCellLogic.m
//  ZhongJianMalliOS
//
//  Created by mac_fj on 2018/4/9.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "BusniessHomeCellLogic.h"
#import "BusniessHomeCellApi.h"
#import "BusniessHomeCellModel.h"

@implementation BusniessHomeCellLogic

- (void)requestBusniessHomecellDataWithType:(NSInteger)type page:(NSInteger)page pageNum:(NSInteger)pageNum {
    
    BusniessHomeCellApi *api = [[BusniessHomeCellApi alloc] initWithType:type page:page pageNum:pageNum];
    [api startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        
        BusniessHomeCellApi *api = (BusniessHomeCellApi *)request;
        
        NSMutableArray *dataArr = [NSMutableArray array];
        NSArray *bodyData = api.result[@"data"];
        for (NSDictionary *dic in bodyData) {
            BusniessHomeCellModel *model = [BusniessHomeCellModel busniesshomemodelWithDictionary:dic];
            [dataArr addObject:model];
        } 
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(requestBusniessHomecellDataCompleted:)]) {
            [self.delegate requestBusniessHomecellDataCompleted:dataArr];
        }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        
    }];
}

@end
