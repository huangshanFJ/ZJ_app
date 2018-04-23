//
//  BusniessDetailMainLogic.h
//  ZhongJianMalliOS
//
//  Created by mac_fj on 2018/4/10.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BusniessDetailMainModel;
@protocol BusniessDetailMainLogicDelegate <NSObject>
@optional
- (void)busniessDetailMainRequestCompleted:(BusniessDetailMainModel *)model;
- (void)busniessCouresIsSignup:(BOOL)isSignup;

@end

@interface BusniessDetailMainLogic : NSObject 

@property (nonatomic, weak) id <BusniessDetailMainLogicDelegate> delegate;

- (void)requestDetailMainDataWithCourseId:(NSString *)courseid;

- (void)requestCourseIsSignUp:(NSString *)courseid;

@end
