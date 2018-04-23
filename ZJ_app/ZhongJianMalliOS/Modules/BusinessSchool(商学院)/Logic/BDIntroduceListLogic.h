//
//  BDIntroduceListLogic.h
//  ZhongJianMalliOS
//
//  Created by mac_fj on 2018/4/12.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BDIntroduceListModel;

@protocol BDIntroduceListLogicDelegate <NSObject>
@optional
- (void)requestIntroduceListDataCompletedWithList:(BDIntroduceListModel *)model;

@end

@interface BDIntroduceListLogic : NSObject

@property (nonatomic, weak) id <BDIntroduceListLogicDelegate> delegate;

- (void)requestIntroduceListWithCourseid:(NSString *)courseif;

@end
