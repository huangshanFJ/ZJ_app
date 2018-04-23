//
//  CDListViewController.m
//  ZhongJianMalliOS
//
//  Created by mac_fj on 2018/4/9.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "CDListViewController.h"
#import "BDIntroduceListLogic.h"
#import "BDIntroduceListCell.h"
#import "BDIntroduceListModel.h"

@interface CDListViewController () <UITableViewDelegate,UITableViewDataSource,BDIntroduceListLogicDelegate>

@property (nonatomic, strong) UITableView *listTable;
@property (nonatomic, strong) NSArray *tableArr;

@end

@implementation CDListViewController

static NSString *introduceListCell = @"introduceListCell";

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];
    
    [self requestListData];
    
    [self setupTableView];
    
}

- (void)requestListData {
    
    BDIntroduceListLogic *logic = [[BDIntroduceListLogic alloc] init];
    logic.delegate = self;
    [logic requestIntroduceListWithCourseid:self.courseid];
}

- (void)setupTableView {
    
//    CGRect frame =CGRectMake(0, 0, self.view.width, self.view.size.height - 280 - 64 - 5);
    CGRect frame =CGRectMake(0, 5, self.view.width, self.view.size.height);
    _listTable = [[UITableView alloc] initWithFrame:frame style:UITableViewStylePlain];
    _listTable.delegate = self;
    _listTable.dataSource = self;
    _listTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_listTable];
    
    //注册cell
    [_listTable registerClass:[BDIntroduceListCell class] forCellReuseIdentifier:introduceListCell];
    
    //table的刷新控件
    //    [self refreshTableHeader];
    //    [self loadTableMore];
    
}

#pragma mark ============ tableView ============
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section  {
    return self.tableArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    BDIntroduceListCell *cell = [tableView dequeueReusableCellWithIdentifier:introduceListCell];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell updateIntroduceLstWithList:self.tableArr[indexPath.row]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40;
}

#pragma mark ============ logic delegate ============
- (void)requestIntroduceListDataCompletedWithList:(BDIntroduceListModel *)model {
    
    self.tableArr = model.lists;
    [self.listTable reloadData];
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
