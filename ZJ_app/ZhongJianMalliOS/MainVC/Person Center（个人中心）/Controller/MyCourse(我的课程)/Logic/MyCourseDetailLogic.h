//
//  MyCourseDetailLogic.h
//  ZhongJianMalliOS
//
//  Created by mac_fj on 2018/4/12.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MyCourseModels;
typedef NS_ENUM(NSUInteger, MyCoursesType) {
    MyCoursesTypeALL,
    MyCoursesTypeWait,
    MyCoursesTypeStart,
    MyCoursesTypeOver,
};

@protocol MyCourseDetailLogicDelegate <NSObject>
@optional
- (void)requestMyCourseDatailCompletedWithCourseModels:(MyCourseModels *)models;

@end

@interface MyCourseDetailLogic : NSObject

@property (nonatomic, weak) id <MyCourseDetailLogicDelegate> delegate;

- (void)requestMyCourseDatailWithType:(MyCoursesType)type page:(NSInteger)page pageNum:(NSInteger)pageNum;

@end
