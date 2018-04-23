//
//  MyCourseDetailViewController.m
//  ZhongJianMalliOS
//
//  Created by mac_fj on 2018/4/12.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "MyCourseDetailViewController.h"
#import "MyCourseDetailCell.h"
#import "MyCourseDetailCellModel.h"

@interface MyCourseDetailViewController ()<UITableViewDelegate,UITableViewDataSource,MyCourseDetailLogicDelegate>

@property (nonatomic, strong) UITableView *courseDetailTable;
@property (nonatomic, strong) NSMutableArray *couresTableArr;

@property (nonatomic, assign) NSInteger pagePosiotion;
@property (nonatomic, assign) NSInteger pageNum;

@end

@implementation MyCourseDetailViewController

static NSString *myCourseDetailCell = @"myCourseDetailCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //清空数组
    [self.couresTableArr removeAllObjects];
    
    //获取数据页面设置
    self.pagePosiotion = 0;
    self.pageNum = 20;
    
    [self requestLectureDataWithPage:0 pageNum:20];
    
    [self setupTableView];
    
}

- (void)requestLectureDataWithPage:(NSInteger)page pageNum:(NSInteger)pageNum {
    
    MyCourseDetailLogic *logic = [[MyCourseDetailLogic alloc] init];
    logic.delegate = self;
    [logic requestMyCourseDatailWithType:self.type page:page pageNum:pageNum];
}

- (void)setupTableView {
    
    CGRect frame =CGRectMake(0, 0, self.view.width, self.view.size.height - 64-35);
    _courseDetailTable = [[UITableView alloc] initWithFrame:frame style:UITableViewStylePlain];
    _courseDetailTable.delegate = self;
    _courseDetailTable.dataSource = self;
    [self.view addSubview:_courseDetailTable];
    
    //注册cell
    [_courseDetailTable registerClass:[MyCourseDetailCell class] forCellReuseIdentifier:myCourseDetailCell];
    
    //去除cell分割线
    _courseDetailTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    //table的刷新控件
        [self refreshTableHeader];
        [self loadTableMore];
    
}

#pragma mark ============ 上下拉刷新 ============
- (void)refreshTableHeader {
    //清空数组
    [self.couresTableArr removeAllObjects];
    __weak typeof(self) weakSelf = self;
    self.courseDetailTable.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.pagePosiotion = 0;
        [weakSelf requestLectureDataWithPage:_pagePosiotion pageNum:_pageNum];
    }];
}

- (void)loadTableMore {
    __weak typeof(self) weakSelf = self;
    self.courseDetailTable.mj_footer = [MJRefreshAutoFooter footerWithRefreshingBlock:^{
        //记录位置
        self.pagePosiotion ++;
        [weakSelf requestLectureDataWithPage:_pagePosiotion pageNum:_pageNum];
    }];
}

#pragma mark ============ tableview  ============
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.couresTableArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MyCourseDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:myCourseDetailCell];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;//cell不可点击
    [cell updateCourseDetailCellWithModel:self.couresTableArr[indexPath.row]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}


#pragma mark ============ logic delegate ============
- (void)requestMyCourseDatailCompletedWithCourseModels:(MyCourseModels *)models {
    
    [self.courseDetailTable.mj_header endRefreshing];
    [self.courseDetailTable.mj_footer endRefreshing];
    
    
    for (MyCourseDetailCellModel *model in models.courses) {
        [self.couresTableArr addObject:model];
    }
    
    NSArray *a = self.couresTableArr;
    NSLog(@"%@",self.couresTableArr);
    
    [self.courseDetailTable reloadData];
    
}

#pragma mark ============ lazy ============
- (NSMutableArray *)couresTableArr {
    if (!_couresTableArr) {
        _couresTableArr = [NSMutableArray array];
    }
    return _couresTableArr;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
