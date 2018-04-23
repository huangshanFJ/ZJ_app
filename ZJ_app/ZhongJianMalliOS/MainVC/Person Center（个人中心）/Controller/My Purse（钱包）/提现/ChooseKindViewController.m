//
//  ChooseKindViewController.m
//  ZhongJianMalliOS
//
//  Created by 段 on 2018/1/29.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "ChooseKindViewController.h"
#import "AddAccountViewController.h"

@interface ChooseKindViewController ()<UITableViewDelegate,UITableViewDataSource> {
    NSMutableArray *alipayArr;
//    NSMutableArray *bankArr;
}

@property (nonatomic,strong)UITableView *chooseZFTable;
@end

@implementation ChooseKindViewController
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    [self requestData];
}
- (void)requestData {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer new];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *token = [user objectForKey:@"userToken"];
    
    NSString *url = [NSString stringWithFormat:@"%@%@%@",HTTPUrl,@"/zjapp/v1/AccountManager/AccountManager/GetAllAccount/",token];

    [manager GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"-=======%@",responseObject);
        if ([responseObject[@"error_code"] integerValue] == 0) {
            alipayArr = [NSMutableArray arrayWithArray:responseObject[@"data"][@"aliAccount"]];
//            bankArr = [NSMutableArray arrayWithArray:responseObject[@"data"][@"bankAccount"]];
            
        }
        [hud hideAnimated:YES];
        [_chooseZFTable reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
        [hud hideAnimated:YES];
    }];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    alipayArr = [NSMutableArray arrayWithCapacity:0];
//    bankArr = [NSMutableArray arrayWithCapacity:0];
    
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
    title.text = @"选择提现账号";
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
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, KWIDTH, 45)];
    headView.userInteractionEnabled = YES;
    UILabel *alipayLabel = [[UILabel alloc] init];
    alipayLabel.text = @"    添加支付宝账号";
    alipayLabel.font = [UIFont systemFontOfSize:14];
    alipayLabel.userInteractionEnabled = YES;
    [headView addSubview:alipayLabel];
    [alipayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(0);
        make.width.mas_offset(KWIDTH);
        make.height.mas_offset(45);
        make.top.mas_offset(0);
    }];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(alipayView)];
    [alipayLabel addGestureRecognizer:tap];
//    UIView *line = [[UIView alloc] init];
//    line.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];
//    [headView addSubview:line];
//    [line mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_offset(0);
//        make.width.mas_offset(KWIDTH);
//        make.height.mas_offset(0.5);
//        make.top.equalTo(alipayLabel.mas_bottom).offset(0);
//    }];
//    UILabel *bankLabel = [[UILabel alloc] init];
//    bankLabel.text = @"    添加银行卡账号";
//    bankLabel.font = [UIFont systemFontOfSize:14];
//    [headView addSubview:bankLabel];
//    [bankLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_offset(0);
//        make.width.mas_offset(KWIDTH);
//        make.height.mas_offset(45);
//        make.top.equalTo(line.mas_bottom).offset(0);
//    }];
    
    _chooseZFTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, KWIDTH, KHEIGHT-64) style:UITableViewStylePlain];
    _chooseZFTable.delegate = self;
    _chooseZFTable.dataSource = self;
    _chooseZFTable.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    _chooseZFTable.tableHeaderView = headView;
    [self.view addSubview:_chooseZFTable];
 
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    if (section == 0) {
         return alipayArr.count;
//    }else {
////        return bankArr.count;
//    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return  40;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
//    if (section == 0) {
//        UIView *head = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KWIDTH, 0.01)];
//        return head;
//    }else {
        UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KWIDTH, 40)];
        headView.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];
        UILabel *kindLabel = [[UILabel alloc] init];
        kindLabel.frame = CGRectMake(20, 0, 299, 40);
        kindLabel.font = [UIFont systemFontOfSize:14];
         kindLabel.textColor = lightBlackTextColor;
//        if (section == 0) {
            kindLabel.text = @"支付宝";
