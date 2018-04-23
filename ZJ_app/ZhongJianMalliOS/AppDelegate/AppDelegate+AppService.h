//
//  AppDelegate+AppService.h
//  ZhongJianMalliOS
//
//  Created by mac_fj on 2018/3/31.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate (AppService)

//初始化服务
- (void)initService;

//初始化 window
- (void)initWindow;

//初始化网络配置
- (void)netWorkConfig;

//单例
+ (AppDelegate *)shareAppDelegate;

//获取当前顶层控制器
- (UIViewController *)getCurrentVC;
- (UIViewController *)getCurrentUIVC;

@end
