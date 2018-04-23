//
//  AddNewAdressViewController.m
//  ZhongJianMalliOS
//
//  Created by 段 on 2017/12/13.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "AddNewAdressViewController.h"
#import "EditAdressCell.h"
#import "CZHAddressPickerView.h"
#import "MBProgressHUD.h"

@interface AddNewAdressViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate> {
    
    UITextField *textRow0;
    UITextField *textRow1;
    UITextField *textRow2;
    UITextField *textRow3;
    
    NSInteger IsDefault;
}

@property (nonatomic,strong)UITableView *editTableView;
@property (nonatomic, copy) NSString *province;

@property (nonatomic, copy) NSString *city;

@property (nonatomic, copy) NSString *area;
@property (nonatomic, copy) NSString *provinceID;

@property (nonatomic, copy) NSString *cityID;

@property (nonatomic, copy) NSString *areaID;
@end
static NSString *const editAdressCellID = @"EditAdressCell";
@implementation AddNewAdressViewController
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.view.userInteractionEnabled = YES;
    IsDefault = 1;
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
    title.text = @"添加新地址";
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
    _editTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, KWIDTH, 300) style:UITableViewStylePlain];
    _editTableView.delegate = self;
    _editTableView.dataSource = self;
    _editTableView.scrollEnabled = NO;
    _editTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//    _editTableView.tableFooterView = [ui];
