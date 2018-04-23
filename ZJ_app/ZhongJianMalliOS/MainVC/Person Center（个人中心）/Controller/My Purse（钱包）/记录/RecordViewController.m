//
//  RecordViewController.m
//  ZhongJianMalliOS
//
//  Created by 段 on 2017/12/25.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "RecordViewController.h"
#import "RecordCell.h"
#import "RecordModel.h"

@interface RecordViewController ()<UITableViewDelegate,UITableViewDataSource> {
    
    NSMutableArray *_dataArray;
    //是否是最后一页
    BOOL is_noMore;
    //页数
    int _pageNum;
}

@property (nonatomic,strong)UITableView *recordTableView;

@end
static NSString *const recordCellID = @"RecordCell";
@implementation RecordViewController


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    [self reqestDatawithType:_typeString more:is_noMore];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.barStyle = UIStatusBarStyleDefault;
    _pageNum = 0;
    is_noMore = NO;
    _dataArray = [NSMutableArray arrayWithCapacity:0];
    [self configNav];
    
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
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer new];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *token = [userDefaults objectForKey:@"userToken"];
    
    NSString *url = [NSString stringWithFormat:@"%@%@%@",HTTPUrl,@"/zjapp/v1/PersonalCenter/accountBill/",token];
    NSDictionary *dic = @{
                          @"token":token,
                          @"type":_typeString,
                          @"page":page,
                          @"pageNum":@"10"
                          };
    
    [manager GET:url parameters:dic progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"成功=%@",responseObject);
        if ([responseObject[@"error_code"] intValue] == 0) {
             NSArray *dataArr = [NSArray arrayWithArray:responseObject[@"data"]];
//            _dataArray = [NSMutableArray arrayWithArray:responseObject[@"data"]];
               for (NSDictionary *diction in dataArr) {
                   RecordModel *model = [[RecordModel alloc] init];
                   model.addSub = [NSString stringWithFormat:@"%@",diction[@"addSub"]];
                   model.amount = [NSString stringWithFormat:@"%@",diction[@"amount"]];
                   model.createTime = [NSString stringWithFormat:@"%@",diction[@"createTime"]];
                   model.memo = [NSString stringWithFormat:@"%@",diction[@"memo"]];
                   [_dataArray addObject:model];
               }
            if (dataArr.count < 10) {
                is_noMore = YES;
            }else
            {
                is_noMore = NO;
            }
            [hud hideAnimated:YES];
            [_recordTableView reloadData];
            [self endRefresh];
            
            if (_dataArray.count > 0) {
//                [_recordTableView reloadData];
            }else {
                _recordTableView.hidden = YES;
                UILabel *label = [[UILabel alloc] init];
                label.text = @"暂无数据";
                label.textAlignment = 1;
                label.textColor = lightgrayTextColor;
                label.frame = CGRectMake(0, 100, KWIDTH, 40);
                [self.view addSubview:label];
                
            }
            
            
        }
        
        
       
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"失败= %@",error);
        [hud hideAnimated:YES];
        [self endRefresh];
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
    title.text = _showTitleString;//@"现金币记录";
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
- (void)configTableView {
    _recordTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, KWIDTH, KHEIGHT-64) style:UITableViewStylePlain];
    _recordTableView.delegate = self;
    _recordTableView.dataSource = self;
    _recordTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    _recordTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        // 进入刷新状态后会自动调用这个block
        [self reqestDatawithType:_typeString more:NO];
    }];
    _recordTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [self reqestDatawithType:_typeString more:YES];
    }];
    [self.view addSubview:_recordTableView];
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArray.count;
}
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//    return 2;
//}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 63;
}
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
//    return 30;
//}
//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
//    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KWIDTH, 30)];
//    headView.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];
//    UILabel *headLabel = [[UILabel alloc] init];
//    headLabel.text = @"本月";
//    headLabel.font = [UIFont systemFontOfSize:12];
//    headLabel.textColor = lightgrayTextColor;
//    [headView addSubview:headLabel];
//    [headLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_offset(10);
//        make.height.mas_offset(30);
//        make.top.mas_offset(0);
//
//    }];
//
//    return headView;
//}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RecordCell *cell = [[RecordCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:recordCellID];
    if (!cell) {
        cell = [[RecordCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:recordCellID];
    }
//    cell.headImageView.image = [UIImage imageNamed:@"picture1"];
    
    if (_dataArray.count > 0) {
        RecordModel *model = [[RecordModel alloc] init];
        model = _dataArray[indexPath.row];
        
        cell.kindNameLabel.text = model.memo;//[NSString stringWithFormat:@"%@",_dataArray[indexPath.row][@"memo"]];
        cell.timeLabel.text = model.createTime;//[NSString stringWithFormat:@"%@",_dataArray[indexPath.row][@"createTime"]];
        cell.priceLabel.text = [NSString stringWithFormat:@"%@%@",model.addSub,model.amount];//_dataArray[indexPath.row][@"addSub"],_dataArray[indexPath.row][@"amount"]];
    }
 
    
    return cell;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)backButtonClick {
    self.navigationController.navigationBar.hidden = NO;
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark 开始进入刷新状态
- (void)endRefresh
{
    
    [_recordTableView.mj_header endRefreshing];
    if (is_noMore == YES) {
        
        _recordTableView.mj_footer.state = MJRefreshStateNoMoreData;
        //        _fansTableView.mj_footer.hidden = YES;
    }else {
        [_recordTableView.mj_footer endRefreshing];
    }
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
