//
//  ZJHandleOrderCLogic.h
//  ZhongJianMalliOS
//
//  Created by mac_fj on 2018/3/31.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol HandleOrderCDelegate <NSObject>
@optional
- (void)handleOrderCCompleted;

@end

@interface ZJHandleOrderCLogic : NSObject

@property (nonatomic, weak) id <HandleOrderCDelegate> delegate;


- (void)handleOrderNoC:(NSString *)ordecNoC;

@end
