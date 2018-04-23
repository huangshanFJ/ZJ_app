//
//  SendGiftViewController.m
//  ZhongJianMalliOS
//
//  Created by 段 on 2018/1/30.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "SendGiftViewController.h"
#import "SendGiftTableViewCell.h"
#import "GiveAGiftViewController.h"

@interface SendGiftViewController ()<UITableViewDelegate,UITableViewDataSource> {
    NSString *selectedType;
    UIView *lineBottom;
    
    NSMutableArray *dataArray;
}

@property (nonatomic,strong)UITableView *sendGiftTable;

@end
static NSString *giftCellID = @"SendGiftTableViewCell";
@implementation SendGiftViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.barStyle = UIStatusBarStyleDefault;
    dataArray = [NSMutableArray arrayWithCapacity:0];
    
    [self configNav];
    
    [self headView];
    selectedType = @"1";
    [self requestDataWithType:selectedType];
    
    [self configTableView];
}
- (void)requestDataWithType:(NSString *)type {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer new];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *token = [user objectForKey:@"userToken"];
    NSString *url = [NSString stringWithFormat:@"%@%@%@",HTTPUrl,@"/zjapp/v1/MemberShip/GetPresent/",token];
    NSDictionary *parame = @{
                             @"type":type
                             };
    
    [manager GET:url parameters:parame progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",responseObject);
        if ([responseObject[@"error_code"] integerValue] == 0) {
            dataArray = [NSMutableArray arrayWithArray:responseObject[@"data"]];
        }
        [_sendGiftTable reloadData];
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
    title.text = @"名额赠送";
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
- (void)headView {
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, KWIDTH, 47)];
    headView.backgroundColor = [UIColor whiteColor];
    NSArray *titleArr = @[@"未赠送",@"已赠送"];
    for (int i = 0; i < titleArr.count; i++) {
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake((KWIDTH-20)/titleArr.count*i, 10, KWIDTH/titleArr.count, 30);
        [button setTitleColor:[UIColor colorWithHexString:@"444444"] forState:UIControlStateNormal];
        [button setTitle:titleArr[i] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:13];
        button.tag = 200+i;
        [button addTarget:self action:@selector(titleLableButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        CGFloat labelWidth = [button.titleLabel.text sizeWithFont:button.titleLabel.font].width;
       
        if ( i == 0 ) {
            lineBottom = [[UIView alloc] init];
            lineBottom.backgroundColor = zjTextColor;
            
            lineBottom.frame = CGRectMake(0, 21, labelWidth, 1);
            [button.titleLabel addSubview:lineBottom];
//            [button setTitleColor:zjTextColor forState:UIControlStateSelected];
        }else {
        }
         //        if (i == 4) {
        //            [button setTitleEdgeInsets:UIEdgeInsetsMake(0, -13, 0,13)];
        //        }
        
        [headView addSubview:button];
        
    }
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 40, KWIDTH, 1)];
    line.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];
    [headView addSubview:line];
    
    [self.view addSubview:headView];
}

- (void)configTableView {
    _sendGiftTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 111, KWIDTH, KHEIGHT-111) style:UITableViewStylePlain];
    _sendGiftTable.delegate = self;
    _sendGiftTable.dataSource = self;
    _sendGiftTable.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    [self.view addSubview:_sendGiftTable];
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SendGiftTableViewCell *cell = [[SendGiftTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:giftCellID];
    if (!cell) {
        cell = [[SendGiftTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:giftCellID];
    }
    if (dataArray.count > 0 ) {
        NSString *lev = [NSString stringWithFormat:@"%@",dataArray[indexPath.row][@"Lev"]];
        if ([lev integerValue] == 1) {
            cell.levLabel.text = [NSString stringWithFormat:@"等级：VIP"];
        }
        
        if ([selectedType integerValue] == 1) {
            
            [cell.sendButton setTitle:@"赠送" forState:UIControlStateNormal];
            
            NSString *canuse = [NSString stringWithFormat:@"%@",dataArray[indexPath.row][@"canUse"]];
            if ([canuse integerValue] == 1) {
                cell.sendButton.backgroundColor = zjTextColor;
                //        cell.sendButton.userInteractionEnabled = YES;
                cell.sendLabel.hidden = YES;
            }else {
                cell.sendButton.backgroundColor = lightgrayTextColor;
                //        cell.sendButton.userInteractionEnabled = YES;
                cell.sendLabel.hidden = NO;
            }
           
            cell.sendGiftButtonClickBlock = ^{
                GiveAGiftViewController *giftView = [[GiveAGiftViewController alloc] init];
                giftView.sendID = [NSString stringWithFormat:@"%@",dataArray[indexPath.row][@"Id"]];
                [self.navigationController pushViewController:giftView animated:YES];
                
            };
            
        }else {
            [cell.sendButton setTitle:@"已赠送" forState:UIControlStateNormal];
            cell.sendButton.backgroundColor = lightgrayTextColor;
            //        cell.sendButton.userInteractionEnabled = NO;
            cell.sendLabel.hidden = NO;
            NSLog(@"%@",[NSString stringWithFormat:@"被赠送人：%@",dataArray[indexPath.row][@"SysID"]]);
            cell.sendLabel.text = [NSString stringWithFormat:@"被赠送人：%@",dataArray[indexPath.row][@"SysID"]];
            
            
        }

    }
   
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)titleLableButtonClick:(UIButton *)sender {
    CGFloat labelWidth = [sender.titleLabel.text sizeWithFont:sender.titleLabel.font].width;
    
    if (sender.tag == 200) {
        lineBottom.frame = CGRectMake(0, 21, labelWidth, 1);
        
        [sender.titleLabel addSubview:lineBottom];
        selectedType = @"1";
 
        [self requestDataWithType:selectedType];
        
    }else {
        lineBottom.frame = CGRectMake(0, 21, labelWidth, 1);
        [sender.titleLabel addSubview:lineBottom];
        selectedType = @"2";
        //        [_dataArray removeAllObjects];
        [self requestDataWithType:selectedType];
    }
    
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
