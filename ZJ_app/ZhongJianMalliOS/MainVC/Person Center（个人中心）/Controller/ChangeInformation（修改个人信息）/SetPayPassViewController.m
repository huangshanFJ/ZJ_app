//
//  SetPayPassViewController.m
//  ZhongJianMalliOS
//
//  Created by 段 on 2018/1/26.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "SetPayPassViewController.h"
#import "SYPasswordView.h"
#import "ChangeInformationViewController.h"
//#import "PaymentPassViewController.h"

@interface SetPayPassViewController (){
    NSString *inputss;
}

@property (nonatomic, strong) SYPasswordView *pasView;

@end

@implementation SetPayPassViewController

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
    title.text = @"修改支付密码";
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
    self.pasView = [[SYPasswordView alloc] initWithFrame:CGRectMake(16, (KWIDTH-50*6)/2, 50*6, 45)];
    
    self.pasView.completeHandle = ^(NSString *inputPwd) {
        
        inputss = inputPwd;
    };
    [grayView addSubview:self.pasView];
    [self.pasView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_offset(0);
        make.width.mas_offset(300);
        make.height.mas_offset(45);
        make.top.equalTo(grayView.mas_top).offset(30);
    }];
    
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
//    button.backgroundColor = zjTextColor;
    button.frame = CGRectMake(100, 180, self.view.frame.size.width - 200, 50);
    [button setBackgroundImage:[UIImage imageNamed:@"button_blue"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(saveBuutton) forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:@"设置完成" forState:UIControlStateNormal];
    [grayView addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(32);
        make.right.mas_offset(-32);
        make.height.mas_offset(57);
        make.top.equalTo(self.pasView.mas_bottom).offset(25);
    }];
    
}
- (void)saveBuutton {
    if (inputss.length == 6) {
//        /LoginAndRegister/verify/
        NSString *url = [NSString stringWithFormat:@"%@%@%@",HTTPUrl,@"/zjapp/v1/LoginAndRegister/verify/",_verifyCode];
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
        NSString *token = [user objectForKey:@"userToken"];
        
        manager.responseSerializer = [AFJSONResponseSerializer new];
        manager.requestSerializer=[AFJSONRequestSerializer serializer];
        NSDictionary *dic = @{
                              @"token":token,
                              @"paypassword":inputss
                              };
        
        [manager.requestSerializer setValue:@"application/json"
                         forHTTPHeaderField:@"Content-Type"];
        [manager POST:url parameters:dic progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSLog(@"%@",responseObject);
            if ([responseObject[@"error_code"] intValue] == 0) {
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"设置成功" message:nil preferredStyle:UIAlertControllerStyleAlert];
                [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                    for (UIViewController *controller in self.navigationController.viewControllers) {
                        if ([controller isKindOfClass:[ChangeInformationViewController class]]) {
                            ChangeInformationViewController *messageVC =(ChangeInformationViewController *)controller;
                            [self.navigationController popToViewController:messageVC animated:YES];
                            break;
                        }
//                        if ([controller isKindOfClass:[PaymentPassViewController class]]) {
//                            PaymentPassViewController *payVC =(PaymentPassViewController *)controller;
//                            [self.navigationController popToViewController:payVC animated:YES];
//                            break;
//                        }
                    }
                
//
//                UINavigationController *navigationVC = self.navigationController;
//
//                NSMutableArray *viewControllers = [[NSMutableArray alloc] init];
//
//                //    遍历导航控制器中的控制器
//
//                for (UIViewController *vc in navigationVC.viewControllers) {
//
//                    [viewControllers addObject:vc];
//
//                    if ([vc isKindOfClass:[PaymentPassViewController class]]) {
//
//                        break;
//
//                    }
//
//                }
//
//                //    把控制器重新添加到导航控制器
//
//                [navigationVC setViewControllers:viewControllers animated:YES];
//
//                    [navigationVC popViewControllerAnimated:YES];

                }]];
                
                [self presentViewController:alert animated:YES completion:nil];
                
//            }else if ([responseObject[@"error_code"] intValue] == 0) {
//                NSString *error_message = [NSString stringWithFormat:@"%@",responseObject[@"error_message"]];
//                UIAlertController *alert = [UIAlertController alertControllerWithTitle:error_message message:nil preferredStyle:UIAlertControllerStyleAlert];
//                [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
//                    [self backButtonClick];
//                }]];
//                [self presentViewController:alert animated:YES completion:nil];
            }
            else {
                 NSString *error_message = [NSString stringWithFormat:@"%@",responseObject[@"error_message"]];
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:error_message message:nil preferredStyle:UIAlertControllerStyleAlert];
                [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                    
                }]];
                [self presentViewController:alert animated:YES completion:nil];
            }
            
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"%@",error);
        }];
        
        
    }else {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"请输入正确的支付密码" message:nil preferredStyle:UIAlertControllerStyleAlert ];
        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }]];
        [self presentViewController:alert animated:YES completion:^{
            
        }];
        
    }
}
- (void)backButtonClick {
    self.navigationController.navigationBar.hidden = NO;
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
