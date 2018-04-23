//
//  NewRegisterViewController.m
//  ZhongJianMalliOS
//
//  Created by 段 on 2017/11/13.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "NewRegisterViewController.h"
#import "NewRegistHeadView.h"
#import "NewRegisterGetTableViewCell.h"

@interface NewRegisterViewController ()<UITableViewDelegate,UITableViewDataSource>{
    UITableView *newRegistTableView;

}


@end
static NSString *const newCellID = @"NewRegisterGetTableViewCell";

@implementation NewRegisterViewController
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
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, KWIDTH, 44)];
    titleLabel.text = @"新人专享";
    titleLabel.textAlignment = 1;
    titleLabel.textColor = [UIColor colorWithHexString:@"444444"];
    titleLabel.font = [UIFont systemFontOfSize:17];
    [self.view addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(20);
        make.height.mas_offset(44);
        make.right.mas_offset(-50);
        make.left.mas_offset(50);
    }];
    
}
- (void)creatTable {
    
    newRegistTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, KWIDTH, KHEIGHT-64) style:UITableViewStylePlain];
    newRegistTableView.dataSource = self;
    newRegistTableView.delegate = self;
    newRegistTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    newRegistTableView.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];;
    [self.view addSubview:newRegistTableView];
    NewRegistHeadView *newRegist = [[NewRegistHeadView alloc] initWithFrame:CGRectMake(0, 0, KWIDTH, 217)];
    newRegistTableView.tableHeaderView = newRegist;
    newRegistTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section  {
    return 2;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 217;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 140;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NewRegisterGetTableViewCell *cell = [[NewRegisterGetTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:newCellID];
    if (!cell) {
        cell = [[NewRegisterGetTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:newCellID];
    }
    NSArray *textArr = @[@"全场通用券",@"保健品专区红包"];
    cell.couponLabel.text = textArr[indexPath.row];
    NSArray *manjianArr = @[@"满1000可用",@"满1000可用"];
    cell.priceLabel.text = manjianArr[indexPath.row];
    NSArray *priceArr = @[@"￥ 120",@"￥ 130"];
    cell.priceLabel.textColor = [UIColor colorWithHexString:@"fa3636"];
    NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:priceArr[indexPath.row]];
    [AttributedStr addAttribute:NSFontAttributeName
                          value:[UIFont systemFontOfSize:14.0]
                          range:NSMakeRange(0, 2)];
    [AttributedStr addAttribute:NSFontAttributeName
                          value:[UIFont fontWithName:@"Arial Rounded MT Bold" size:30]
                          range:NSMakeRange(2, 3)];
    cell.priceNumber.attributedText = AttributedStr;
    NSArray *timerArr = @[@"2017.10-10000",@"20122.21545.1"];
    cell.timerLabel.text = timerArr[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)backButtonClick {
    [self.navigationController popViewControllerAnimated:YES];
    self.navigationController.navigationBar.hidden = NO;
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
