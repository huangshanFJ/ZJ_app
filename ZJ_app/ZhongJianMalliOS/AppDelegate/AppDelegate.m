//
//  AppDelegate.m
//  ZhongJianMalliOS
//
//  Created by 段 on 2017/10/31.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "AppDelegate.h"
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKConnector/ShareSDKConnector.h>

//腾讯开放平台（对应QQ和QQ空间）SDK头文件
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/QQApiInterface.h>

//微信SDK头文件
#import "WXApi.h"

#import "iVersion.h"



// 如果需要使用idfa功能所需要引入的头文件（可选）
#import <AdSupport/AdSupport.h>
@interface AppDelegate ()<JPUSHRegisterDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
//    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
//    
//    self.window.rootViewController = [[DXTabBarViewController alloc] init];
//    
//    [self.window makeKeyAndVisible];
    
    
    //初始化窗口
    [self initWindow];
    //初始化网络服务
    [self netWorkConfig];
    
    /**初始化ShareSDK应用
     
     @param activePlatforms
     
     使用的分享平台集合
     
     @param importHandler (onImport)
     
     导入回调处理，当某个平台的功能需要依赖原平台提供的SDK支持时，需要在此方法中对原平台SDK进行导入操作
     
     @param configurationHandler (onConfiguration)
     
     配置回调处理，在此方法中根据设置的platformType来填充应用配置信息
     
     */
    
    [ShareSDK registerActivePlatforms:@[
                                        @(SSDKPlatformTypeWechat),
                                        @(SSDKPlatformTypeQQ)
                                        ]
                             onImport:^(SSDKPlatformType platformType)
     {
         switch (platformType)
         {
             case SSDKPlatformTypeWechat:
                 [ShareSDKConnector connectWeChat:[WXApi class]];
                 break;
             case SSDKPlatformTypeQQ:
                 [ShareSDKConnector connectQQ:[QQApiInterface class] tencentOAuthClass:[TencentOAuth class]];
                 break;
 
             default:
                 break;
         }
     }
                      onConfiguration:^(SSDKPlatformType platformType, NSMutableDictionary *appInfo)
     {
         
         switch (platformType)
         {
 
             case SSDKPlatformTypeWechat:
                 [appInfo SSDKSetupWeChatByAppId:@"wxf7999a70965260ef"
                                       appSecret:@"731f4a4e0a1671e9007316e9e9a80583"];
                 break;
             case SSDKPlatformTypeQQ:
                 [appInfo SSDKSetupQQByAppId:@"1106729276"
                                      appKey:@"t7t5s9BbdEluelT9"
                                    authType:SSDKAuthTypeBoth];
                 break;
// 
//                 break;
             default:
                 break;
         }
     }];
    //Required
    //notice: 3.0.0及以后版本注册可以这样写，也可以继续用之前的注册方式
//    JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
//    entity.types = JPAuthorizationOptionAlert|JPAuthorizationOptionBadge|JPAuthorizationOptionSound;
//    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
//        // 可以添加自定义categories
//        // NSSet<UNNotificationCategory *> *categories for iOS10 or later
//        // NSSet<UIUserNotificationCategory *> *categories for iOS8 and iOS9
//    }
//    [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
//    // Optional
//    // 获取IDFA
//    // 如需使用IDFA功能请添加此代码并在初始化方法的advertisingIdentifier参数中填写对应值
//    NSString *advertisingId = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
//
//    // Required
//    // init Push
//    // notice: 2.1.5版本的SDK新增的注册方法，改成可上报IDFA，如果没有使用IDFA直接传nil
//    // 如需继续使用pushConfig.plist文件声明appKey等配置内容，请依旧使用[JPUSHService setupWithOption:launchOptions]方式初始化。
//    [JPUSHService setupWithOption:launchOptions appKey:@"eb052fb348b318ff664351b6"
//                          channel:@"ad-hoc"
//                 apsForProduction:NO
//            advertisingIdentifier:advertisingId];
    if ([application respondsToSelector:@selector(registerUserNotificationSettings:)]){
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge|UIUserNotificationTypeSound|UIUserNotificationTypeAlert categories:nil];
        [application registerUserNotificationSettings:settings];
    }
   
    // 2.注册极光推送
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 10.0) {
        JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
        if (@available(iOS 10.0, *)) {
            entity.types = UNAuthorizationOptionAlert|UNAuthorizationOptionBadge|UNAuthorizationOptionSound;
        } else {
            // Fallback on earlier versions
        }
        [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
    }else if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        //可以添加自定义categories
        [JPUSHService registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge |
                                                          UIUserNotificationTypeSound |
                                                          UIUserNotificationTypeAlert)
                                              categories:nil];
    }
    [JPUSHService setupWithOption:launchOptions appKey:JPushAppKey
                          channel:@"ad-hoc"
                 apsForProduction:JPushState
            advertisingIdentifier:nil];

    // 接收应用内消息
    NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
    [defaultCenter addObserver:self selector:@selector(networkDidReceiveMessage:) name:kJPFNetworkDidReceiveMessageNotification object:nil];
    //设置红色角标
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    [JPUSHService setBadge:0];
//     [self jpushInitWith:launchOptions];
    
    
    //更新提示
