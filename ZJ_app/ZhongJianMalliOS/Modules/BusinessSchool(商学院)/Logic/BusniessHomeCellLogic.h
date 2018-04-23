//
//  BusniessHomeCellLogic.h
//  ZhongJianMalliOS
//
//  Created by mac_fj on 2018/4/9.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol BusniessHomeCellLogicDelegate <NSObject>
@optional
- (void)requestBusniessHomecellDataCompleted:(NSArray *)tableArr;
@end

@interface BusniessHomeCellLogic : NSObject

@property (nonatomic, weak) id <BusniessHomeCellLogicDelegate> delegate;

- (void)requestBusniessHomecellDataWithType:(NSInteger)type page:(NSInteger)page pageNum:(NSInteger)pageNum;

@end
