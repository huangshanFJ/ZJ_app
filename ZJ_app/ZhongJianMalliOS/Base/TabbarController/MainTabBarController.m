//
//  MainTabBarController.m
//  MiAiApp
//
//  Created by 徐阳 on 2017/5/18.
//  Copyright © 2017年 徐阳. All rights reserved.
//

#import "MainTabBarController.h"

#import "RootNavigationController.h"
#import "HomeViewController.h"
#import "ClassViewController.h"
#import "ShopCarViewController.h"
#import "PersonCenterViewController.h"

#import "UITabBar+CustomBadge.h"
#import "XYTabBar.h"

@interface MainTabBarController ()<UITabBarControllerDelegate>

@property (nonatomic,strong) NSMutableArray * VCS;//tabbar root VC

@end

@implementation MainTabBarController


/*
 @[
 @{MallClassKey  : @"HomeViewController",
 MallTitleKey  : @"首页",
 MallImgKey    : @"home_gray",//@"2拷贝",
 MallSelImgKey : @"home_blue"//@"2拷贝"
 },
 
 @{MallClassKey  : @"ClassViewController",
 MallTitleKey  : @"分类",
 MallImgKey    : @"classification",//@"0拷贝",
 MallSelImgKey : @"classification_blue"//@"0拷贝"
 },
 
 //                            @{MallClassKey  : @"NOHaveViewController",//@"HealthViewController",
 //                              MallTitleKey  : @"健康圈",
 //                              MallImgKey    : @"healthy",//@"大吉拷贝",
 //                              MallSelImgKey : @"health_blue"//@"大吉拷贝"
 //                              },
 
 @{MallClassKey  : @"ShopCarViewController",//@"NOHaveViewController",//@"ShopCarViewController",
 MallTitleKey  : @"购物车",
 MallImgKey    : @"shoppingCart_gray",//@"1拷贝",
 MallSelImgKey : @"shoppingCart_blue"//@"1拷贝"//
 },
 
 @{MallClassKey  : @"PersonCenterViewController",
 MallTitleKey  : @"个人中心",
 MallImgKey    : @"my_gray",//@"8拷贝",
 MallSelImgKey : @"my_blue"//@"8拷贝"
 },
 
 ];
 */


- (void)viewDidLoad {
    [super viewDidLoad];
    self.delegate = self;
    //初始化tabbar
    [self setUpTabBar];
    //添加子控制器
    [self setUpAllChildViewController];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}


#pragma mark ————— 初始化TabBar —————
-(void)setUpTabBar{
    //设置背景色 去掉分割线
    [self setValue:[XYTabBar new] forKey:@"tabBar"];
    [self.tabBar setBackgroundColor:[UIColor whiteColor]];
    [self.tabBar setBackgroundImage:[UIImage new]];
    //通过这两个参数来调整badge位置
    //    [self.tabBar setTabIconWidth:29];
    //    [self.tabBar setBadgeTop:9];
}

#pragma mark - ——————— 初始化VC ————————
-(void)setUpAllChildViewController{
    _VCS = @[].mutableCopy;
    
    HomeViewController *homeVC = [[HomeViewController alloc]init];
    [self setupChildViewController:homeVC title:@"首页" imageName:@"home_gray" seleceImageName:@"home_blue"];
    
    ClassViewController *clasVC = [[ClassViewController alloc]init];
    [self setupChildViewController:clasVC title:@"分类" imageName:@"classification" seleceImageName:@"classification_blue"];
    
    ShopCarViewController *shopVC = [[ShopCarViewController alloc] init];
    [self setupChildViewController:shopVC title:@"购物车" imageName:@"shoppingCart_gray" seleceImageName:@"shoppingCart_blue"];
    
    
    PersonCenterViewController *personVC = [[PersonCenterViewController alloc]init];
    [self setupChildViewController:personVC title:@"我的" imageName:@"my_gray" seleceImageName:@"my_blue"];
    
    self.viewControllers = _VCS;
}

-(void)setupChildViewController:(UIViewController*)controller title:(NSString *)title imageName:(NSString *)imageName seleceImageName:(NSString *)selectImageName{
    controller.title = title;
    controller.tabBarItem.title = title;//跟上面一样效果
    controller.tabBarItem.image = [[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    controller.tabBarItem.selectedImage = [[UIImage imageNamed:selectImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    //未选中字体颜色
    [controller.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor],NSFontAttributeName:SYSTEMFONT(12.0f)} forState:UIControlStateNormal];
    
    //选中字体颜色
    [controller.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"6493ff"],NSFontAttributeName:SYSTEMFONT(12.0f)} forState:UIControlStateSelected];
    //包装导航控制器
    RootNavigationController *nav = [[RootNavigationController alloc]initWithRootViewController:controller];
    
    [_VCS addObject:nav];
    
}


-(void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
    //    NSLog(@"选中 %ld",tabBarController.selectedIndex);
    
}

-(void)setRedDotWithIndex:(NSInteger)index isShow:(BOOL)isShow{
    if (isShow) {
        [self.tabBar setBadgeStyle:kCustomBadgeStyleRedDot value:0 atIndex:index];
    }else{
        [self.tabBar setBadgeStyle:kCustomBadgeStyleNone value:0 atIndex:index];
    }
    
}

- (BOOL)shouldAutorotate {
    return [self.selectedViewController shouldAutorotate];
}
- (UIInterfaceOrientationMask)supportedInterfaceOrientations{
    return [self.selectedViewController supportedInterfaceOrientations];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
