//
//  MyCourseDetailViewController.h
//  ZhongJianMalliOS
//
//  Created by mac_fj on 2018/4/12.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "RootViewController.h"
#import "ZJScrollPageViewDelegate.h"
#import "MyCourseDetailLogic.h"

@interface MyCourseDetailViewController : RootViewController <ZJScrollPageViewChildVcDelegate>

@property (nonatomic, assign) MyCoursesType type;

@end
