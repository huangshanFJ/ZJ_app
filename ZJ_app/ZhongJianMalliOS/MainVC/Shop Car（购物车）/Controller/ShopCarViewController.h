//
//  ShopCarViewController.h
//  ZhongJianMalliOS
//
//  Created by 段 on 2017/10/31.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShopCarViewController : RootViewController
//从商品详情页跳转过来的,布局需要调整  add by zy
//@property (nonatomic,assign) BOOL isFromGoodsPage;//不需要了 by FJ

@property (nonatomic,strong) UIView *bottomView;

- (void)creatChildBottom:(UIView *)bottom;

@end