//        }else{
//            kindLabel.text = @"银行卡";
//        }
        
        [headView addSubview:kindLabel];
        
        return headView;
//    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cellID"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cellID"];
    }
//    cell.imageView.frame = CGRectMake(20, 5, 40, 40);
    cell.textLabel.textColor = lightBlackTextColor;
    cell.detailTextLabel.textColor = lightgrayTextColor;
//    if (indexPath.section == 0) {
        cell.imageView.image = [UIImage imageNamed:@"icon_zfbzf"];
        cell.textLabel.text = [NSString stringWithFormat:@"%@",alipayArr[indexPath.row][@"name"]];
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%@",alipayArr[indexPath.row][@"account"]];
//    }
//    else if(indexPath.section == 1) {
//        cell.textLabel.text = [NSString stringWithFormat:@"%@",bankArr[indexPath.row][@"name"]];
////
//        NSString *text = [NSString stringWithFormat:@"%@",bankArr[indexPath.row][@"bankname"]];
//        NSString *account = [NSString stringWithFormat:@"%@",bankArr[indexPath.row][@"account"]];
//        NSString *apend = [account substringFromIndex:account.length - 4];
//        cell.detailTextLabel.text = [NSString stringWithFormat:@"%@(%@)",text,apend];
//
//        if ([text isEqualToString:@"中国建设银行"]) {
//            cell.imageView.image = [UIImage imageNamed:@"jianhang"];
//        }else if ([text isEqualToString:@"中国银行"]) {
//            cell.imageView.image = [UIImage imageNamed:@"guohang"];
//        }else if ([text isEqualToString:@"中国工商银行"]) {
//            cell.imageView.image = [UIImage imageNamed:@"shanghang"];
//        }else {
//            cell.imageView.image = [UIImage imageNamed:@"nonghang"];
//        }
//    }else {
////        cell.textLabel.text = @"添加支付宝账号";
//    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
//- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return @"删除";
//}
//- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
//    if (indexPath.section != 0) {
//        NSString *sendID;
//        if (indexPath.section == 1) {
//            sendID = [NSString stringWithFormat:@"%@",alipayArr[indexPath.row][@"id"]];
//        }else if (indexPath.section == 2) {
//            sendID = [NSString stringWithFormat:@"%@",bankArr[indexPath.row][@"id"]];
//        }
//        NSDictionary *paramete = @{
//                                   @"id":sendID
//                                   };
//        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//        manager.responseSerializer = [AFJSONResponseSerializer new];
//        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//        NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
//        NSString *token = [user objectForKey:@"userToken"];
//        
//        NSString *url = [NSString stringWithFormat:@"%@%@%@",HTTPUrl,@"/zjapp/v1/AccountManager/AccountManager/DeleteAliAccount/",token];
//        
//        [manager POST:url parameters:paramete progress:^(NSProgress * _Nonnull uploadProgress) {
//            
//        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//            NSLog(@"%@",responseObject);
//            if ([responseObject[@"error_code"] intValue] == 0) {
//                [self requestData];
//            }
//            
//            [hud hideAnimated:YES];
//        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//            NSLog(@"%@",error);
//        }];
//        
//    }
//    
//   
//    
//}

- (void)backButtonClick {
    self.navigationController.navigationBar.hidden = NO;
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
 
//    NSDictionary *dict = @{@"color":color, @"userName":@"haha"};
//     
//
    NSDictionary *dict = [NSDictionary dictionary];
//    if (indexPath.section == 0) {
    
    dict = alipayArr[indexPath.row];

    [[NSNotificationCenter defaultCenter] postNotificationName:@"selectedAlipay" object:nil userInfo:dict];
//    }else {
//        dict = bankArr[indexPath.row];
//        [[NSNotificationCenter defaultCenter] postNotificationName:@"selectedBankPay" object:nil userInfo:dict];
//    }
    [self.navigationController popViewControllerAnimated:YES];
    
}
- (void)alipayView {
    [self.navigationController pushViewController:[AddAccountViewController new] animated:YES];
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
