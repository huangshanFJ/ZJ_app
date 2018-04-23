//
//  RegistViewController.m
//  ZhongJianMalliOS
//
//  Created by 段 on 2017/11/7.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "RegistViewController.h"
#import "RegistView.h"
#import "WebTestViewController.h"

@interface RegistViewController ()<UITextFieldDelegate>{
    BOOL isSelcted;
    NSInteger _count;
}

@property (nonatomic,strong)RegistView *registView;
@end

@implementation RegistViewController
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    isSelcted = YES;
    
    [self showUI];
    //键盘回收
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    //设置成NO表示当前控件响应后会传播到其他控件上，默认为YES。
    tapGestureRecognizer.cancelsTouchesInView = NO;
    //将触摸事件添加到当前view
    [self.view addGestureRecognizer:tapGestureRecognizer];
    
    /**
     * 添加键盘的监听事件
     *
     */
    [self registerForKeyboardNotifications];
}
- (void)showUI {
    _registView = [[RegistView alloc] initWithFrame:CGRectMake(0, 0, KWIDTH, KHEIGHT)];
    __weak __typeof(self) weakSelf = self;
    _registView.registButtonClickBlock = ^{
        [weakSelf registClick];
    };
    _registView.registBackButtonClickBlock = ^{
        [weakSelf.navigationController popViewControllerAnimated:YES];
    };
    _registView.selectedButtonClickBlock = ^{
        [weakSelf selctedOrNot];
    };
    _registView.getCodeButtonClickBlock = ^{
        [weakSelf getCode];
    };
    _registView.treatButtonClickBlock = ^{
        [weakSelf goWeb];
    };
    
    [self.view addSubview:_registView];
}
//协议选中未选
- (void)selctedOrNot {
    
    isSelcted = !isSelcted;
    _registView.selectedButton.selected = isSelcted;
    if (isSelcted == YES) {
        _registView.selectedButton.backgroundColor = zjTextColor;
    }else{
        _registView.selectedButton.backgroundColor = [UIColor whiteColor];
    }
    NSLog(@"%@",isSelcted ? @"YES" : @"NO");

}
//验证码
- (void)getCode {
    NSLog(@"点击了验证码");
    if (_registView.phoneText.text.length >8) {
//        NSString *url = @"/LoginAndRegister/SendRegisterVerifyCode";
        NSString *url = [NSString stringWithFormat:@"%@%@",HTTPUrl,@"/zjapp/v1/LoginAndRegister/SendRegisterVerifyCode"];
        //@"http://192.168.1.236:8081/zjapp/v1/LoginAndRegister/SendRegisterVerifyCode";
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        
        manager.responseSerializer = [AFJSONResponseSerializer new];
        manager.requestSerializer=[AFJSONRequestSerializer serializer];
        NSDictionary *dic = @{
                              @"phoneNum":_registView.phoneText.text
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
//注册事件
- (void)registClick {
    NSLog(@"点击了注册");
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer new];
    manager.requestSerializer=[AFJSONRequestSerializer serializer];
    NSDictionary *dic;
    if (_registView.inviteCodeText.text.length == 0) {
        dic = @{
                @"phoneNum":_registView.phoneText.text,
                @"password":_registView.passwordText.text,
                @"verifyCode":_registView.checkText.text
                };
        
    }else {
        dic = @{
                @"phoneNum":_registView.phoneText.text,
                @"password":_registView.passwordText.text,
                @"verifyCode":_registView.checkText.text,
                @"inviteCode":_registView.inviteCodeText.text
                };
    }
    
    [manager.requestSerializer setValue:@"application/json"
                     forHTTPHeaderField:@"Content-Type"];
    
    NSString *url = @"/zjapp/v1/LoginAndRegister/RegisterUser";
    NSString * string3 = [NSString stringWithFormat:@"%@%@", HTTPUrl, url];

    [manager POST:string3 parameters:dic progress:^(NSProgress * _Nonnull uploadProgress) {

    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSLog(@"%@",responseObject);
        NSString *code = [NSString stringWithFormat:@"%@",responseObject[@"error_code"]];
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"" preferredStyle:UIAlertControllerStyleAlert];
        if ([code isEqualToString:@"0"]) {
            [alert addAction:[UIAlertAction actionWithTitle:@"发送成功" style:UIAlertActionStyleDefault handler:nil]];
        }else {
            NSString *message = [NSString stringWithFormat:@"%@",responseObject[@"error_message"]];
            [alert addAction:[UIAlertAction actionWithTitle:message style:UIAlertActionStyleDefault handler:nil]];
        }
        [self presentViewController:alert animated:YES completion:nil];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
         UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"" preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"网络请求失败" style:UIAlertActionStyleDefault handler:nil]];
        [self presentViewController:alert animated:YES completion:nil];

    }];
//
//    [HttpRequest postWithURLString:url parameters:dic WithSuccess:^(id result) {
//        NSLog(@"%@",result);
//    } With:^(NSError *error) {
//        NSLog(@"%@",error);
//    }];
    
}


//web
- (void)goWeb {
    WebTestViewController *web = [[WebTestViewController alloc] init];
    web.requestString = @"https://appnew.zhongjianmall.com/html/sysaticle.html?id=1";
    [self.navigationController pushViewController:web animated:YES];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    if (textField == self.registView.phoneText) {
        //这里的if时候为了获取删除操作,如果没有次if会造成当达到字数限制后删除键也不能使用的后果.
        if (range.length == 1 && string.length == 0) {
            return YES;
        }
        //so easy
        else if (self.registView.phoneText.text.length >= 11) {
            self.registView.phoneText.text = [textField.text substringToIndex:11];
            return NO;
        }
    }
    return YES;
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
                [_registView.checkButton setTitle:@"获取验证码" forState:UIControlStateNormal];
                [_registView.checkButton setTitleColor:zjTextColor forState:UIControlStateNormal];
                _registView.checkButton.userInteractionEnabled = YES;
            });
        } else {
            int seconds = timeout % 60;
            NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
            dispatch_async(dispatch_get_main_queue(), ^ {
                //设置界面的按钮显示 根据自己需求设置
                //                NSLog(@"____%@",strTime);
                [_registView.checkButton setTitle:[NSString stringWithFormat:@"%@秒后获取",strTime] forState:UIControlStateNormal];
                [_registView.checkButton setTitleColor:zjTextColor forState:UIControlStateNormal];
                _registView.checkButton.userInteractionEnabled = NO;
            });
            timeout--;
        }
    });
    dispatch_resume(_timer);
    
}

-(void)keyboardHide:(UITapGestureRecognizer*)tap{
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
}

#pragma mark--注册监听键盘的的通知
- (void)registerForKeyboardNotifications {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasShown:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillBeHidden:) name:UIKeyboardWillHideNotification object:nil];
    
}

#pragma mark-- 键盘出现的通知

- (void)keyboardWasShown:(NSNotification*)aNotification

{
    
    //键盘高度
    
    CGRect keyBoardFrame = [[[aNotification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
//    if (KHEIGHT < 600) {
        if ([_registView.phoneText isFirstResponder]) {
            self.view.frame = CGRectMake(0, 0, KWIDTH, KHEIGHT );
            
        }else{
            
            self.view.frame = CGRectMake(0, -100, KWIDTH, KHEIGHT );
        }
        
//    }
    
    
}
#pragma mark-- 键盘消失的通知

-(void)keyboardWillBeHidden:(NSNotification*)aNotification

{
    self.view.frame = CGRectMake(0, 0, KWIDTH, KHEIGHT );
    
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
