//
//  InviterViewController.m
//  ZhongJianMalliOS
//
//  Created by 段 on 2018/1/29.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "InviterViewController.h"

@interface InviterViewController ()
@property (nonatomic,strong)UITextField *nicknameTextField;

@end

@implementation InviterViewController

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
    title.text = @"添加邀请人";
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
    
    _nicknameTextField = [[UITextField alloc] init];
    _nicknameTextField.placeholder = @" 请输入邀请人ID";
    _nicknameTextField.keyboardType = UIKeyboardTypePhonePad;
    _nicknameTextField.backgroundColor = [UIColor whiteColor];
    _nicknameTextField.font = [UIFont systemFontOfSize:13];
    [grayView addSubview:_nicknameTextField];
    [_nicknameTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(0);
        make.right.mas_offset(0);
        make.top.equalTo(grayView.mas_top).offset(7);
        make.height.mas_offset(45);
    }];
    UIButton *saveButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [saveButton setTitle:@"保存" forState:UIControlStateNormal];
    saveButton.titleLabel.font = [UIFont systemFontOfSize:17];
    saveButton.backgroundColor = zjTextColor;
    [saveButton addTarget:self action:@selector(saveButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    saveButton.layer.cornerRadius = 20;
    saveButton.layer.masksToBounds = YES;
    [grayView addSubview:saveButton];
    [saveButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(10);
        make.right.mas_offset(-10);
        make.top.equalTo(_nicknameTextField.mas_bottom).offset(60);
        make.height.mas_offset(40);
    }];
    
    
}
- (void)saveButtonClick:(UIButton *)sender {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer new];

    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *token = [user objectForKey:@"userToken"];
    NSString *url = [NSString stringWithFormat:@"%@%@%@",HTTPUrl,@"/zjapp/v1/PersonalCenter/updateInviteCode/",token];
    NSInteger code = [_nicknameTextField.text intValue];
    NSNumber *num = [NSNumber numberWithInteger:code];
    NSDictionary *dic = @{
                          @"inviteCode":num
                          };
    
    
    [manager POST:url parameters:dic progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",responseObject);
        if ([responseObject[@"error_code"] intValue] == 0) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"修改成功" message:nil preferredStyle:UIAlertControllerStyleAlert];
            [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                [self.navigationController popViewControllerAnimated:YES];
            }]];
            [self presentViewController:alert animated:YES completion:nil];
        }else {
            NSString *error_message = [NSString stringWithFormat:@"%@",responseObject[@"error_message"]];
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:error_message message:nil preferredStyle:UIAlertControllerStyleAlert];
            [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                [self.navigationController popViewControllerAnimated:YES];
            }]];
            [self presentViewController:alert animated:YES completion:nil];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
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
