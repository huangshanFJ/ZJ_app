//
//  AdressViewController.m
//  ZhongJianMalliOS
//
//  Created by 段 on 2017/12/12.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "AdressViewController.h"
#import "AdressCell.h"
#import "AddNewAdressViewController.h"
#import "EditViewController.h"
@interface AdressViewController ()<UITableViewDataSource,UITableViewDelegate> {
    
//    NSDictionary *dataDiction;
    NSArray *dataArray;
    
}

@property (nonatomic,strong)UITableView *selectedAdressTable;
@end
static NSString *const adressCellID = @"AdressCell";
@implementation AdressViewController
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    [self requestData];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];
//    dataDiction = [NSDictionary dictionary];
    dataArray = [NSArray array];
    [self setNav];
    
   
    [self creatTableView];
    
    [self setBottomView];
}
- (void)requestData {
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *token = [user objectForKey:@"userToken"];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer new];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSString *url = [NSString stringWithFormat:@"%@%@%@",HTTPUrl,@"/zjapp/v1/AddressManager/getAllAddressOfUser/",token];
 
    [manager GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"-=-=-=-%@",responseObject);
        if ([responseObject[@"error_code"] intValue] == 0) {
//            dataDiction = responseObject[@"data"];
            dataArray = [NSArray arrayWithArray:responseObject[@"data"]];
            
        }
        [_selectedAdressTable reloadData];
        
        [hud hideAnimated:YES];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
        [hud hideAnimated:YES];
        
    }];
    
    
    
}
#pragma mark -- UI
- (void)setNav {
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
    title.text = @"请选择收货地址";
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
- (void)creatTableView {
    _selectedAdressTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, KWIDTH, KHEIGHT-64-45) style:UITableViewStylePlain];
    _selectedAdressTable.delegate = self;
    _selectedAdressTable.dataSource = self;
    _selectedAdressTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    _selectedAdressTable.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KWIDTH, KHEIGHT-64-44-95*dataArray.count)];
    _selectedAdressTable.tableFooterView.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];
    [self.view addSubview:_selectedAdressTable];

}
- (void)setBottomView {
    UIView *bottomView = [[UIView alloc] init];
    bottomView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(0);
        make.width.mas_offset(KWIDTH);
        make.bottom.mas_offset(0);
        make.height.mas_offset(45);
    }];
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];
    [bottomView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(0);
        make.right.mas_offset(0);
        make.top.equalTo(bottomView.mas_top).offset(0);
        make.height.mas_offset(1);
    }];
    UILabel *addLabel = [[UILabel alloc] init];
    addLabel.text = @"添加新地址";
    addLabel.font = [UIFont systemFontOfSize:14];
    addLabel.textColor = lightBlackTextColor;
    addLabel.textAlignment = 1;
    [bottomView addSubview:addLabel];
    [addLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_offset(0);
        make.height.mas_offset(45);
        make.top.equalTo(bottomView.mas_top).offset(0);
    }];
    UIImageView *addImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"add"]];
    [bottomView addSubview:addImage];
    [addImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(addLabel.mas_left).offset(-10);
        make.height.mas_offset(15);
        make.width.mas_offset(15);
        make.centerY.equalTo(bottomView.mas_centerY).offset(0);
    }];
    
    UIButton *addAdressButton = [UIButton buttonWithType:UIButtonTypeCustom];
    addAdressButton.backgroundColor = [UIColor clearColor];
 
    [addAdressButton addTarget:self action:@selector(addAdressButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:addAdressButton];
    [addAdressButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_offset(0);
        make.width.mas_offset(KWIDTH);
        make.height.mas_offset(45);
        make.bottom.mas_offset(0);
    }];
    
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return dataArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 7;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KWIDTH, 7)];
    headView.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];
    return headView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 95;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AdressCell *cell = [[AdressCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:adressCellID];
    if (!cell) {
        cell = [[AdressCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:adressCellID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.selectedButtonButtonBlock = ^{
        if (cell.selectedButton.selected == YES) {
//

        }else{
//
        }
    };
    cell.adreeNameLabel.text = [NSString stringWithFormat:@"%@",dataArray[indexPath.section][@"Name"]];
    cell.adreePhoneLabel.text = [NSString stringWithFormat:@"%@",dataArray[indexPath.section][@"Phone"]];
    cell.detailAdressLabel.text = [NSString stringWithFormat:@"%@%@%@%@",dataArray[indexPath.section][@"ProvinceName"],dataArray[indexPath.section][@"CityName"],dataArray[indexPath.section][@"RegionName"],dataArray[indexPath.section][@"DetailAddress"]];
    cell.deleteButtionButtonClick = ^{
        NSLog(@"删除");
        [self deleteAdress:[NSString stringWithFormat:@"%@",dataArray[indexPath.section][@"Id"]]];
    };
  
    return cell;
}
- (void)deleteAdress:(NSString *)adressID {
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *token = [user objectForKey:@"userToken"];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer=[AFJSONRequestSerializer serializer];
    
    [manager.requestSerializer setValue:@"application/json"
                     forHTTPHeaderField:@"Content-Type"];
    manager.responseSerializer = [AFJSONResponseSerializer new];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    int addresid = [adressID intValue];
    NSNumber *addreNum = [NSNumber numberWithInt:addresid];
    NSString *url = [NSString stringWithFormat:@"%@%@",HTTPUrl,@"/zjapp/v1/AddressManager/deleteAddressById"];
    NSDictionary *dic = @{
                          @"id":addreNum,
                          @"token":token
                          };
    
    [manager POST:url parameters:dic progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"-=-=-=-%@",responseObject);
        if ([responseObject[@"error_code"] intValue] == 0) {
         
            [self requestData];
            
        }
//
        
        [hud hideAnimated:YES];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
        [hud hideAnimated:YES];
        
    }];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([_fromVCid intValue] == 1) {
        
        NSString *adreeNameLabeltext = [NSString stringWithFormat:@"%@",dataArray[indexPath.section][@"Name"]];
        NSString *adreePhoneLabeltext = [NSString stringWithFormat:@"%@",dataArray[indexPath.section][@"Phone"]];
//        NSString *detailAdressLabeltext = [NSString stringWithFormat:@"%@%@%@%@",,];
        NSDictionary *dict = @{
                               @"Id":dataArray[indexPath.section][@"Id"],
                               @"Name":adreeNameLabeltext,
                               @"Phone":adreePhoneLabeltext,
                               @"ProvinceName":dataArray[indexPath.section][@"ProvinceName"],
                               @"CityName":dataArray[indexPath.section][@"CityName"],
                               @"RegionName":dataArray[indexPath.section][@"RegionName"],
                               @"DetailAddress":dataArray[indexPath.section][@"DetailAddress"]
                               };

        [[NSNotificationCenter defaultCenter] postNotificationName:@"selectedAdress" object:nil userInfo:dict];
        [self backButtonClick];
    }else {
        EditViewController *editVC = [EditViewController new];
        editVC.addressID = [NSString stringWithFormat:@"%@",dataArray[indexPath.section][@"Id"]];
        [self.navigationController pushViewController:editVC animated:YES];
    }
   
}
- (void)addAdressButtonClick:(UIButton *)sender {
    NSLog(@"添加");
    AddNewAdressViewController *addNewVC = [[AddNewAdressViewController alloc] init];
    [self.navigationController pushViewController:addNewVC animated:YES];
}
#pragma mark -- 返回事件
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
