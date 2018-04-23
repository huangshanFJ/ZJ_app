//
//  BusinessSignUpViewController.h
//  ZhongJianMalliOS
//
//  Created by mac_fj on 2018/4/13.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "RootViewController.h"

@class BusniessDetailMainModel;
@interface BusinessSignUpViewController : RootViewController

@property (nonatomic, strong) BusniessDetailMainModel *model;

@property (nonatomic, copy) NSString *elecNum;

//- (void)setViewDataWith:(BusniessDetailMainModel *)model;

@end
