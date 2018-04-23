//
//  CommonMacros.h
//  ZhongJianMalliOS
//
//  Created by mac_fj on 2018/3/31.
//  Copyright © 2018年 apple. All rights reserved.
//

#ifndef CommonMacros_h
#define CommonMacros_h

#pragma mark ============ 用户相关 ============
//登录状态改变通知
#define kNotificaationLoginStateChange @"loginStateChange"

//被踢下线
#define kNotificationOnKick @"kNotificationOnKick"

//网络状态变化
#define kNotificationNetworkStateChange @"kNotificationNetworkStateChange"


#pragma mark ============ 基础地址 ============
//#define HTTPUrl  @"http://192.168.1.70"//测试地址
//#define HTTPUrl @"http://192.168.1.245:8080"//抓包地址
#define HTTPUrl @"https://appnew.zhongjianmall.com"//正式地址

#endif /* CommonMacros_h */
