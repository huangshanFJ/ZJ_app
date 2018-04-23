//
//  LoginView.m
//  ZhongJianMalliOS
//
//  Created by 段 on 2017/11/6.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "LoginView.h"

@implementation LoginView


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
    titleLabel.text = @"登录";
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
        make.top.mas_offset(0.06*KHEIGHT+64);
        make.height.mas_offset(80);
        make.width.mas_offset(80);
    }];

    _phoneText = [self creatTextFieldText:@"手机号" leftImage:[UIImage imageNamed:@"phone_blue"]];
    _phoneText.keyboardType = UIKeyboardTypePhonePad;
    [_phoneText addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];

    [self addSubview:_phoneText];
    [_phoneText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(35);
        make.right.mas_offset(-35);
        make.top.equalTo(logoImage.mas_bottom).offset(0.12*KHEIGHT);
        make.height.mas_offset(40);
    }];
    
    _passwordText = [self creatTextFieldText:@"密码" leftImage:[UIImage imageNamed:@"password_blue"]];
    _passwordText.secureTextEntry = YES;
    [_passwordText addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];

    [self addSubview:_passwordText];
    [_passwordText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(35);
        make.right.mas_offset(-35);
        make.top.equalTo(_phoneText.mas_bottom).offset(20);
        make.height.mas_offset(40);
    }];
  
    UIButton *forgetButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [forgetButton setTitle:@"忘记密码" forState:UIControlStateNormal];
    forgetButton.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -1);
    forgetButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [forgetButton setTitleColor:[UIColor colorWithHexString:@"999999"] forState:UIControlStateNormal];
    forgetButton.tag = 200;
    [forgetButton addTarget:self action:@selector(loginViewButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:forgetButton];
    [forgetButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-35);
        make.top.equalTo(_passwordText.mas_bottom).offset(20);
        make.height.mas_offset(12);
        make.width.mas_offset(80);
    }];
    UIImageView *questionImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"forget_gray"]];
    [self addSubview:questionImage];
    [questionImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(forgetButton.mas_left).offset(2);
        make.height.mas_offset(14);
        make.width.mas_offset(14);
        make.centerY.equalTo(forgetButton.mas_centerY).offset(0);
    }];
    UIButton *loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [loginButton setBackgroundImage:[UIImage imageNamed:@"button_blue"] forState:UIControlStateNormal];
    [loginButton setTitle:@"登录" forState:UIControlStateNormal];
    loginButton.titleLabel.font = [UIFont systemFontOfSize:17];
    loginButton.tag = 300;
    [loginButton addTarget:self action:@selector(loginViewButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:loginButton];
    [loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(32);
        make.right.mas_offset(-32);
        make.height.mas_offset(57);
        make.top.equalTo(forgetButton.mas_bottom).offset(0.04*KHEIGHT);
    }];
    
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = zjTextColor;
    [self addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_offset(0);
        make.top.equalTo(loginButton.mas_bottom).offset(40);
        make.width.mas_offset(0.5);
        make.height.mas_offset(10);
    }];
    
    UIButton *registButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [registButton setTitle:@"一键注册" forState:UIControlStateNormal];
    [registButton setTitleColor:zjTextColor forState:UIControlStateNormal];
    registButton.titleLabel.font = [UIFont systemFontOfSize:12];
    registButton.tag = 400;
    [registButton addTarget:self action:@selector(loginViewButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:registButton];
    [registButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(line.mas_left).offset(-7);
        make.width.mas_offset(50);
        make.height.mas_offset(20);
        make.centerY.equalTo(line.mas_centerY).offset(0);
    }];
    
    UIButton *newsLoginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [newsLoginButton setTitle:@"短信验证登录" forState:UIControlStateNormal];
    [newsLoginButton setTitleColor:zjTextColor forState:UIControlStateNormal];
    newsLoginButton.tag = 500;
    newsLoginButton.titleLabel.font = [UIFont systemFontOfSize:12];
    [newsLoginButton addTarget:self action:@selector(loginViewButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:newsLoginButton];
    [newsLoginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(line.mas_right).offset(7);
        make.width.mas_offset(80);
        make.height.mas_offset(20);
//        make.top.equalTo(loginButton.mas_bottom).offset(40);
        make.centerY.equalTo(line.mas_centerY).offset(0);
    }];

}

- (void)loginViewButtonClick:(UIButton*)sender {
    
    sender.selected = !sender.selected;
    if (sender.tag == 100) {
        !_backButtonClickBlock ? :_backButtonClickBlock();
    }else if (sender.tag == 200) {
        !_forgetButtonClickBlock ? : _forgetButtonClickBlock();
    }else if (sender.tag == 300) {
        !_loginButtonClickBlock ? : _loginButtonClickBlock();
    }else if (sender.tag == 400) {
        !_registButtonClickBlock ? : _registButtonClickBlock();
    }else {
        !_newsLoginButtonClickBlock ? : _newsLoginButtonClickBlock();
    }
    
}

- (void)textFieldDidChange:(UITextField *)textField
{
    if (textField == self.phoneText) {
        if (textField.text.length > 11) {
            textField.text = [textField.text substringToIndex:11];
        }
    }
    if (textField == self.passwordText) {
        if (textField.text.length > 20) {
            textField.text = [textField.text substringToIndex:20];
        }
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
