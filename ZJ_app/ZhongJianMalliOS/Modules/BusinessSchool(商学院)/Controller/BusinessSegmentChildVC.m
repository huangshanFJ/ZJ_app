//
//  BusinessSegmentChildVC.m
//  ZhongJianMalliOS
//
//  Created by mac_fj on 2018/4/9.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "BusinessSegmentChildVC.h"
#import "BSegmentChildCell.h"

#import "BusniessHomeCellLogic.h"
#import "CourseDetailViewController.h"

#import "DetailTempViewController.h"
#import "BusniessHomeCellModel.h"

@interface BusinessSegmentChildVC ()<UITableViewDelegate,UITableViewDataSource,BusniessHomeCellLogicDelegate>
@property (nonatomic, strong) UITableView *tableV;
@property (nonatomic, strong) NSMutableArray *tableArr;

@property (nonatomic, assign) NSInteger page;
@property (nonatomic, assign) NSInteger pageNum;

@end

@implementation BusinessSegmentChildVC

static NSString *businessSegmentChildCell = @"businessSegmentChildCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置page
    self.page = 0;
    self.pageNum = 20;

//    CGRect frame =CGRectMake(0, 0, self.view.width, self.view.height);
    CGRect frame =CGRectMake(0, 0, self.view.width, self.frame.size.height);
    _tableV = [[UITableView alloc] initWithFrame:frame style:UITableViewStylePlain];
    _tableV.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    _tableV.delegate = self;
    _tableV.dataSource = self;
    [self.view addSubview:_tableV];
    
    //注册cell
    [_tableV registerClass:[BSegmentChildCell class] forCellReuseIdentifier:businessSegmentChildCell];
    
    //table的刷新控件
    [self refreshTableHeader];
    [self loadTableMore];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    //清空table数据
    [self.tableArr removeAllObjects];
    [self requestDataWithStartposition:0 requestcount:self.pageNum];
}

- (void)refreshTableHeader {
    //清空数组
    [self.tableArr removeAllObjects];
    __weak typeof(self) weakSelf = self;
    self.tableV.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
         [weakSelf.tableArr removeAllObjects];
        self.page = 0;
        [weakSelf requestDataWithStartposition:_page requestcount:_pageNum];
    }];
}

- (void)loadTableMore {
    __weak typeof(self) weakSelf = self;
    self.tableV.mj_footer = [MJRefreshAutoFooter footerWithRefreshingBlock:^{
        //记录位置
        self.page ++;
        [weakSelf requestDataWithStartposition:_page requestcount:_pageNum];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark ============ 请求数据 ============
- (void)requestDataWithStartposition:(NSInteger)position requestcount:(NSInteger)count {
    BusniessHomeCellLogic *logic = [[BusniessHomeCellLogic alloc] init];
    logic.delegate = self;
    [logic requestBusniessHomecellDataWithType:_type page:position pageNum:count];
}

#pragma mark ============ uitablviewDataSource ============
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tableArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BSegmentChildCell *cell = [tableView dequeueReusableCellWithIdentifier:businessSegmentChildCell];
    
    BusniessHomeCellModel *model = self.tableArr[indexPath.row];
    
    [cell updateCellContent:model];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 111;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
//    CourseDetailViewController *detailVc = [[CourseDetailViewController alloc] init];
    DetailTempViewController *detailVc = [[DetailTempViewController alloc] init];
    BusniessHomeCellModel *model = self.tableArr[indexPath.row];
    detailVc.courseid = model.uid;
    detailVc.canApply = model.canApply;
    [self.navigationController pushViewController:detailVc animated:YES];
    
}

#pragma mark ============ logic delegate ============
- (void)requestBusniessHomecellDataCompleted:(NSArray *)tableArr {
    
    [self.tableV.mj_header endRefreshing];
    [self.tableV.mj_footer endRefreshing];
    
    NSLog(@"%@",tableArr);
    
    for (BusniessHomeCellModel *model in tableArr) {
        [self.tableArr addObject:model];
    }
    
    //刷新table
    [self.tableV reloadData];
}

#pragma mark ============ lazy ============
- (NSMutableArray *)tableArr {
    if (!_tableArr) {
        _tableArr = [NSMutableArray array];
    }
    return _tableArr;
}




@end
