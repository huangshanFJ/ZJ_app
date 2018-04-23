//
//  UIAlertController+ZJAdditions.m
//  ZhongJianMalliOS
//
//  Created by mac_fj on 2018/3/26.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "UIAlertController+ZJAdditions.h"

@implementation UIAlertController (ZJAdditions)

+(void)showAlertWithTitleString:(NSString*)title andContentString:(NSString*)content andButtonTitle:(NSString *)btnTitle andDoAction:(void(^)())doAction{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:content preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:btnTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction *_Nonnull action) {
        if (doAction) {
            doAction();
        }
    }]];
    [self  presentViewController:alert];
}


+(void)showOralNetFail{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"网络原因" preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *_Nonnull action) {
    }]];
    [self  presentViewController:alert];
}


+(void)showOralAlertWithTitleString:(NSString *)title andContentString:(NSString *)content{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:content preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *_Nonnull action) {
    }]];
    [self  presentViewController:alert];
}



+(void)showAlertWithTitleString:(NSString*)title andContentString:(NSString*)content andButtonTitle:(NSString *)btnTitle{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:content preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:btnTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction *_Nonnull action) {
    }]];
    [self  presentViewController:alert];
}



+(void)presentViewController: (UIViewController*)vController
{
    UIViewController* rootViewController = [[[UIApplication sharedApplication] keyWindow] rootViewController];
    [rootViewController presentViewController:vController  animated:YES completion:nil];
}

@end
