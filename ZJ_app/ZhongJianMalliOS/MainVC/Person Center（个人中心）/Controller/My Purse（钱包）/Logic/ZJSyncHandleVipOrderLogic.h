//
//  ZJSyncHandleVipOrderLogic.h
//  ZhongJianMalliOS
//
//  Created by mac_fj on 2018/4/4.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SyncHandleVipOrderVipLogicDelegate <NSObject>
@optional
- (void)syncHandlerVipOrderComplete;
@end


@interface ZJSyncHandleVipOrderLogic : NSObject

@property (nonatomic, weak) id <SyncHandleVipOrderVipLogicDelegate> delegate;

- (void)syncHanderVipOrderWith:(NSString *)orderNoc;

@end
