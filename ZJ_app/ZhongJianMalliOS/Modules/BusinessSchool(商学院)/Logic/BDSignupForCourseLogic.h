//
//  BDSignupForCourseLogic.h
//  ZhongJianMalliOS
//
//  Created by mac_fj on 2018/4/13.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol BDSignupForCourseLogicDelegate <NSObject>
@optional
- (void)requetSignupForCourseCompletedWithType:(NSString *)type info:(NSString *)info;
- (void)signupForCourseCompletedWithErrormessage:(NSString *)message;
- (void)syncHandleOrderccCompleted:(NSString *)message;
@end

@interface BDSignupForCourseLogic : NSObject

@property (nonatomic, weak) id<BDSignupForCourseLogicDelegate> delegate;
- (void)requetSignupForCourseWithCourseid:(NSString *)courseid elecnum:(NSString *)elecnum realpay:(NSString *)realpay;

- (void)syncHandleOrderccWithOrderNo:(NSString *)orderNo;

@end
