//
//  BDIntroductionMainModel.h
//  ZhongJianMalliOS
//
//  Created by mac_fj on 2018/4/11.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Course : NSObject

@property (nonatomic, copy) NSString *coursestarttime;
@property (nonatomic, copy) NSString *coursesite;
@property (nonatomic, copy) NSString *coursebrief;

@end

@interface CourseList : NSObject

@property (nonatomic, copy) NSString *src;
@property (nonatomic, copy) NSString *title;

@end

@interface BDIntroductionMainModel : NSObject

@property (nonatomic, strong) Course *course;
@property (nonatomic, strong) NSArray *coursedatalist;

@end
