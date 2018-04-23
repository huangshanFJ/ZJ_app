//
//  ZJSyncHandleVipOrderLogic.m
//  ZhongJianMalliOS
//
//  Created by mac_fj on 2018/4/4.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "ZJSyncHandleVipOrderLogic.h"
#import "SyncHandleVipOrderApi.h"

@implementation ZJSyncHandleVipOrderLogic

- (void)syncHanderVipOrderWith:(NSString *)orderNoc {
    
    SyncHandleVipOrderApi *api = [[SyncHandleVipOrderApi alloc] initWithOrderNoc:orderNoc];
    [api startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        
        SyncHandleVipOrderApi *api = (SyncHandleVipOrderApi *)request;
        if ([api.error_code intValue] == 0) {
            if (self.delegate && [self.delegate respondsToSelector:@selector(syncHandlerVipOrderComplete)]) {
                [self.delegate syncHandlerVipOrderComplete];
            }
        }
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        //
    }];
}

@end
