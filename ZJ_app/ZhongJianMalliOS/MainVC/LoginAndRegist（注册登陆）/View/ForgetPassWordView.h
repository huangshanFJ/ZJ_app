//
//  ForgetPassWordView.h
//  ZhongJianMalliOS
//
//  Created by 段 on 2018/1/8.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ForgetPassWordView : UIView

@property (nonatomic,strong) UITextField *phoneText;
@property (nonatomic,strong) UITextField *checkText;//验证码
@property (nonatomic,strong) UIButton *checkButton;//验证按钮
@property (nonatomic,strong) UITextField *passwordText;//修改密码
@property (nonatomic,strong) UITextField *surePasswordText;//确认密码

/*
 * 返回的回调
 */
@property (nonatomic,copy) dispatch_block_t backButtonClickBlock;
/*
 * 确定按钮的回调
 */
@property (nonatomic,copy) dispatch_block_t forgetButtonClickBlock;
/*
 * 验证码的回调
 */
@property (nonatomic,copy) dispatch_block_t getCodeButtonClickBlock;
@end
