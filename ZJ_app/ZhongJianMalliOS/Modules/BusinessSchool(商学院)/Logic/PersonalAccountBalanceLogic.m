//
//  PersonalAccountBalanceLogic.m
//  ZhongJianMalliOS
//
//  Created by mac_fj on 2018/4/13.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "PersonalAccountBalanceLogic.h"
#import "PersonalAccountBalanceApi.h"
#import "ZJPersonalInfoModel.h"

@implementation PersonalAccountBalanceLogic

- (void)getPersonalAccountBalance {
    
    PersonalAccountBalanceApi *api = [[PersonalAccountBalanceApi alloc] init];
    [api startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
       
        PersonalAccountBalanceApi *requestApi = (PersonalAccountBalanceApi *)request;
        
        if ([requestApi.error_code isEqualToString:@"3"]) {
            if (self.delegate && [self.delegate respondsToSelector:@selector(getPersonalAccountCompletedWithErrorMessage:)]) {
                [self.delegate getPersonalAccountCompletedWithErrorMessage:requestApi.error_message];
            }
        } else if ([requestApi.error_code isEqualToString:@"0"]) {
        
        NSDictionary *dic = requestApi.result[@"data"][@"personDataMap"];
        ZJPersonalInfoModel *model = [ZJPersonalInfoModel mj_objectWithKeyValues:dic];
        
        NSString *elecNum = model.RemainElecNum;
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(getPersonalAccountBalanceCompletedWithRemainElecNum:)]) {
            [self.delegate getPersonalAccountBalanceCompletedWithRemainElecNum:elecNum];
        }
        }
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        
    }];
}

@end
