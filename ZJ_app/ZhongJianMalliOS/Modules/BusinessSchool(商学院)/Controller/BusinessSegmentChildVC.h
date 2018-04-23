//
//  BusinessSegmentChildVC.h
//  ZhongJianMalliOS
//
//  Created by mac_fj on 2018/4/9.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "RootViewController.h"
#import "ZJScrollPageViewDelegate.h"

@interface BusinessSegmentChildVC : RootViewController <ZJScrollPageViewChildVcDelegate>

@property (nonatomic, assign) NSInteger type;

@property (nonatomic, assign) CGRect frame;

@end
