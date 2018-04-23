//
//  NoteLoginView.h
//  ZhongJianMalliOS
//
//  Created by 段 on 2017/11/8.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NoteLoginView : UIView

@property (nonatomic,strong) UITextField *phoneText;
@property (nonatomic,strong) UITextField *checkText;//验证码
@property (nonatomic,strong) UIButton *checkButton;//验证按钮

/*
 * 返回的回调
 */
@property (nonatomic,copy) dispatch_block_t backButtonClickBlock;
/*
 * 登陆的回调
 */
@property (nonatomic,copy) dispatch_block_t loginButtonClickBlock;
/*
 * 验证码的回调
 */
@property (nonatomic,copy) dispatch_block_t getCodeButtonClickBlock;

@end
