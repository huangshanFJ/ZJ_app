//
//  FansNumberViewController.m
//  ZhongJianMalliOS
//
//  Created by 段 on 2018/2/2.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "FansNumberViewController.h"
#import "FansNumberCell.h"
#import "FansViewController.h"

@interface FansNumberViewController ()<UITableViewDelegate,UITableViewDataSource> {
    
    NSDictionary *dataDic;
}

@property (nonatomic,strong)UITableView *fansTable;

@end

@implementation FansNumberViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.barStyle = UIStatusBarStyleDefault;
    dataDic = [NSDictionary dictionary];
    [self configNav];
    [self nav];
    [self reqestData];
    [self configTableView];

    
}
- (void)reqestData {
//    NSString *page = [NSString stringWithFormat:@"%d",_pageNum];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer new];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSUserDefaults *use = [NSUserDefaults standardUserDefaults];
    NSString *token = [use objectForKey:@"userToken"];
    
    NSString *url = [NSString stringWithFormat:@"%@%@%@",HTTPUrl,@"/zjapp/v1/MemberShip/GetFans/",token];
    [manager GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",responseObject);
        if ([responseObject[@"error_code"] intValue] == 0) {
            dataDic = responseObject[@"data"];
        }
        [_fansTable reloadData];
        [hud hideAnimated:YES];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
        [hud hideAnimated:YES];
    }];
    
    
    
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
    title.text = @"粉丝";
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
- (void)nav {
//    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, KWIDTH, 48)];
//    headView.backgroundColor = [UIColor whiteColor];
//    NSArray *titleArr = @[@"红粉",@"蓝粉",@"黄粉"];
//    for (int i = 0; i < titleArr.count; i++) {
//        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
//        button.frame = CGRectMake(KWIDTH/3*i, 0, KWIDTH/3, 40);
//        [button setTitleColor:[UIColor colorWithHexString:@"444444"] forState:UIControlStateNormal];
//        [button setTitle:titleArr[i] forState:UIControlStateNormal];
//        button.titleLabel.font = [UIFont systemFontOfSize:13];
//        [button addTarget:self action:@selector(titleLableButtonClick:) forControlEvents:UIControlEventTouchUpInside];
//        button.tag = 100+i;
//        CGFloat labelWidth = [button.titleLabel.text sizeWithFont:button.titleLabel.font].width;
//        if ( i == 0 ) {
//            lineBottom = [[UIView alloc] init];
//            lineBottom.backgroundColor = zjTextColor;
//            lineBottom.frame = CGRectMake(0, 27, labelWidth, 1);
//            [button.titleLabel addSubview:lineBottom];
//
//        }else {
//        }
//
//        [headView addSubview:button];
//    }
//    UIView *grayView = [[UIView alloc] initWithFrame:CGRectMake(0, 40, KWIDTH, 8)];
//    grayView.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];
//    [headView addSubview:grayView];
//    [self.view addSubview:headView];
}
- (void)configTableView {
    
    _fansTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, KWIDTH, KHEIGHT-64) style:UITableViewStylePlain];
    _fansTable.delegate = self;
    _fansTable.dataSource = self;
    _fansTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    _fansTable.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    _fansTable.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];
 
    [self.view addSubview:_fansTable];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 45;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    FansNumberCell *cell = [[FansNumberCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"FansNumberCell"];
    if (!cell) {
         cell = [[FansNumberCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"FansNumberCell"];
    }
    if (indexPath.row == 0) {
        cell.kindNameLabel.text = @"红粉";
//        cell.kindNameLabel.textColor = [UIColor redColor];
        cell.numberLabel.text = [NSString stringWithFormat:@"%@人",dataDic[@"Red"]];
        
    }else if (indexPath.row == 1){
        cell.kindNameLabel.text = @"蓝粉";
//        cell.kindNameLabel.textColor = [UIColor blueColor];
        cell.numberLabel.text = [NSString stringWithFormat:@"%@人",dataDic[@"Blue"]];

    }else {
        cell.kindNameLabel.text = @"黄粉";
//        cell.kindNameLabel.textColor = [UIColor yellowColor];
        cell.numberLabel.text = [NSString stringWithFormat:@"%@人",dataDic[@"Yellow"]];

    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    FansViewController *fanVC = [[FansViewController alloc] init];
    if (indexPath.row == 0) {
        fanVC.headTitle = @"红粉";
        fanVC.type = @"Red";
        
    }else if (indexPath.row == 1) {
        fanVC.headTitle = @"蓝粉";
        fanVC.type = @"Blue";
    }else {
        fanVC.headTitle = @"黄粉";
        fanVC.type = @"Yellow";
    }
    [self.navigationController pushViewController:fanVC animated:YES];
    
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
