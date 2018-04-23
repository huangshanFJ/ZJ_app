//
//  RegistView.m
//  ZhongJianMalliOS
//
//  Created by 段 on 2017/11/7.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "RegistView.h"

@implementation RegistView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initRegistView];
    }
    return self;
}
- (void)initRegistView {
    self.backgroundColor = [UIColor whiteColor];
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton addTarget:self action:@selector(registViewButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    backButton.tag = 1000;
    [backButton setBackgroundImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [self addSubview:backButton];
    [backButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(10);
        make.width.mas_offset(20);
        make.height.mas_offset(20);
        make.top.mas_offset(30);
    }];
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text = @"注册";
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
        make.top.mas_offset(0.17*KHEIGHT);
        make.height.mas_offset(80);
        make.width.mas_offset(80);
    }];

    _phoneText = [self creatTextFieldText:@"输入手机号" leftImage:[UIImage imageNamed:@"phone_blue"]];
    _phoneText.keyboardType = UIKeyboardTypePhonePad;
    [_phoneText addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self addSubview:_phoneText];
    [_phoneText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(35);
        make.right.mas_offset(-35);
        make.top.equalTo(logoImage.mas_bottom).offset(0.06*KHEIGHT);
        make.height.mas_offset(40);
    }];

    _passwordText = [self creatTextFieldText:@"输入密码" leftImage:[UIImage imageNamed:@"password_blue"]];
    _passwordText.secureTextEntry = YES;
    [_passwordText addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];

    [self addSubview:_passwordText];
    [_passwordText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(35);
        make.right.mas_offset(-35);
        make.top.equalTo(_phoneText.mas_bottom).offset(0.024*KHEIGHT);
        make.height.mas_offset(40);
    }];
    _inviteCodeText = [self creatTextFieldText:@"邀请码(非必填)" leftImage:[UIImage imageNamed:@"password_blue"]];
    _inviteCodeText.secureTextEntry = YES;
    [_inviteCodeText addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];

    [self addSubview:_inviteCodeText];
    [_inviteCodeText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(35);
        make.right.mas_offset(-35);
        make.top.equalTo(_passwordText.mas_bottom).offset(0.024*KHEIGHT);
        make.height.mas_offset(40);
    }];
    
    _checkText = [self creatTextFieldText:@"输入验证码" leftImage:[UIImage imageNamed:@"verificationcode_blue"]];
    _checkText.keyboardType = UIKeyboardTypeNumberPad;
    UIView *rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 90, 40)];
    _checkButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [_checkButton setTitle:@"获取验证码" forState:UIControlStateNormal];
    _checkButton.frame = CGRectMake(5, 0, 65, 40);
    _checkButton.tag = 1100;
    _checkButton.titleLabel.font = [UIFont systemFontOfSize:12];
    [_checkButton setTitleColor:zjTextColor forState:UIControlStateNormal];
    [_checkButton addTarget:self action:@selector(registViewButtonClick:) forControlEvents:UIControlEventTouchUpInside];
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
        make.top.equalTo(_inviteCodeText.mas_bottom).offset(0.024*KHEIGHT);
        make.height.mas_offset(40);
    }];

    _selectedButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _selectedButton.layer.borderWidth = 0.5;
    _selectedButton.layer.borderColor = [UIColor colorWithHexString:@"999999"].CGColor;
    _selectedButton.layer.masksToBounds = YES;
//    _isSelctedOrNot = YES;
//    _selectedButton.selected = _isSelctedOrNot;
    [_selectedButton setSelected:YES];
    if (_selectedButton.selected == YES) {
        _selectedButton.backgroundColor = zjTextColor;
//        _selectedButton.backgroundColor = [UIColor redColor];
    }else{
        _selectedButton.backgroundColor = [UIColor whiteColor];
    }
    _selectedButton.tag = 1200;
    [_selectedButton addTarget:self action:@selector(registViewButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:_selectedButton];
    
    UILabel *treatyLabel = [[UILabel alloc] init];
    treatyLabel.text = @"已阅读《用户服务协议》";
    treatyLabel.textColor = [UIColor colorWithHexString:@"999999"];
    treatyLabel.font = [UIFont systemFontOfSize:13];
    [self addSubview:treatyLabel];
    
    [_selectedButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(35);
        make.top.equalTo(_checkText.mas_bottom).offset(0.018*KHEIGHT);
        make.height.mas_offset(12);
        make.width.mas_offset(12);
    }];
    [treatyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_selectedButton.mas_right).offset(15);
        make.centerY.equalTo(_selectedButton.mas_centerY).offset(0);
        make.height.mas_offset(10);
    }];
    /*
    [treatyLabel mas_makeConstraints:^(MASConstraintMaker *make) {https://appnew.zhongjianmall.com/html/sysaticle.html?id=1
        make.left.equalTo(self.mas_left).offset(35);
        make.height.mas_offset(10);
        make.centerY.equalTo(_selectedButton.mas_centerY).offset(0);
    }];
    [_selectedButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(treatyLabel.mas_right).offset(15);
        make.top.equalTo(_checkText.mas_bottom).offset(0.018*KHEIGHT);
        make.height.mas_offset(12);
        make.width.mas_offset(12);
    }];*/
    UIButton *treatyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    treatyBtn.backgroundColor = [UIColor clearColor];
    treatyBtn.tag = 1400;
    [treatyBtn addTarget:self action:@selector(registViewButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:treatyBtn];
    [treatyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_selectedButton.mas_right).offset(7);
        make.height.mas_offset(10);
        make.width.mas_offset(150);
        make.centerY.equalTo(_selectedButton.mas_centerY).offset(0);
    }];
    

    UIButton *loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [loginButton setBackgroundImage:[UIImage imageNamed:@"button_blue"] forState:UIControlStateNormal];
    [loginButton setTitle:@"注册" forState:UIControlStateNormal];
    loginButton.titleLabel.font = [UIFont systemFontOfSize:17];
    loginButton.tag = 1300;
    [loginButton addTarget:self action:@selector(registViewButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:loginButton];
    [loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(32);
        make.right.mas_offset(-32);
        make.height.mas_offset(57);
        make.top.equalTo(treatyLabel.mas_bottom).offset(25);
    }];
}
- (void)registViewButtonClick:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (sender.tag == 1000) {
        !_registBackButtonClickBlock ? :_registBackButtonClickBlock();
    }else if (sender.tag == 1100) {
       
        !_getCodeButtonClickBlock ? : _getCodeButtonClickBlock();
    }else if (sender.tag == 1200) {
        !_selectedButtonClickBlock ? : _selectedButtonClickBlock();
    }else if (sender.tag == 1300){
        !_registButtonClickBlock ? : _registButtonClickBlock();
    }else if (sender.tag == 1400){
        !_treatButtonClickBlock ? : _treatButtonClickBlock();
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
    if (textField == self.inviteCodeText) {
        if (textField.text.length > 6) {
            textField.text = [textField.text substringToIndex:6];
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
