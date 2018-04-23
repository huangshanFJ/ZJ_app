//
//  MyPurseViewController.m
//  ZhongJianMalliOS
//
//  Created by 段 on 2017/12/20.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "MyPurseViewController.h"
#import "PurseHeadView.h"
#import "PurseTableViewCell.h"
#import "RecordViewController.h"
#import "RechargeViewController.h"
#import "CashWithdrawalsViewController.h"
#import "AttornViewController.h"
#import "UpgradeViewController.h"
#import "DistributaryQuotaViewController.h"
#import "DirectUpgradesViewController.h"
#import "LoginViewController.h"

@interface MyPurseViewController ()<UITableViewDelegate,UITableViewDataSource> {
    NSString *token;
    NSDictionary *dataPurseDic;
    NSArray *kindArr;
}

@property (nonatomic,strong)UITableView *purseTableView;
@end
static NSString *const PurseTableViewCellID = @"PurseTableViewCell";
@implementation MyPurseViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    self.navigationController.navigationBar.barStyle = UIStatusBarStyleLightContent;
    if (token.length > 0) {
        [self getHttpRequest];
    }else {
 
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
//    [self configNav];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    token = [userDefaults objectForKey:@"userToken"];
    dataPurseDic = [NSDictionary dictionary];
   
    
    
    [self configTableView];
}
- (void)getHttpRequest {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer new];
    
    NSString *url = [NSString stringWithFormat:@"%@%@%@",HTTPUrl,@"/zjapp/v1/PersonalCenter/initPersonalWallet/",token];//,token];
    [manager GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"成功=%@",responseObject);
        if ([responseObject[@"error_code"] intValue] == 0) {
//        。；
            if (responseObject[@"data"] != nil) {
                dataPurseDic = responseObject[@"data"];
                NSString *Lev = [NSString stringWithFormat:@"%@",responseObject[@"data"][@"personDataMap"][@"Lev"]];
                if ( [Lev intValue] == 3 ) {
                      kindArr = @[@"购物币",@"现金红包",@"消费积分",@"个人币值",@"分流额度"];
                }else {
                    kindArr = @[@"购物币",@"现金红包",@"消费积分",@"个人币值"];
                }
                
                
                [_purseTableView reloadData];
            }
 
        }else if ([responseObject[@"error_code"] intValue] == 3) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"该账号已在其他手机登陆" message:@"" preferredStyle:UIAlertControllerStyleAlert];
