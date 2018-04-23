//
//  LoginView.h
//  ZhongJianMalliOS
//
//  Created by 段 on 2017/11/6.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginView : UIView<UITextFieldDelegate>

@property (nonatomic,strong) UITextField *phoneText;
@property (nonatomic,strong) UITextField *passwordText;

/*
 * 返回的回调
 */
@property (nonatomic,copy) dispatch_block_t backButtonClickBlock;
/*
 * 登陆的回调
 */
@property (nonatomic,copy) dispatch_block_t loginButtonClickBlock;
/*
 * 忘记密码回调
 */
@property (nonatomic,copy) dispatch_block_t forgetButtonClickBlock;
/*
 * 注册的回调
 */
@property (nonatomic,copy) dispatch_block_t registButtonClickBlock;
/*
 * 短信登陆的回调
 */
@property (nonatomic,copy) dispatch_block_t newsLoginButtonClickBlock;
@end
