//
//  AddAccountViewController.m
//  ZhongJianMalliOS
//
//  Created by 段 on 2018/1/29.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "AddAccountViewController.h"
#import "CashWithdrawalsViewController.h"

@interface AddAccountViewController ()
@property (nonatomic,strong)UITextField *nameTF;
@property (nonatomic,strong)UITextField *accountTF;

@end

@implementation AddAccountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];

    
    [self configNav];
    
    [self creatTable];
}
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
    title.text = @"添加账号";
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
    
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];
    [self.view addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(0);
        make.right.mas_offset(0);
        make.top.mas_offset(63);
        make.height.mas_offset(1);
    }];
    
}
- (void)creatTable {
    UIView *gray = [[UIView alloc] init];
    gray.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];
    [self.view addSubview:gray];
    [gray mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(0);
        make.top.mas_offset(64);
        make.height.mas_offset(KHEIGHT-64);
        make.width.mas_offset(KWIDTH);
    }];
    
    UILabel *left = [[UILabel alloc] init];
    left.backgroundColor = [UIColor whiteColor];
    left.text = @"   支付宝姓名   ";
    left.textColor = lightBlackTextColor;
    left.font = [UIFont systemFontOfSize:13];
    [gray addSubview:left];
    [left mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(0);
//        make.width.mas_offset();
        make.height.mas_offset(45);
        make.top.mas_offset(20);
    }];
    
    _nameTF = [self creatTextFieldText:@""];
    _nameTF.backgroundColor = [UIColor whiteColor];
    [gray addSubview:_nameTF];
    [_nameTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(left.mas_right).offset(0);
        make.width.mas_offset(KWIDTH);
        make.height.mas_offset(45);
        make.top.mas_offset(20);
    }];
    UILabel *line = [[UILabel alloc] init];
    line.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];
    [gray addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(0);
        make.width.mas_offset(KWIDTH);
        make.height.mas_offset(0.5);
        make.top.equalTo(_nameTF.mas_bottom).offset(0);
    }];
    
    UILabel *left1 = [[UILabel alloc] init];
    left1.text = @"   支付宝账号   ";
    left1.backgroundColor = [UIColor whiteColor];
    left1.textColor = lightBlackTextColor;
    left1.font = [UIFont systemFontOfSize:13];
    [gray addSubview:left1];
    [left1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(0);
//        make.width.mas_offset(KWIDTH);
        make.height.mas_offset(45);
        make.top.equalTo(line.mas_bottom).offset(0);
    }];
    
    
    _accountTF = [self creatTextFieldText:@""];
    _accountTF.backgroundColor = [UIColor whiteColor];
    [gray addSubview:_accountTF];
    [_accountTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(left1.mas_right).offset(0);
        make.width.mas_offset(KWIDTH);
        make.height.mas_offset(45);
        make.top.equalTo(line.mas_bottom).offset(0);
    }];
    
    UIButton *saveButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [saveButton setTitle:@"添加" forState:UIControlStateNormal];
    saveButton.titleLabel.font = [UIFont systemFontOfSize:17];
    [saveButton addTarget:self action:@selector(sureClick:) forControlEvents:UIControlEventTouchUpInside];
    saveButton.backgroundColor = zjTextColor;
    saveButton.layer.cornerRadius = 20;
    saveButton.layer.masksToBounds = YES;
    [gray addSubview:saveButton];
    [saveButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.height.mas_equalTo(40);
        make.top.equalTo(_accountTF.mas_bottom).offset(40);
    }];
}
- (void)sureClick:(UIButton *)sender {
    if (_nameTF.text.length > 0 && _accountTF.text.length > 0) {
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        manager.responseSerializer = [AFJSONResponseSerializer new];
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
        NSString *token = [user objectForKey:@"userToken"];
        NSString *url = [NSString stringWithFormat:@"%@%@%@",HTTPUrl,@"/zjapp/v1/AccountManager/AccountManager/AddAliAccount/",token];//,token];
        NSDictionary *paramet = @{
                              @"account":_accountTF.text,
                              @"name":_nameTF.text
                              };
        
        [manager POST:url parameters:paramet progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSLog(@"%@",responseObject);
            if ([responseObject[@"error_code"] intValue] == 0) {
//                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"添加完成" message:nil preferredStyle:UIAlertControllerStyleAlert];
//
//                [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
//                    [self.navigationController popViewControllerAnimated:YES];
//                }]];
//                [self presentViewController:alert animated:YES completion:^{
//
//                }];
                NSDictionary *dict = @{
                                       @"name":_nameTF.text,
                                       @"account":_accountTF.text
                                       };
                
                  [[NSNotificationCenter defaultCenter] postNotificationName:@"selectedAlipay" object:nil userInfo:dict];
                
                for (UIViewController *controller in self.navigationController.viewControllers) {
                    if ([controller isKindOfClass:[CashWithdrawalsViewController class]]) {
                        CashWithdrawalsViewController *messageVC =(CashWithdrawalsViewController *)controller;
                        [self.navigationController popToViewController:messageVC animated:YES];
                    }
//                    else{
//                        //                        [self popToPreviousView];
//                    }
                    
                }
                
            }
            [hud hideAnimated:YES];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"%@",error);
             [hud hideAnimated:YES];
        }];
        
    }else {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"请填写完整" message:nil preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil]];

        [self presentViewController:alert animated:YES completion:^{
            
        }];
    }
   
    
    
}

- (UITextField *)creatTextFieldText:(NSString *)text   {
    UITextField *textField = [UITextField new];
//    textField.layer.cornerRadius = 20;
//    textField.layer.masksToBounds = YES;
    textField.placeholder = text;
    textField.font = [UIFont systemFontOfSize:13];
//    textField.layer.borderWidth = 0.5;
//    textField.layer.borderColor = [UIColor colorWithHexString:@"999999"].CGColor;
//    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
//    UIImageView *lefeImage = [[UIImageView alloc] init];
////    lefeImage.image = image;
//    lefeImage.frame = CGRectMake(12, 12, 15, 15);
//    [leftView addSubview:lefeImage];
//    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(35, 14, 0.5, 12)];
//    line.backgroundColor = [UIColor colorWithHexString:@"999999"];
//    [leftView addSubview:line];
//    textField.leftView = leftView;
    textField.leftViewMode = UITextFieldViewModeAlways;
    return textField;
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
