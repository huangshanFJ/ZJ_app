//
//  PasswordAlertView.h
//  ZhongJianMalliOS
//
//  Created by mac_fj on 2018/3/27.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    PasswordAlertViewType_default,
    PasswordAlertViewType_sheet,
}PasswordAlertViewType;

@protocol PasswordAlertViewDelegate <NSObject>

//点击了确定按钮  或者是完成了6位密码的输入
-(void)PasswordAlertViewCompleteInputWith:(NSString*)password;
//点击了取消按钮
-(void)PasswordAlertViewDidClickCancleButton;
//点击了忘记密码按钮
-(void)PasswordAlertViewDidClickForgetButton; 

@end

@interface PasswordAlertView : UIView

@property (nonatomic,weak) id<PasswordAlertViewDelegate> delegate;
@property (nonatomic,strong) UILabel *titleLable;  //标题
@property (nonatomic,strong) UILabel *tipsLalbe;   //输入框下面的提示lable（如提示密码错误) 默认隐藏 当调用密码错误的方法时就显示出来

- (instancetype)initWithType:(PasswordAlertViewType)type;

-(void)show;
- (void)showWithOrderNoc:(NSString *)orderNoc;

- (void)hide;

//密码正确后调用这个方法
-(void)passwordCorrect;

//密码错误后调用这个方法
-(void)passwordError;

//未设置支付密码
- (void)passwordNotSetting;

//设置消失
- (void)passwordViewDismiss;

@end
