//
//  GiftPassViewController.m
//  ZhongJianMalliOS
//
//  Created by 段 on 2018/2/1.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "GiftPassViewController.h"
#import "SYPasswordView.h"

@interface GiftPassViewController (){
    NSString *inputss;
}

@property (nonatomic, strong) SYPasswordView *pasView;


@end

@implementation GiftPassViewController

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
    title.text = @"输入支付密码";
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
    [button setTitle:@"确定" forState:UIControlStateNormal];
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
        NSString *url = [NSString stringWithFormat:@"%@%@",HTTPUrl,@"/zjapp/v1/PersonalCenter/verifyPayPassword"];
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
        NSString *token = [user objectForKey:@"userToken"];
        
        manager.responseSerializer = [AFJSONResponseSerializer new];
        //        manager.requestSerializer=[AFJSONRequestSerializer serializer];
        NSDictionary *dic = @{
                              @"toKen":token,
                              @"payPassword":inputss
                              };
        [manager POST:url parameters:dic progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSLog(@"%@",responseObject);
            
            if ([responseObject[@"error_code"] intValue] == 0) {
                
                [self requestData];
            }else {
                
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"支付密码错误" message:nil preferredStyle:UIAlertControllerStyleAlert];
                [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                    
                }]];
                [self presentViewController:alert animated:YES completion:nil];
                
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"%@",error);
            
        }];
        
        
    }
    
}
- (void)requestData {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer new];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *token = [user objectForKey:@"userToken"];
    NSString *url = [NSString stringWithFormat:@"%@%@%@",HTTPUrl,@"/zjapp/v1/MemberShip/GivePresentPromptly/",token];
   
    NSDictionary *parame = @{
                             @"passiveUserId":_passiveUserId,
                             @"sendHeadId":_sendHeadId
                             };
    [manager POST:url parameters:parame progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",responseObject);
        NSString *code = [NSString stringWithFormat:@"%@",responseObject[@"error_code"]];
        NSString *error_message = [NSString stringWithFormat:@"%@",responseObject[@"error_message"]];
        if ([code integerValue] == 1) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:error_message message:nil preferredStyle:UIAlertControllerStyleAlert];
            [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
            }]];
            [self presentViewController:alert animated:YES completion:^{
                
            }];
            
        }else {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:error_message message:nil preferredStyle:UIAlertControllerStyleAlert];
            [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
            }]];
            [self presentViewController:alert animated:YES completion:^{
                
            }];
        }
        
        
        [hud hideAnimated:YES];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
        
        [hud hideAnimated:YES];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)backButtonClick {
    
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
    
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