//    UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KWIDTH, KHEIGHT-64-45*5-14)];
//    footView.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];
//    UIButton *saveButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    saveButton.backgroundColor = zjTextColor;
//    saveButton.frame = CGRectMake(10, 60, KWIDTH-20, 40);
//    [saveButton setTitle:@"保存" forState:UIControlStateNormal];
//    saveButton.titleLabel.font = [UIFont systemFontOfSize:14];
//    saveButton.layer.cornerRadius = 10;
//    saveButton.layer.masksToBounds = YES;
//    [saveButton addTarget:self action:@selector(saveButtonClick) forControlEvents:UIControlEventTouchUpInside];
//    [footView addSubview:saveButton];
//    _editTableView.tableFooterView = footView;
    UIButton *saveButton = [UIButton buttonWithType:UIButtonTypeCustom];
    saveButton.backgroundColor = zjTextColor;
    saveButton.frame = CGRectMake(10, 370, KWIDTH-20, 40);
    [saveButton setTitle:@"保存" forState:UIControlStateNormal];
    saveButton.titleLabel.font = [UIFont systemFontOfSize:14];
    saveButton.layer.cornerRadius = 10;
    saveButton.layer.masksToBounds = YES;
    [saveButton addTarget:self action:@selector(saveButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:saveButton];
    [self.view addSubview:_editTableView];
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return section == 1 ? 1 : 4;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 7;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 45;
}
- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *head = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KWIDTH, 7)];
    head.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];
    return head;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    EditAdressCell *cell = [[EditAdressCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:editAdressCellID];
    if (!cell) {
        cell = [[EditAdressCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:editAdressCellID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSArray *titleArray = @[@"收货人：",@"手    机：",@"地    区：",@"地    址："];
    if (indexPath.section == 0) {
        cell.editNameLabel.text = titleArray[indexPath.row];
        UITextField *_inputTextField = [[UITextField alloc] init];
        _inputTextField.textAlignment = 0;
        _inputTextField.delegate = self;
        _inputTextField.tag = indexPath.row;
        _inputTextField.textColor = lightBlackTextColor;
        _inputTextField.font = [UIFont systemFontOfSize:13];
        [cell addSubview:_inputTextField];
        [_inputTextField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(80);
            make.centerY.mas_offset(0);
            make.height.mas_offset(45);
            make.width.mas_offset(KWIDTH-120);
        }];
        if (indexPath.row == 0) {
            textRow0 =  _inputTextField;
        }else if (indexPath.row == 1) {
            textRow1 = _inputTextField;
            textRow1.keyboardType = UIKeyboardTypePhonePad;
        }else if (indexPath.row == 2) {
            textRow2 = _inputTextField;
            textRow2.enabled = NO;
        }else {
            textRow3 = _inputTextField;
            textRow3.placeholder = @"街道、楼牌号等";
            
            }
        
        
    }else{
        cell.editNameLabel.text = @"设置为默认地址";
        UISwitch *adressSwitch = [[UISwitch alloc] init];
        adressSwitch.on = YES;//设置初始为ON的一边
        //    _orderSwich.onImage = [UIImage imageNamed:@"open"];
        //    _orderSwich.offImage = [UIImage imageNamed:@"close"];
        adressSwitch.onTintColor = [UIColor colorWithHexString:@"6493fe"];
        [adressSwitch addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
        [cell addSubview:adressSwitch];
        [adressSwitch mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_offset(-25);
            make.width.mas_offset(35);
            make.height.mas_offset(21);
            make.top.mas_offset(10);
        }];
        
    }
    
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 2) {
        [self.view endEditing:YES];
        __weak typeof(self) weakself=self;
        
        [CZHAddressPickerView areaPickerViewWithProvince:self.province provinceID:self.provinceID city:self.city cityID:self.cityID area:self.area areaID:self.areaID areaBlock:^(NSString *province, NSString *provinceID, NSString *city,NSString *cityID, NSString *area, NSString *areaID) {
            //            CZHStrongSelf(self);
            weakself.province = province;
            weakself.city = city;
            weakself.area = area;
            NSLog(@"====%@------%@=====%@",province,city,area);
            textRow2.text = [NSString stringWithFormat:@"%@%@%@",province,city,area];
            NSLog(@"====%@------%@=====%@",provinceID,cityID,areaID);
            weakself.provinceID = provinceID;
            weakself.cityID = cityID;
            weakself.areaID = areaID;
//            NSString *adress = [NSString stringWithFormat:@"%@%@%@",province,city,area];
//            [self.helpMeToSendDic setValue:adress forKey:@"province"];
        }];
    }
    if (indexPath.section == 1) {
        [self.view endEditing:YES];

    }

    NSLog(@"%@==========%@==========%@",textRow0.text,textRow1.text,textRow3.text);
}
-(void)switchAction:(UISwitch *)sender
{
    //    UISwitch *switchButton = (UISwitch*)sender;
    BOOL isButtonOn = [sender isOn];
    if (isButtonOn) {
        NSLog(@"开");
        IsDefault = 1;
        
    }else {
        NSLog(@"关");
        IsDefault = 0;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString *tem = [[string componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]componentsJoinedByString:@""];
    if (![string isEqualToString:tem]) {
        return NO;
    }
    return YES;
}
- (void)saveButtonClick {
    
    if (textRow0.text.length<1) {
        UIAlertController *showAlert = [UIAlertController alertControllerWithTitle:@"请输入收货人" message:nil preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *determineAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        
        [showAlert addAction:determineAction];
        
        [self presentViewController:showAlert animated:YES completion:nil];
    }else if ([CheckNumber checkTelNumber:textRow1.text]==NO) {
        
        UIAlertController *showAlert = [UIAlertController alertControllerWithTitle:@"请输入正确的手机号" message:nil preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *determineAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        
        [showAlert addAction:determineAction];
        
        [self presentViewController:showAlert animated:YES completion:nil];
    }else if (textRow3.text.length<1) {
        UIAlertController *showAlert = [UIAlertController alertControllerWithTitle:@"请输入收货地址" message:nil preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *determineAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        }];
        
        [showAlert addAction:determineAction];
        
        [self presentViewController:showAlert animated:YES completion:nil];
    }else if (_provinceID==nil) {
        UIAlertController *showAlert = [UIAlertController alertControllerWithTitle:@"请选择地区" message:nil preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *determineAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        }];
        
        [showAlert addAction:determineAction];
        
        [self presentViewController:showAlert animated:YES completion:nil];
    }else{
        
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *token = [user objectForKey:@"userToken"];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer new];
    manager.requestSerializer=[AFJSONRequestSerializer serializer];
    
    [manager.requestSerializer setValue:@"application/json"
                     forHTTPHeaderField:@"Content-Type"];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSNumber *isNormal = [NSNumber numberWithInteger:IsDefault];
    NSString *url = [NSString stringWithFormat:@"%@%@",HTTPUrl,@"/zjapp/v1/AddressManager/addAddressByUser"];
    
    NSDictionary *dic = @{
                          @"token":token,
                          @"ProvinceId":_provinceID,
                          @"CityId":_cityID,
                          @"RegionId":_areaID,
                          @"DetailAddress":textRow3.text,
                          @"Name":textRow0.text,
                          @"Phone":textRow1.text,
                          @"IsDefault":isNormal
                          };
    [manager POST:url parameters:dic progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",responseObject);
        [hud hideAnimated:YES];
        NSString *title = [NSString stringWithFormat:@"%@",responseObject[@"error_message"]];
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:nil preferredStyle:UIAlertControllerStyleAlert];
        
         if ([responseObject[@"error_code"] intValue] == 0) {
             [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                 [self backButtonClick];
             }]];
         }else {
             [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                 
             }]];
         }
       
        
        [self presentViewController:alert animated:YES completion:^{
            
        }];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
        [hud hideAnimated:YES];
    }];
    
    }
}

#pragma mark --返回
- (void)backButtonClick {
    self.navigationController.navigationBar.hidden = NO;
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    
    //方法1:通过结束控制器view的编辑状态, 这种情况控制器容易获取
    [self.view endEditing:YES];
    
    
//    //方法2:发送  注销第一响应者 消息给所有对象,用于不易获取控制器的情况
//    [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
//
//    //方法3:结束主窗口上的所有编辑
//    [[UIApplication sharedApplication].keyWindow endEditing:YES];
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
