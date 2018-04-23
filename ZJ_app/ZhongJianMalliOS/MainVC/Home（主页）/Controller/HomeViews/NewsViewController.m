//
//  NewsViewController.m
//  ZhongJianMalliOS
//
//  Created by 段 on 2017/11/14.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "NewsViewController.h"
#import "NewsTableViewCell.h"

@interface NewsViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *newsTableView;
@end
static NSString *const newsTableViewCellID = @"NewsTableViewCell";

@implementation NewsViewController
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self initNav];
    
    [self creatTable];
}
- (void)initNav {
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
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text = @"消息";
    titleLabel.textAlignment = 1;
    titleLabel.textColor = [UIColor colorWithHexString:@"444444"];
    titleLabel.font = [UIFont systemFontOfSize:17];
    [self.view addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(backButton.mas_centerY).offset(0);
        make.height.mas_offset(44);
        make.right.mas_offset(-50);
        make.left.mas_offset(50);
    }];
    UIButton *deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [deleteButton setBackgroundImage:[UIImage imageNamed:@"empty"] forState:UIControlStateNormal];
    [deleteButton addTarget:self action:@selector(deleteButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:deleteButton];
    [deleteButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-10);
        make.height.mas_offset(20);
        make.width.mas_offset(20);
        make.top.mas_offset(30);
    }];
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = [UIColor colorWithHexString:@"444444"];
    [self.view addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(0);
        make.top.mas_offset(63);
        make.right.mas_offset(0);
        make.height.mas_offset(0.5);
    }];
}

- (void)creatTable {
    
    _newsTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, KWIDTH, KHEIGHT-64) style:UITableViewStylePlain];
    _newsTableView.delegate = self;
    _newsTableView.dataSource = self;
    _newsTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _newsTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:_newsTableView];
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 70;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  
    NewsTableViewCell *cell = [[NewsTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:newsTableViewCellID];
    if (!cell) {
        cell = [[NewsTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:newsTableViewCellID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSArray *timeArr = @[@"11.12",@"12.10",@"120.00"];
    cell.timerLabel.text = timeArr[indexPath.row];
    NSArray *messageArr = @[@"fdfdsf5s4df45ds4f",@"sdadfdsf45ds5f4",@"474474789449489"];
    cell.messageLabel.text = messageArr[indexPath.row];
    NSArray *headImageArr = @[@"news_blue",@"news_blue",@"news_gary"];
    cell.headImage.image = [UIImage imageNamed:headImageArr[indexPath.row]];
    
    return cell;
}
- (void)backButtonClick {
    [self.navigationController popViewControllerAnimated:YES];
    self.navigationController.navigationBar.hidden = NO;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)deleteButtonClick {
    
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
