//
//  ForgetPassWordView.m
//  ZhongJianMalliOS
//
//  Created by 段 on 2018/1/8.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "ForgetPassWordView.h"

@implementation ForgetPassWordView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self creatUI];
    }
    return self;
}
- (void)creatUI {
    self.backgroundColor = [UIColor whiteColor];
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton addTarget:self action:@selector(loginViewButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    backButton.tag = 100;
    [backButton setBackgroundImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [self addSubview:backButton];
    [backButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(10);
        make.width.mas_offset(20);
        make.height.mas_offset(20);
        make.top.mas_offset(30);
    }];
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text = @"忘记密码";
    titleLabel.textAlignment = 1;
    titleLabel.textColor = [UIColor colorWithHexString:@"444444"];
    titleLabel.font = [UIFont systemFontOfSize:18];
    [self addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_offset(0);
        make.centerY.equalTo(backButton.mas_centerY).offset(0);
        make.height.mas_offset(30);
        make.width.mas_offset(100);
    }];
    UILabel *lineLabel = [UILabel new];
    lineLabel.backgroundColor = [UIColor colorWithHexString:@"999999"];
    [self addSubview:lineLabel];
    [lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(0);
        make.height.mas_offset(0.5);
        make.right.mas_offset(0);
        make.top.mas_offset(64);
    }];
    
    UIImageView *logoImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo4"]];
    
    [self addSubview:logoImage];
    [logoImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_offset(0);
        make.top.mas_offset(128);
        make.height.mas_offset(80);
        make.width.mas_offset(80);
    }];
    
    _phoneText = [self creatTextFieldText:@"请输入手机号" leftImage:[UIImage imageNamed:@"phone_blue"]];
    _phoneText.keyboardType = UIKeyboardTypePhonePad;
    [_phoneText addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];    [self addSubview:_phoneText];
    [_phoneText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(35);
        make.right.mas_offset(-35);
        make.top.equalTo(logoImage.mas_bottom).offset(60);
        make.height.mas_offset(40);
    }];
    _checkText = [self creatTextFieldText:@"输入验证码" leftImage:[UIImage imageNamed:@"verificationcode_blue"]];
    _checkText.keyboardType = UIKeyboardTypeNumberPad;
    UIView *rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 90, 40)];
    _checkButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [_checkButton setTitle:@"获取验证码" forState:UIControlStateNormal];
    _checkButton.frame = CGRectMake(5, 0, 65, 40);
    _checkButton.tag = 101;
    _checkButton.titleLabel.font = [UIFont systemFontOfSize:12];
    [_checkButton setTitleColor:zjTextColor forState:UIControlStateNormal];
    [_checkButton addTarget:self action:@selector(loginViewButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [rightView addSubview:_checkButton];
    
    UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(0, 14, 0.5, 12)];
    line1.backgroundColor = [UIColor colorWithHexString:@"999999"];
    [rightView addSubview:line1];
    _checkText.rightView = rightView;
    _checkText.rightViewMode = UITextFieldViewModeAlways;
    
    [self addSubview:_checkText];
    [_checkText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(35);
        make.right.mas_offset(-35);
        make.top.equalTo(_phoneText.mas_bottom).offset(20);
        make.height.mas_offset(40);
    }];
    
    _passwordText = [self creatTextFieldText:@"输入新密码" leftImage:[UIImage imageNamed:@"password_blue"]];
    _passwordText.secureTextEntry = YES;
    [_passwordText addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    [self addSubview:_passwordText];
    [_passwordText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(35);
        make.right.mas_offset(-35);
        make.height.mas_offset(40);
        make.top.equalTo(_checkText.mas_bottom).offset(20);
    }];
    
    _surePasswordText = [self creatTextFieldText:@"确认密码" leftImage:[UIImage imageNamed:@"password_blue"]];
    _surePasswordText.secureTextEntry = YES;
    [_surePasswordText addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self addSubview:_surePasswordText];
    [_surePasswordText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(35);
        make.right.mas_offset(-35);
        make.height.mas_offset(40);
        make.top.equalTo(_passwordText.mas_bottom).offset(20);
    }];
    
    
    UIButton *loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [loginButton setBackgroundImage:[UIImage imageNamed:@"button_blue"] forState:UIControlStateNormal];
    [loginButton setTitle:@"确定修改" forState:UIControlStateNormal];
    loginButton.titleLabel.font = [UIFont systemFontOfSize:17];
    loginButton.tag = 102;
    [loginButton addTarget:self action:@selector(loginViewButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:loginButton];
    [loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(32);
        make.right.mas_offset(-32);
        make.height.mas_offset(57);
        make.top.equalTo(_surePasswordText.mas_bottom).offset(30);
    }];
    
    
}
- (void)textFieldDidChange:(UITextField *)textField
{
    if (textField == self.phoneText) {
        if (textField.text.length > 11) {
            textField.text = [textField.text substringToIndex:11];
        }
    }
    
}
- (void)loginViewButtonClick:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (sender.tag == 100) {
        !_backButtonClickBlock ? : _backButtonClickBlock();
    }else if (sender.tag == 101) {
        !_getCodeButtonClickBlock ? : _getCodeButtonClickBlock();
    }else {
        !_forgetButtonClickBlock ? : _forgetButtonClickBlock();
    }
    
}

- (UITextField *)creatTextFieldText:(NSString *)text leftImage:(UIImage *)image {
    UITextField *textField = [UITextField new];
    textField.layer.cornerRadius = 20;
    textField.layer.masksToBounds = YES;
    textField.placeholder = text;
    textField.font = [UIFont systemFontOfSize:12];
    textField.layer.borderWidth = 0.5;
    textField.layer.borderColor = [UIColor colorWithHexString:@"999999"].CGColor;
    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    UIImageView *lefeImage = [[UIImageView alloc] init];
    lefeImage.image = image;
    lefeImage.frame = CGRectMake(12, 12, 15, 15);
    [leftView addSubview:lefeImage];
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(35, 14, 0.5, 12)];
    line.backgroundColor = [UIColor colorWithHexString:@"999999"];
    [leftView addSubview:line];
    textField.leftView = leftView;
    textField.leftViewMode = UITextFieldViewModeAlways;
    return textField;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
