//
//  ChangePhoneViewController.m
//  ZhongJianMalliOS
//
//  Created by 段 on 2018/2/5.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "ChangePhoneViewController.h"
#import "SettingPhoneViewController.h"

@interface ChangePhoneViewController (){
    UIButton *checkButton;
}

@property (nonatomic,strong)UITextField *phoneTextField;
@property (nonatomic,strong)UITextField *verifyTextField;


@end

@implementation ChangePhoneViewController


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self configNav];
    
    [self configView];
}
#pragma mark -- UI
- (void)configNav {
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton addTarget:self action:@selector(backButtonClick) forControlEvents:UIControlEventTouchUpInside];
    backButton.tag = 100;
    [backButton setBackgroundImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [self.view addSubview:backButton];
    [backButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(10);
        make.width.mas_offset(20);
        make.height.mas_offset(20);
        make.top.mas_offset(30);
    }];
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, KWIDTH, 44)];
    title.text = @"修改手机号";
    title.textAlignment = 1;
    title.textColor = [UIColor colorWithHexString:@"444444"];
    title.font = [UIFont systemFontOfSize:17];
    [self.view addSubview:title];
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(20);
        make.height.mas_offset(44);
        make.right.mas_offset(-50);
        make.left.mas_offset(50);
    }];
    
}
- (void)configView {
    UIView *grayView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, KWIDTH, KHEIGHT-64)];
    grayView.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];
    [self.view addSubview:grayView];
    
    _phoneTextField = [[UITextField alloc] init];
    _phoneTextField.backgroundColor = [UIColor whiteColor];
    _phoneTextField.font = [UIFont systemFontOfSize:13];
    _phoneTextField.textColor = lightBlackTextColor;
    _phoneTextField.placeholder = @"  输入手机号";
    if (_phone.length > 0) {
        _phoneTextField.text = _phone;
    }
    
    _phoneTextField.enabled = NO;
    _phoneTextField.keyboardType = UIKeyboardTypeNumberPad;
    [grayView addSubview:_phoneTextField];
    [_phoneTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(0);
        make.right.mas_offset(0);
        make.top.equalTo(grayView.mas_top).offset(7);
        make.height.mas_offset(45);
    }];
    
    _verifyTextField = [[UITextField alloc] init];
    _verifyTextField.backgroundColor = [UIColor whiteColor];
    _verifyTextField.userInteractionEnabled = YES;
    _verifyTextField.keyboardType = UIKeyboardTypePhonePad;
    _verifyTextField.placeholder = @"请输入验证码";
    _verifyTextField.font = [UIFont systemFontOfSize:13];
    checkButton = [UIButton buttonWithType:UIButtonTypeCustom];
    UIView *rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 90, 40)];
    [checkButton setTitle:@"  获取验证码" forState:UIControlStateNormal];
    checkButton.frame = CGRectMake(5, 0, 70, 40);
    checkButton.tag = 1100;
    checkButton.titleLabel.font = [UIFont systemFontOfSize:12];
    [checkButton setTitleColor:zjTextColor forState:UIControlStateNormal];
    [checkButton addTarget:self action:@selector(verifyButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [rightView addSubview:checkButton];
    UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(0, 14, 0.5, 12)];
    line1.backgroundColor = [UIColor colorWithHexString:@"999999"];
    [rightView addSubview:line1];
    _verifyTextField.rightView = rightView;
    _verifyTextField.rightViewMode = UITextFieldViewModeAlways;
    [grayView addSubview:_verifyTextField];
    [_verifyTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(0);
        make.right.mas_offset(0);
        make.top.equalTo(_phoneTextField.mas_bottom).offset(7);
        make.height.mas_offset(45);
    }];
    
    UIButton *nextButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [nextButton setBackgroundImage:[UIImage imageNamed:@"button_blue"] forState:UIControlStateNormal];
    [nextButton setTitle:@"下一步" forState:UIControlStateNormal];
    nextButton.titleLabel.font = [UIFont systemFontOfSize:17];
    nextButton.tag = 1300;
    [nextButton addTarget:self action:@selector(nextViewButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:nextButton];
    [nextButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(32);
        make.right.mas_offset(-32);
        make.height.mas_offset(57);
        make.top.equalTo(_verifyTextField.mas_bottom).offset(25);
    }];
    
    
}
- (void)verifyButtonClick:(UIButton *)sender {
    if (_phoneTextField.text.length >8) {
        //        NSString *url = @"/LoginAndRegister/SendRegisterVerifyCode";
        NSString *url = [NSString stringWithFormat:@"%@%@",HTTPUrl,@"/zjapp/v1/LoginAndRegister/SendRegisterVerifyCode"];
        //@"http://192.168.1.236:8081/zjapp/v1/LoginAndRegister/SendRegisterVerifyCode";
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        
        manager.responseSerializer = [AFJSONResponseSerializer new];
        manager.requestSerializer=[AFJSONRequestSerializer serializer];
        NSDictionary *dic = @{
//                              @"token"
                              @"phoneNum":_phoneTextField.text
                              };
        
        [manager.requestSerializer setValue:@"application/json"
                         forHTTPHeaderField:@"Content-Type"];
        //
        [manager POST:url parameters:dic progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSLog(@"成功%@",responseObject);
            NSString *code = [NSString stringWithFormat:@"%@",responseObject[@"error_code"]];
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"" preferredStyle:UIAlertControllerStyleAlert];
            if ([code isEqualToString:@"0"]) {
                [self reduceTiome];
                [alert addAction:[UIAlertAction actionWithTitle:@"发送成功" style:UIAlertActionStyleDefault handler:nil]];
            }else {
                [alert addAction:[UIAlertAction actionWithTitle:@"发送失败" style:UIAlertActionStyleDefault handler:nil]];
            }
            [self presentViewController:alert animated:YES completion:nil];
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"失败%@",error);
        }];
        
    }
    
}
- (void)nextViewButtonClick:(UIButton *)sender {
    NSString *url = [NSString stringWithFormat:@"%@%@",HTTPUrl,@"/zjapp/v1/LoginAndRegister/verifyUpdateUserName"];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *token = [user objectForKey:@"userToken"];
    
    manager.responseSerializer = [AFJSONResponseSerializer new];
    manager.requestSerializer=[AFJSONRequestSerializer serializer];
    NSDictionary *dic = @{
                          @"token":token,
                          @"verifyCode":_verifyTextField.text
                          };
    
    [manager.requestSerializer setValue:@"application/json"
                     forHTTPHeaderField:@"Content-Type"];
    //
    [manager POST:url parameters:dic progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"成功%@",responseObject);
        NSString *code = [NSString stringWithFormat:@"%@",responseObject[@"error_code"]];
        if ([code isEqualToString:@"0"]) {
            SettingPhoneViewController *paypassVC = [SettingPhoneViewController new];
            //            paypassVC.
            NSString *code = [NSString stringWithFormat:@"%@",responseObject[@"data"]];
            paypassVC.verifyCode = code;
            [self.navigationController pushViewController:paypassVC animated:YES];
            //            [alert addAction:[UIAlertAction actionWithTitle:@"发送成功" style:UIAlertActionStyleDefault handler:nil]];
        }else {
            NSString *message = [NSString stringWithFormat:@"%@",responseObject[@"error_message"]];
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:message message:@"" preferredStyle:UIAlertControllerStyleAlert];
            [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
            [self presentViewController:alert animated:YES completion:nil];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"失败%@",error);
    }];
}

- (void)reduceTiome {
    __block int timeout = 59; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^ {
        if(timeout <= 0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^ {
                //设置界面的按钮显示 根据自己需求设置
                [checkButton setTitle:@"获取验证码" forState:UIControlStateNormal];
                [checkButton setTitleColor:zjTextColor forState:UIControlStateNormal];
                checkButton.userInteractionEnabled = YES;
            });
        } else {
            int seconds = timeout % 60;
            NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
            dispatch_async(dispatch_get_main_queue(), ^ {
                //设置界面的按钮显示 根据自己需求设置
                //                NSLog(@"____%@",strTime);
                [checkButton setTitle:[NSString stringWithFormat:@"%@秒后获取",strTime] forState:UIControlStateNormal];
                [checkButton setTitleColor:zjTextColor forState:UIControlStateNormal];
                checkButton.userInteractionEnabled = NO;
            });
            timeout--;
        }
    });
    dispatch_resume(_timer);
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)backButtonClick {
    self.navigationController.navigationBar.hidden = NO;
    [self.navigationController popViewControllerAnimated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
