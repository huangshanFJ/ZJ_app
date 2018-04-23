//
//  LoginViewController.m
//  ZhongJianMalliOS
//
//  Created by 段 on 2017/11/7.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "LoginViewController.h"
#import "LoginView.h"
#import "RegistViewController.h"
#import "NoteLoginViewController.h"
#import "ForgetPassWordViewController.h"
#import <CommonCrypto/CommonDigest.h>
 

@interface LoginViewController (){
    
}
@property (nonatomic,strong)LoginView *loginView;
@end

@implementation LoginViewController
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
//    self.navigationController.navigationBar.hidden = NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBar.barStyle = UIStatusBarStyleDefault;
    
     
    [self creatUI];
    
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

- (void)creatUI {
    _loginView = [[LoginView alloc] initWithFrame:CGRectMake(0, 0, KWIDTH, KHEIGHT)];
    __weak __typeof(self) weakSelf = self;
    _loginView.backButtonClickBlock = ^{
        [weakSelf backClick];
    };
    _loginView.forgetButtonClickBlock = ^{
        [weakSelf.navigationController pushViewController:[ForgetPassWordViewController new] animated:YES];
    };
    _loginView.loginButtonClickBlock = ^{
        [weakSelf loginClick];
    };
    _loginView.registButtonClickBlock = ^{
        [weakSelf.navigationController pushViewController:[RegistViewController new] animated:YES];
    };
    _loginView.newsLoginButtonClickBlock = ^{
        [weakSelf.navigationController pushViewController:[NoteLoginViewController new] animated:YES];
    };
    
    [self.view addSubview:_loginView];
}
- (void)loginClick {
    NSLog(@"点击了登陆");
    if ([CheckNumber checkTelNumber:_loginView.phoneText.text]) {
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        
        manager.responseSerializer = [AFJSONResponseSerializer new];
        manager.requestSerializer=[AFJSONRequestSerializer serializer];
        
        [manager.requestSerializer setValue:@"application/json"
                         forHTTPHeaderField:@"Content-Type"];
        NSString *url = [NSString stringWithFormat:@"%@%@",HTTPUrl,@"/zjapp/v1/LoginAndRegister/UserLogin"];
        //NSString *url = //@"http://192.168.1.236:8081/zjapp/v1/LoginAndRegister/UserLogin";
        NSDictionary *dic = @{
                              @"phoneNum":_loginView.phoneText.text,
                              @"password":_loginView.passwordText.text
                              };
        
        
        [manager POST:url parameters:dic progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSLog(@"%@",responseObject);
            if ([responseObject[@"error_code"] integerValue] == 0) {
                NSString *data = [NSString stringWithFormat:@"%@",responseObject[@"data"]];
                NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                //保存值(key值同名的时候会覆盖的)
                [defaults setObject:data forKey:@"userToken"];
                //立即保存
                [defaults synchronize];
//                NSString *alis = [self md5:data];
//                NSLog(@"%@---%lu",alis,(unsigned long)data.length);
//                [JPUSHService setAlias:alis completion:^(NSInteger iResCode, NSString *iAlias, NSInteger seq) {
//                    NSLog(@"%@",iAlias);
//                    if (iResCode == 0) {
//                        NSLog(@"添加别名成功");
//                    }
//                     NSLog(@"++++++++rescode: %ld, \ntags: %@, \nalias: %@\n", (long)iResCode, @"tag" , iAlias);
//                } seq:1];
//
//                [JPUSHService setAlias:data completion:^(NSInteger iResCode, NSString *iAlias, NSInteger seq) {
//
//                    //设置别名成功后，code值为0
//
//                    NSLog(@"++++++++rescode: %ld, \ntags: %@, \nalias: %@\n", (long)iResCode, @"tag" , iAlias);
//
//                } seq:0];
//
//#pragma mark - 推送别名设置
//                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                    [JPUSHService setAlias:alis completion:^(NSInteger iResCode, NSString *iAlias, NSInteger seq) {
//
//                        //设置别名成功后，code值为0
//
//                        NSLog(@"++++++++rescode: %ld, \ntags: %@, \nalias: %@\n", (long)iResCode, @"tag" , iAlias);
//
//                    } seq:0];
//                });
                
              
               
                // 1.创建窗口
                self.window = [[UIWindow alloc] init];
                self.window.frame = [UIScreen mainScreen].bounds;
                
                // 2.设置窗口的根控制器
                self.window.rootViewController = [[MainTabBarController alloc] init];
                // 3.显示窗口(成为主窗口)
                [self.window makeKeyAndVisible];
            }else {
                NSString *str = [NSString stringWithFormat:@"%@",responseObject[@"error_message"]];
                UIAlertController *showAlert = [UIAlertController alertControllerWithTitle:str message:nil preferredStyle:UIAlertControllerStyleAlert];
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)backClick {
    [self.navigationController popViewControllerAnimated:YES];
}
- (NSString *) md5:(NSString *) input {
    const char *cStr = [input UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5( cStr, strlen(cStr), digest ); // This is the md5 call
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    
    return  output;
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
