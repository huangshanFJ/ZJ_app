//
//  UIAlertController+ZJAdditions.h
//  ZhongJianMalliOS
//
//  Created by mac_fj on 2018/3/26.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIAlertController (ZJAdditions)

//网络错误提示
+(void)showOralNetFail;


//带title 以及展示内容
+(void)showOralAlertWithTitleString:(NSString *)title andContentString:(NSString *)content;

//带title 以及展示 和下标按钮
+(void)showAlertWithTitleString:(NSString*)title andContentString:(NSString*)content andButtonTitle:(NSString *)btnTitle;

//带title  以及展示 和下标按钮以及按钮行为
+(void)showAlertWithTitleString:(NSString*)title andContentString:(NSString*)content andButtonTitle:(NSString *)btnTitle andDoAction:(void(^)())doAction;

@end
