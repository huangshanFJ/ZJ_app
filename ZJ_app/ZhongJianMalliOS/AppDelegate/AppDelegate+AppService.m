//
//  AppDelegate+AppService.m
//  ZhongJianMalliOS
//
//  Created by mac_fj on 2018/3/31.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "AppDelegate+AppService.h"
#import <YTKNetwork.h>


@implementation AppDelegate (AppService)

#pragma mark ============ 初始化服务 ============
- (void)initService {
    
    //网络状态监听
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(networkStateChange:)
                                                 name:kNotificationNetworkStateChange
                                               object:nil];
    
    //注册登入状态监听
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(loginStateChange:)
                                                 name:kNotificaationLoginStateChange
                                               object:nil];
    
}

#pragma mark ============ 初始化window ============
- (void)initWindow {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    
    self.window.rootViewController = [[MainTabBarController alloc] init];
    
    [self.window makeKeyAndVisible];
    
    //响应事件排他性 ios8.0+
    [[UIButton appearance] setExclusiveTouch:YES];
    [UIActivityIndicatorView appearanceWhenContainedInInstancesOfClasses:@[[MBProgressHUD class]]].color = [UIColor whiteColor];
    if (@available(iOS 11.0, *)) {
        [[UIScrollView appearance] setContentInsetAdjustmentBehavior:UIScrollViewContentInsetAdjustmentNever];
    }
}

#pragma mark ============ 初始化网络配置 ============
- (void)netWorkConfig {
    YTKNetworkConfig *config = [YTKNetworkConfig sharedConfig];
    config.baseUrl = HTTPUrl;
    
//    //服务端返回格式问题，后端返回的结果不是"application/json"，afn 的 jsonResponseSerializer 是不认的。这里做临时处理
    YTKNetworkAgent *agent = [YTKNetworkAgent sharedAgent];
    [agent setValue:[NSSet setWithObjects:@"application/json", @"text/plain", @"text/javascript", @"text/json",@"text/html", nil]
         forKeyPath:@"jsonResponseSerializer.acceptableContentTypes"];
    
}

//单例
+ (AppDelegate *)shareAppDelegate {
    return (AppDelegate *)[[UIApplication sharedApplication] delegate];
}

#pragma mark ============ 网络状态变化 ============
- (void)networkStateChange:(NSNotification *)notification {
    BOOL isNetwork = [notification.object boolValue];
   /*
    if (isNetWork) {//有网络
        if ([userManager loadUserInfo] && !isLogin) {//有用户数据 并且 未登录成功 重新来一次自动登录
            [userManager autoLoginToServer:^(BOOL success, NSString *des) {
                if (success) {
                    DLog(@"网络改变后，自动登录成功");
                    //                    [MBProgressHUD showSuccessMessage:@"网络改变后，自动登录成功"];
                    KPostNotification(KNotificationAutoLoginSuccess, nil);
                }else{
                    [MBProgressHUD showErrorMessage:NSStringFormat(@"自动登录失败：%@",des)];
                }
            }];
        }
        
    }else {//登陆失败加载登陆页面控制器
        [MBProgressHUD showTopTipMessage:@"网络状态不佳" isWindow:YES];
    }
    */
}

#pragma mark ============ 登陆状态监听 ============
- (void)loginStateChange:(NSNotification *)notification {
    
}


#pragma mark ============ 获取当前控制器 ============
- (UIViewController *)getCurrentVC {
    
    UIViewController *vc = nil;
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    if (window.windowLevel != UIWindowLevelNormal) {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for (UIWindow *tmpWin in windows) {
            if (tmpWin.windowLevel == UIWindowLevelNormal) {
                window = tmpWin;
                break;
            }
        }
    }
    
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    
    if ([nextResponder isKindOfClass:[UIViewController class]]) {
        vc = nextResponder;
    } else {
        vc = window.rootViewController;
        
    }
    return vc;
}

- (UIViewController *)getCurrentUIVC {
    UIViewController *superVc = [self getCurrentVC];
    if ([superVc isKindOfClass:[UITabBarController class]]) {
        UIViewController *tabSelectVC = ((UITabBarController *)superVc).selectedViewController;
        if ([tabSelectVC isKindOfClass:[UINavigationController class]]) {
            return ((UINavigationController *)tabSelectVC).viewControllers.lastObject;
        }
        return tabSelectVC;
    } else  if([superVc isKindOfClass:[UINavigationController class]]) {
            return ((UINavigationController *)superVc).viewControllers.lastObject;
        }
        return superVc;
}

@end
