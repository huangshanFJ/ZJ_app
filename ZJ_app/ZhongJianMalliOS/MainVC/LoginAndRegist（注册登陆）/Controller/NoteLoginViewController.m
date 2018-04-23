//
//  NoteLoginViewController.m
//  ZhongJianMalliOS
//
//  Created by 段 on 2017/11/8.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "NoteLoginViewController.h"
#import "NoteLoginView.h"

@interface NoteLoginViewController ()


@property (nonatomic,strong)NoteLoginView *loginView;
@end

@implementation NoteLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
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
    _loginView = [[NoteLoginView alloc] initWithFrame:CGRectMake(0, 0, KWIDTH, KHEIGHT)];
    __weak __typeof(self) weakSelf = self;
    _loginView.backButtonClickBlock = ^{
        [weakSelf backClick];
    };
    _loginView.loginButtonClickBlock = ^{
        [weakSelf loginClick];
    };
    _loginView.getCodeButtonClickBlock = ^{
        [weakSelf codeButtonClick];
    };
    
    [self.view addSubview:_loginView];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)backClick {
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)loginClick {
 
    if ([CheckNumber checkTelNumber:_loginView.phoneText.text]) {
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        
        manager.responseSerializer = [AFJSONResponseSerializer new];
        manager.requestSerializer=[AFJSONRequestSerializer serializer];
        
        [manager.requestSerializer setValue:@"application/json"
                         forHTTPHeaderField:@"Content-Type"];
        NSString *url = [NSString stringWithFormat:@"%@%@",HTTPUrl,@"/zjapp/v1/LoginAndRegister/dynamicLogin"];
        //NSString *url = //@"http://192.168.1.236:8081/zjapp/v1/LoginAndRegister/UserLogin";
        NSDictionary *dic = @{
                              @"phoneNum":_loginView.phoneText.text,
                              @"verifyCode":_loginView.checkText.text
                              };
        
        
        [manager POST:url parameters:dic progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSLog(@"%@",responseObject);
            NSString *data = [NSString stringWithFormat:@"%@",responseObject[@"data"]];
            if ([responseObject[@"error_code"] intValue] == 0) {
                NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                //保存值(key值同名的时候会覆盖的)
                [defaults setObject:data forKey:@"userToken"];
                //立即保存
                [defaults synchronize];
                // 1.创建窗口
                self.window = [[UIWindow alloc] init];
                self.window.frame = [UIScreen mainScreen].bounds;
                
                // 2.设置窗口的根控制器
                self.window.rootViewController = [[MainTabBarController alloc] init];
                // 3.显示窗口(成为主窗口)
                [self.window makeKeyAndVisible];
            }else if([responseObject[@"error_code"] intValue] == 1){
                UIAlertController *showAlert = [UIAlertController alertControllerWithTitle:@"手机号不存在" message:nil preferredStyle:UIAlertControllerStyleAlert];
                [showAlert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil]];
                
                [self presentViewController:showAlert animated:YES completion:nil];
            }else {
                UIAlertController *showAlert = [UIAlertController alertControllerWithTitle:@"网络错误" message:nil preferredStyle:UIAlertControllerStyleAlert];
                [showAlert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil]];
                
                [self presentViewController:showAlert animated:YES completion:nil];
            }
           
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"%@",error);
        }];
    }else{
        
        UIAlertController *showAlert = [UIAlertController alertControllerWithTitle:@"请输入正确的手机号" message:nil preferredStyle:UIAlertControllerStyleAlert];
        [showAlert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil]];
        
        [self presentViewController:showAlert animated:YES completion:nil];
    }
    
    
    
}
- (void)codeButtonClick {
    NSLog(@"点击了验证码");
    if (_loginView.phoneText.text.length >8) {
        
        NSString *url = [NSString stringWithFormat:@"%@%@",HTTPUrl,@"/zjapp/v1/LoginAndRegister/SendRegisterVerifyCode"];
        //@"http://192.168.1.236:8081/zjapp/v1/LoginAndRegister/SendRegisterVerifyCode";
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        
        manager.responseSerializer = [AFJSONResponseSerializer new];
        manager.requestSerializer=[AFJSONRequestSerializer serializer];
        NSDictionary *dic = @{
                              @"phoneNum":_loginView.phoneText.text
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
                [alert addAction:[UIAlertAction actionWithTitle:@"发送成功" style:UIAlertActionStyleDefault handler:nil]];
            }else {
                [alert addAction:[UIAlertAction actionWithTitle:@"发送失败" style:UIAlertActionStyleDefault handler:nil]];
            }
            [self presentViewController:alert animated:YES completion:nil];
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"失败%@",error);
        }];
     
    }
    [self reduceTiome];
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
                [_loginView.checkButton setTitle:@"获取验证码" forState:UIControlStateNormal];
                [_loginView.checkButton setTitleColor:zjTextColor forState:UIControlStateNormal];
                _loginView.checkButton.userInteractionEnabled = YES;
            });
        } else {
            int seconds = timeout % 60;
            NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
            dispatch_async(dispatch_get_main_queue(), ^ {
                //设置界面的按钮显示 根据自己需求设置
                //                NSLog(@"____%@",strTime);
                [_loginView.checkButton setTitle:[NSString stringWithFormat:@"%@秒后获取",strTime] forState:UIControlStateNormal];
                [_loginView.checkButton setTitleColor:zjTextColor forState:UIControlStateNormal];
                _loginView.checkButton.userInteractionEnabled = NO;
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
    if (KHEIGHT < 600) {
        if ([_loginView.phoneText isFirstResponder]) {
            self.view.frame = CGRectMake(0, 0, KWIDTH, KHEIGHT );
            
        }else{
            
            self.view.frame = CGRectMake(0, -100, KWIDTH, KHEIGHT );
        }
        
    }
    
    
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