//    [iVersion sharedInstance].applicationBundleID = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"];
//    [iVersion sharedInstance].updatePriority = iVersionUpdatePriorityMedium;
    
    return YES;
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    if ([url.host isEqualToString:@"safepay"]) {
        // 支付跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@",resultDic);
        }];
        
        // 授权跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processAuth_V2Result:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@",resultDic);
            // 解析 auth code
            NSString *result = resultDic[@"result"];
            NSString *authCode = nil;
            if (result.length>0) {
                NSArray *resultArr = [result componentsSeparatedByString:@"&"];
                for (NSString *subResult in resultArr) {
                    if (subResult.length > 10 && [subResult hasPrefix:@"auth_code="]) {
                        authCode = [subResult substringFromIndex:10];
                        break;
                    }
                }
            }
            NSLog(@"授权结果 authCode = %@", authCode?:@"");
        }];
    }
    return YES;
}
//- (void)jpushInitWith:(NSDictionary*)launchOptions
//{
//    JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
//    entity.types = JPAuthorizationOptionAlert|JPAuthorizationOptionBadge|JPAuthorizationOptionSound;
//    [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
//    //生成idfa 字段
//    NSString *advertisingId=[SimulateIDFA createSimulateIDFA];
//    DDLog(@"----ifda----%@",advertisingId);
//    if (advertisingId) {
//        [[NSUserDefaults standardUserDefaults] setObject:advertisingId forKey:@"advertisingId"];
//    }
//    NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
//    [defaultCenter addObserver:self selector:@selector(networkDidReceiveMessage:) name:kJPFNetworkDidReceiveMessageNotification object:nil];
//    [defaultCenter addObserver:self selector:@selector(networkDidLogin:) name:kJPFNetworkDidLoginNotification object:nil];
//    [JPUSHService setupWithOption:launchOptions appKey:appKey
//                          channel:channel
//                 apsForProduction:isProduction
//            advertisingIdentifier:advertisingId];
//
//
//}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    
    /// Required - 注册 DeviceToken
    [JPUSHService registerDeviceToken:deviceToken];
}


#pragma mark - JPUSHRegisterDelegate
// iOS 10 Support，前台收到通知，后台不会执行这个方法
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler {
    // Required
    NSDictionary * userInfo = notification.request.content.userInfo;
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
    }
    completionHandler(UNNotificationPresentationOptionAlert); // 需要执行这个方法，选择是否提醒用户，有Badge、Sound、Alert三种类型可以选择设置
    // 通知内容为：notification.request.content.body
}

// iOS 10 Support，用户点击了通知进入app
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler {
    // Required
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
    }
    completionHandler();  // 系统要求执行这个方法
}
#pragma mark 解析极光推送的应用内消息
- (void)networkDidReceiveMessage:(NSNotification *)notification {
    NSDictionary * userInfo = [notification userInfo];
    NSLog(@"解析极光推送的应用内消息：%@",userInfo);
//    NSString *show = [NSString stringWithFormat:@"%@",userInfo[@"content"]];
//    UIAlertController *alert = [UIAlertController alertControllerWithTitle:show message:nil preferredStyle:UIAlertControllerStyleAlert];
//    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil]];
//
//    UIWindow *alertWindow = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
//
//    alertWindow.rootViewController = [[DXTabBarViewController alloc] init];
//
//    alertWindow.windowLevel = UIWindowLevelAlert + 1;
//
//    [alertWindow makeKeyAndVisible];
//    //显示弹出框
//    [alertWindow.rootViewController presentViewController:alert animated:YES completion:nil];
}

// 接收到远程通知之后
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    
    // Required,For systems with less than or equal to iOS6
    [JPUSHService handleRemoteNotification:userInfo];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    
    // IOS 7 Support Required
    [JPUSHService handleRemoteNotification:userInfo];
    completionHandler(UIBackgroundFetchResultNewData);
}
//获取 deviceToken 失败后 远程推送（极光推送）打开失败
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    //Optional
    NSLog(@"获取 device token 失败 %@", error);
}


@end