//            [alert addAction:[UIAlertAction actionWithTitle: style: handler:nil]];
            [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                [self.navigationController pushViewController:[LoginViewController new] animated:YES];
            }]];
            [self presentViewController:alert animated:YES completion:nil];
        }
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"失败=%@",error);
    }];
}
#pragma mark -- UI
- (void)configNav {
//    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    [backButton addTarget:self action:@selector(backButtonClick) forControlEvents:UIControlEventTouchUpInside];
//    backButton.tag = 100;
//    [backButton setBackgroundImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
//    [self.view addSubview:backButton];
//    [backButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_offset(10);
//        make.width.mas_offset(20);
//        make.height.mas_offset(20);
//        make.top.mas_offset(30);
//    }];
//    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, KWIDTH, 44)];
//    title.text = @"我的qian'b";
//    title.textAlignment = 1;
//    title.textColor = [UIColor colorWithHexString:@"444444"];
//    title.font = [UIFont systemFontOfSize:17];
//    [self.view addSubview:title];
//    [title mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_offset(20);
//        make.height.mas_offset(44);
//        make.right.mas_offset(-50);
//        make.left.mas_offset(50);
//    }];
//
//    UIView *line = [[UIView alloc] init];
//    line.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];
//    [self.view addSubview:line];
//    [line mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_offset(0);
//        make.right.mas_offset(0);
//        make.top.mas_offset(63);
//        make.height.mas_offset(1);
//    }];

}
- (void)configTableView {
 
    _purseTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KWIDTH, KHEIGHT+20) style:UITableViewStyleGrouped];
    _purseTableView.delegate = self;
    _purseTableView.dataSource = self;
    _purseTableView.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];
    _purseTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_purseTableView];
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return kindArr.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 74;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 385;
}
- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    PurseHeadView *headView = [[PurseHeadView alloc] initWithFrame:CGRectMake(0, 0, KWIDTH, 385)];
    
    if (dataPurseDic != nil) {
//         headView.headImage
        NSString *urlStr = [NSString stringWithFormat:@"%@%@",HTTPUrl,dataPurseDic[@"personDataMap"][@"HeadPhoto"]];
        
        [headView.headImage sd_setImageWithURL:[NSURL URLWithString:urlStr]];
        headView.headNameLabel.text = [NSString stringWithFormat:@"%@",dataPurseDic[@"personDataMap"][@"NickName"]];
        headView.totalWealthLabel.text = [NSString stringWithFormat:@"%.1f",[dataPurseDic[@"personDataMap"][@"RemainElecNum"] doubleValue]];
//        headView.totalWealthLabel.text = [NSString stringWithFormat:@"%@",dataPurseDic[@"personDataMap"][@"RemainElecNum"]];
        NSString *lev = [NSString stringWithFormat:@"%@",dataPurseDic[@"personDataMap"][@"Lev"]];
        NSString *IsSubProxy = [NSString stringWithFormat:@"%@",dataPurseDic[@"personDataMap"][@"IsSubProxy"]];
        NSString *isGCmember = [NSString stringWithFormat:@"%@",dataPurseDic[@"isGCmember"]];
        if ([lev intValue] == 0) {
            if ([isGCmember intValue] == 0) {
                headView.freeImage.image = [UIImage imageNamed:@"free"];
                }else {
                if ([isGCmember integerValue] == 1) {
                    headView.creatTime.text = [NSString stringWithFormat:@"绿色通道到期时间：%@",dataPurseDic[@"GCmemberExpireTime"]];
                    headView.VIPImage.image = [UIImage imageNamed:@"vip_gold"];
                       headView.freeImage.image = [UIImage imageNamed:@"free"];
                }
            }
        }else if ([lev intValue] == 1) {
//            headView.VIPImage.image = [UIImage imageNamed:@"vip_gold"];
            headView.freeImage.image = [UIImage imageNamed:@"free"];
            headView.VIPImage.image = [UIImage imageNamed:@"vip_gold"];
            headView.copartnerImage.image = [UIImage imageNamed:@"partner_gold"];
        }else if ([lev intValue] == 2) {
            if ([IsSubProxy intValue] == 0) {
                headView.freeImage.image = [UIImage imageNamed:@"free"];
                headView.VIPImage.image = [UIImage imageNamed:@"vip_gold"];
                headView.copartnerImage.image = [UIImage imageNamed:@"partner_gold"];
            }else {
                headView.freeImage.image = [UIImage imageNamed:@"free"];
                headView.VIPImage.image = [UIImage imageNamed:@"vip_gold"];
                headView.copartnerImage.image = [UIImage imageNamed:@"partner_gold"];
                headView.baseAgencyImage.image = [UIImage imageNamed:@"quasiagency_gold"];
            }
        }else {
            headView.freeImage.image = [UIImage imageNamed:@"free"];
            headView.VIPImage.image = [UIImage imageNamed:@"vip_gold"];
            headView.copartnerImage.image = [UIImage imageNamed:@"partner_gold"];
            headView.baseAgencyImage.image = [UIImage imageNamed:@"quasiagency_gold"];            
            headView.agencyImage.image = [UIImage imageNamed:@"agent_gold"];
        }
        
    }
    headView.backButtonClickBlock = ^{
        self.navigationController.navigationBar.hidden = NO;
        [self.navigationController popViewControllerAnimated:YES];
    };
    headView.questionButtonClickBlock = ^{
        NSLog(@"问题");
    };
    headView.upgradeButtonClickBlock = ^{
        NSLog(@"升级");
        DirectUpgradesViewController *directVC = [[DirectUpgradesViewController alloc] init];
        [self.navigationController pushViewController:directVC animated:YES];
             
    };
    
    headView.rechargeButtonClickBlock = ^{
        NSLog(@"充值");
        [self.navigationController pushViewController:[RechargeViewController new] animated:YES];
    };
    headView.transferthepossessionofButtonClickBlock = ^{
        NSLog(@"转让");
        AttornViewController *attornVC = [AttornViewController new];
        attornVC.money = [NSString stringWithFormat:@"%.1f",[dataPurseDic[@"personDataMap"][@"RemainElecNum"]doubleValue]];
        [self.navigationController pushViewController:attornVC animated:YES];
    };
    headView.withdrawalsButtonClick = ^{
        NSLog(@"提现");
        CashWithdrawalsViewController *cashVC = [CashWithdrawalsViewController new];
        cashVC.mostMoney = [NSString stringWithFormat:@"%.1f",[dataPurseDic[@"personDataMap"][@"RemainElecNum"] doubleValue]];

        [self.navigationController pushViewController:cashVC animated:YES];
    };
    headView.documentaryfilmButtonClick = ^{
        NSLog(@"记录");
        RecordViewController *recordVC = [RecordViewController new];
        recordVC.showTitleString = @"现金币记录";
        recordVC.typeString = @"elec";
        [self.navigationController pushViewController:recordVC animated:YES];
    };
    
    return headView;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PurseTableViewCell *cell = [[PurseTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:PurseTableViewCellID];
    if (!cell) {
        cell = [[PurseTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:PurseTableViewCellID];
    }
    NSArray *imageArr = @[@"money",@"redenvelopes",@"integral",@"currency",@"shunt"];
    cell.purseImageView.image = [UIImage imageNamed:imageArr[indexPath.row]];
//    NSArray *priceArr = @[@"10000",@"10000",@"10000",@"10000",@"10000"];
//    cell.priceLabel.text = priceArr[indexPath.row];
    if (dataPurseDic != nil) {
       
        if (indexPath.row == 0) {
            cell.priceLabel.text = [NSString stringWithFormat:@"%@",dataPurseDic[@"personDataMap"][@"RemainPoints"]];
        }else if (indexPath.row == 1) {
            cell.priceLabel.text = [NSString stringWithFormat:@"%@",dataPurseDic[@"personDataMap"][@"Coupon"]];

        }else if (indexPath.row == 2) {
            cell.priceLabel.text = [NSString stringWithFormat:@"%@",dataPurseDic[@"personDataMap"][@"RemainVIPAmount"]];

        }else if (indexPath.row == 3){
            cell.priceLabel.text = [NSString stringWithFormat:@"%@",dataPurseDic[@"personDataMap"][@"TotalCost"]];
            cell.nextImage.hidden = YES;
        }
        else {
            cell.priceLabel.text = [NSString stringWithFormat:@"%@",dataPurseDic[@"personDataMap"][@"RemainStream"]];

        }
    }
    
    
    cell.kindPurseLabel.text = kindArr[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
   
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    if (indexPath.row == 0) {
//
//    }
    if (indexPath.row < 3) {
        RecordViewController *recordVC = [RecordViewController new];
        
        if (indexPath.row == 0) {
            recordVC.typeString = @"points";
        }else if (indexPath.row == 1) {
            recordVC.typeString = @"coupon";
        }else {
            recordVC.typeString = @"vip";
        }
        
        recordVC.showTitleString = [NSString stringWithFormat:@"%@记录",kindArr[indexPath.row]];
        [self.navigationController pushViewController:recordVC animated:YES];
    }
  
    
    if (indexPath.row == 4) {
        DistributaryQuotaViewController *dicVC = [DistributaryQuotaViewController new];
        dicVC.showMoney = [NSString stringWithFormat:@"%@",dataPurseDic[@"personDataMap"][@"RemainStream"]];
        [self.navigationController pushViewController:dicVC animated:YES];

    }
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//设置顶部20的部分字体颜色变为白色
- (UIStatusBarStyle)preferredStatusBarStyle{
    
    return UIStatusBarStyleLightContent;
    
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
