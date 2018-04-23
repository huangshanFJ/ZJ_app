//
//  SettingNewPassworldViewController.m
//  ZhongJianMalliOS
//
//  Created by 段 on 2017/12/14.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "SettingNewPassworldViewController.h"
#import "NewPassworldTableViewCell.h"
#import "ForgetPassWordViewController.h"

@interface SettingNewPassworldViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UITableView *setNewPassworldTable;
@property (nonatomic,strong)UITextField *phoneTF;
@property (nonatomic,strong)UITextField *newsPassWorldTF;
@property (nonatomic,strong)UITextField *confirmPSTF;

@end

static NSString *const newPassWorldCellID = @"NewPassworldTableViewCell";
@implementation SettingNewPassworldViewController


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self configNav];
    
    [self configTableView];
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
    title.text = @"设置密码";
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
- (void)configTableView {
    _setNewPassworldTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, KWIDTH, KHEIGHT-64) style:UITableViewStylePlain];
    _setNewPassworldTable.delegate = self;
    _setNewPassworldTable.dataSource = self;
    _setNewPassworldTable.scrollEnabled = NO;
    _setNewPassworldTable.separatorStyle = UITableViewCellSeparatorStyleNone;

    UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KHEIGHT, KHEIGHT*0.8)];
    footView.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];
    _setNewPassworldTable.tableFooterView = footView;
    
    UILabel *forgetLabel = [[UILabel alloc] init];
    forgetLabel.textColor = lightgrayTextColor;
    forgetLabel.font = [UIFont systemFontOfSize:12];
    forgetLabel.textAlignment = 2;
    forgetLabel.text = @"忘记密码";
    [footView addSubview:forgetLabel];
    [forgetLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-10);
        make.top.equalTo(footView.mas_top).offset(15);
        make.height.mas_offset(16);
    }];
    UIImageView *forgetImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"forget_gray"]];
    [footView addSubview:forgetImage];
    [forgetImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(forgetLabel.mas_left).offset(-7);
        make.width.mas_offset(14);
        make.height.mas_offset(14);
        make.centerY.equalTo(forgetLabel.mas_centerY).offset(0);
    }];
    UIButton *forgetButton = [UIButton buttonWithType:UIButtonTypeCustom];
    forgetButton.backgroundColor = [UIColor clearColor];
    [forgetButton addTarget:self action:@selector(forgetPSButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [footView addSubview:forgetButton];
    [forgetButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-10);
        make.width.mas_offset(80);
        make.top.equalTo(footView.mas_top).offset(15);
        make.height.mas_offset(20);
        
    }];
    
    UIButton *saveButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [saveButton setTitle:@"保存" forState:UIControlStateNormal];
    saveButton.titleLabel.font = [UIFont systemFontOfSize:17];
    saveButton.backgroundColor = zjTextColor;
    [saveButton addTarget:self action:@selector(saveButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    saveButton.layer.cornerRadius = 20;
    saveButton.layer.masksToBounds = YES;
    [footView addSubview:saveButton];
    [saveButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(10);
        make.right.mas_offset(-10);
        make.top.equalTo(footView.mas_top).offset(75);
        make.height.mas_offset(40);
    }];
    
    
    [self.view addSubview:_setNewPassworldTable];
    
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 45;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 7;
}
- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KWIDTH, 7)];
    headView.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];
    return headView;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    NewPassworldTableViewCell *cell = [[NewPassworldTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:newPassWorldCellID];
    if (!cell) {
        cell = [[NewPassworldTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:newPassWorldCellID];
    }
    NSArray *titleArr = @[@"原密码：",@"新密码：",@"确认密码："];
    cell.prefixPWNameLabel.text = titleArr[indexPath.row];
    
    if (indexPath.row == 0) {
        _phoneTF = cell.passworldTF;
    }else if (indexPath.row == 1) {
        _newsPassWorldTF = cell.passworldTF;
    }else {
        _confirmPSTF = cell.passworldTF;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
 

- (void)forgetPSButtonClick:(UIButton *)sender {
    
    [self.navigationController pushViewController:[ForgetPassWordViewController new] animated:YES];
    
}
- (void)saveButtonClick:(UIButton *)sender {
    if (_phoneTF.text.length > 0 && _newsPassWorldTF.text.length > 0 && _confirmPSTF.text.length > 0) {
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        manager.responseSerializer = [AFJSONResponseSerializer new];
        manager.requestSerializer=[AFJSONRequestSerializer serializer];
        [manager.requestSerializer setValue:@"application/json"
                         forHTTPHeaderField:@"Content-Type"];
        NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
        NSString *token = [user objectForKey:@"userToken"];
//
        NSString *url = [NSString stringWithFormat:@"%@%@",HTTPUrl,@"/zjapp/v1/LoginAndRegister/modifyPassword"];
        NSDictionary *dic = @{
                              @"oldPassword":_phoneTF.text,
                              @"newPassword":_newsPassWorldTF.text,
                              @"newPasswordAgain":_confirmPSTF.text,
                              @"token":token
                              };
        [manager POST:url parameters:dic progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSLog(@"%@",responseObject);
            NSString *message = [NSString stringWithFormat:@"%@",responseObject[@"error_message"]];
            if ([responseObject[@"error_code"] intValue] == 0) {
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"修改成功" message:@"" preferredStyle:UIAlertControllerStyleAlert];
                [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
                [self presentViewController:alert animated:YES completion:^{
                    [self backButtonClick];
                }];
            }else {
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:message message:@"" preferredStyle:UIAlertControllerStyleAlert];
                [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
                [self presentViewController:alert animated:YES completion:^{
                    
                }];
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"%@",error);
            
        }];
  
    }else {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"请输入正确的密码" message:@"" preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
        [self presentViewController:alert animated:YES completion:^{
            
        }];
    }
    
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
