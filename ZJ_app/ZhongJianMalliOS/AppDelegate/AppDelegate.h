//
//  AppDelegate.h
//  ZhongJianMalliOS
//
//  Created by 段 on 2017/10/31.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainTabBarController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic, strong) MainTabBarController *mainTabBar;

@end

