//
//  RegistView.h
//  ZhongJianMalliOS
//
//  Created by 段 on 2017/11/7.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegistView : UIView<UITextFieldDelegate>

@property (nonatomic,strong) UITextField *phoneText;//shou'ji'h
@property (nonatomic,strong) UITextField *passwordText;//密码
@property (nonatomic,strong) UITextField *inviteCodeText;//邀请码
@property (nonatomic,strong) UITextField *checkText;//验证码
@property (nonatomic,strong) UIButton *checkButton;//验证按钮
@property (nonatomic,strong) UIButton *selectedButton;//选中未选中按钮
//@property (nonatomic,assign)BOOL isSelctedOrNot;
/*
 * 返回按钮的回调
 */
@property (nonatomic,copy) dispatch_block_t registBackButtonClickBlock;
/*
 * 注册按钮的回调
 */
@property (nonatomic,copy) dispatch_block_t registButtonClickBlock;
/*
 * 选中协议按钮的回调
 */
@property (nonatomic,copy) dispatch_block_t selectedButtonClickBlock;
/*
 * 验证码的回调
 */
@property (nonatomic,copy) dispatch_block_t getCodeButtonClickBlock;
/*
 * 用户协议的回调
 */
@property (nonatomic,copy) dispatch_block_t treatButtonClickBlock;

@end
