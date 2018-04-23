//
//  FansViewController.m
//  ZhongJianMalliOS
//
//  Created by 段 on 2017/12/29.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "FansViewController.h"
#import "FansTableViewCell.h"
#import "FansModel.h"

@interface FansViewController ()<UITableViewDelegate,UITableViewDataSource> {
    UIView *lineBottom;
//    NSString *type;
    //是否是最后一页
    BOOL is_noMore;
    //页数
    int _pageNum;
    NSMutableArray *_dataArray;
}

@property (nonatomic,strong)UITableView *fansTableView;
@end

static NSString *fansCellID = @"FansTableViewCell";
@implementation FansViewController


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.barStyle = UIStatusBarStyleDefault;
//    type = @"Red";
    _pageNum = 0;
    is_noMore = NO;
    _dataArray = [NSMutableArray arrayWithCapacity:0];
    
    [self configNav];
//    [self nav];
    [self reqestDatawithType:_type more:is_noMore];
    [self configTableView];
}
- (void)reqestDatawithType:(NSString *)type more:(BOOL)isMore {
    if (!isMore) {
        _pageNum = 0;
        
    }else if(is_noMore == NO)
    {
        _pageNum++;
    }
    if (_pageNum == 0) {
        [_dataArray removeAllObjects];
    }
    NSString *page = [NSString stringWithFormat:@"%d",_pageNum];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer new];
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *token = [user objectForKey:@"userToken"];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSString *url = [NSString stringWithFormat:@"%@%@%@",HTTPUrl,@"/zjapp/v1/MemberShip/GetFansDetails/",token];
    NSDictionary *dic = @{
                          @"type":_type,
                          @"page":page,
                          @"pageNum":@"10"
                          };
    
    [manager GET:url parameters:dic progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"成功=%@",responseObject);
        NSArray *dataArr = [NSArray arrayWithArray:responseObject[@"data"]];
        for (NSDictionary *diction in dataArr) {
            FansModel *model = [[FansModel alloc] init];
            model.HeadPhoto = [NSString stringWithFormat:@"%@%@",HTTPUrl,diction[@"HeadPhoto"]];
            model.Id = [NSString stringWithFormat:@"%@",diction[@"Id"]];
            model.SysID = [NSString stringWithFormat:@"%@",diction[@"SysID"]];
            model.UserName = [NSString stringWithFormat:@"%@",diction[@"UserName"]];
            model.amount = [NSString stringWithFormat:@"%@",diction[@"amount"]];
            [_dataArray addObject:model];
        }
        if (dataArr.count < 10) {
            is_noMore = YES;
        }else
        {
            is_noMore = NO;
        }
        [hud hideAnimated:YES];
        [_fansTableView reloadData];
        [self endRefresh];
  
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [hud hideAnimated:YES];
        [self endRefresh];
        NSLog(@"%@",error);
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
    title.text = _headTitle;
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
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, KWIDTH, 48)];
    headView.backgroundColor = [UIColor whiteColor];
    NSArray *titleArr = @[@"红粉",@"蓝粉",@"黄粉"];
    for (int i = 0; i < titleArr.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(KWIDTH/3*i, 0, KWIDTH/3, 40);
        [button setTitleColor:[UIColor colorWithHexString:@"444444"] forState:UIControlStateNormal];
        [button setTitle:titleArr[i] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:13];
        [button addTarget:self action:@selector(titleLableButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = 100+i;
        CGFloat labelWidth = [button.titleLabel.text sizeWithFont:button.titleLabel.font].width;
        if ( i == 0 ) {
            lineBottom = [[UIView alloc] init];
            lineBottom.backgroundColor = zjTextColor;
            lineBottom.frame = CGRectMake(0, 27, labelWidth, 1);
            [button.titleLabel addSubview:lineBottom];
            
        }else {
        }
        
        [headView addSubview:button];
    }
    UIView *grayView = [[UIView alloc] initWithFrame:CGRectMake(0, 40, KWIDTH, 8)];
    grayView.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];
    [headView addSubview:grayView];
    [self.view addSubview:headView];
}
- (void)configTableView {
    
    _fansTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64 , KWIDTH, KHEIGHT-64 ) style:UITableViewStylePlain];
    _fansTableView.delegate = self;
    _fansTableView.dataSource = self;
    _fansTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _fansTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    _fansTableView.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];
    _fansTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        // 进入刷新状态后会自动调用这个block
        [self reqestDatawithType:_type more:NO];
    }];
    _fansTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [self reqestDatawithType:_type more:YES];
    }];
//     _fansTableView.m.automaticallyHidden = YES;
    [self.view addSubview:_fansTableView];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 64;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FansTableViewCell *cell = [[FansTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:fansCellID];
    if (!cell) {
        cell = [[FansTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:fansCellID];
    }
    FansModel *model = [[FansModel alloc] init];
    model = _dataArray[indexPath.row];
    
    cell.nameLabel.text = model.UserName;
 
    [cell.headIconImage sd_setImageWithURL:[NSURL URLWithString:model.HeadPhoto]];
    cell.nameID.text = [NSString stringWithFormat:@"众健ID:%@",model.SysID];
    cell.contributionNumberLabel.text = model.amount;
    
    return cell;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark --- headRTitle
- (void)titleLableButtonClick:(UIButton *)sender {
    CGFloat labelWidth = [sender.titleLabel.text sizeWithFont:sender.titleLabel.font].width;
    if (sender.tag == 100) {
        
//        NSLog(@"红");
//        type = @"Red";
//        [self reqestDatawithType:type more:NO];
//        lineBottom.frame = CGRectMake(0, 27, labelWidth, 1);
//        [sender.titleLabel addSubview:lineBottom];
//    }else if (sender.tag == 101) {
//        NSLog(@"蓝");
//        lineBottom.frame = CGRectMake(0, 27, labelWidth, 1);
//        type = @"Blue";
//        [self reqestDatawithType:type more:NO];
//        [sender.titleLabel addSubview:lineBottom];
//        
//    }else {
//        NSLog(@"黄");
//        type = @"Yellow";
//        [self reqestDatawithType:type more:NO];
//        lineBottom.frame = CGRectMake(0,27, labelWidth, 1);
//        [sender.titleLabel addSubview:lineBottom];
//  
        
    }
}

#pragma mark 开始进入刷新状态
- (void)endRefresh
{
   
    [_fansTableView.mj_header endRefreshing];
    if (is_noMore == YES) {
        
        _fansTableView.mj_footer.state = MJRefreshStateNoMoreData;
//        _fansTableView.mj_footer.hidden = YES;
    }else {
        [_fansTableView.mj_footer endRefreshing];
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
