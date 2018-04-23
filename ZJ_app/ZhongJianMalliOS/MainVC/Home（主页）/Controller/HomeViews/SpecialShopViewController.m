//
//  SpecialShopViewController.m
//  ZhongJianMalliOS
//
//  Created by 段 on 2017/11/9.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "SpecialShopViewController.h"
#import "SpecialShopTableViewCell.h"
#import "JKBannarView.h"

@interface SpecialShopViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UITableView *shopTableView;
@end
static NSString *const specialCellID = @"SpecialShopTableViewCell";
@implementation SpecialShopViewController
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self creatNavUI];
    [self creatTableView];
    
}
- (void)creatNavUI {
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
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, KWIDTH, 44)];
    _titleLabel.text = @"11111";
    _titleLabel.textAlignment = 1;
    _titleLabel.textColor = [UIColor colorWithHexString:@"444444"];
    _titleLabel.font = [UIFont systemFontOfSize:17];
    [self.view addSubview:_titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(20);
        make.height.mas_offset(44);
        make.right.mas_offset(-50);
        make.left.mas_offset(50);
    }];
}
- (void)creatTableView {
    
    _shopTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, KWIDTH, KHEIGHT-64) style:UITableViewStylePlain];
    _shopTableView.delegate = self;
    _shopTableView.dataSource = self;
    _shopTableView.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];
    _shopTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    NSMutableArray *imageViews = [[NSMutableArray alloc]init];
    [imageViews addObjectsFromArray:@[@"banner",@"banner1",@"banner2"]];
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KWIDTH, KWIDTH/2+7)];
    JKBannarView *bannerView = [[JKBannarView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), self.view.frame.size.width/2) viewSize:CGSizeMake(CGRectGetWidth(self.view.bounds),self.view.frame.size.width/2)];
    bannerView.items = imageViews;
    //            [self.view addSubview:bannerView];
    
    [bannerView imageViewClick:^(JKBannarView * _Nonnull barnerview, NSInteger index) {
        NSLog(@"点击图片%ld",(long)index);
        //        [self pushNext];
    }];
    headView.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];
    [headView addSubview:bannerView];
    _shopTableView.tableHeaderView = headView;
    
    _shopTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:_shopTableView];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 188;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SpecialShopTableViewCell *cell = [[SpecialShopTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:specialCellID];
    if (!cell) {
        cell = [[SpecialShopTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:specialCellID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSArray *shopImage = @[@"picture1",@"picture2"];
    cell.shopImage.image = [UIImage imageNamed:shopImage[indexPath.row]];
    NSArray *nameArr = @[@"159天然210215454484848素",@"天然野生木耳"];
    cell.shopName.text = nameArr[indexPath.row];
    NSArray *priceArr = @[@"￥ 120",@"￥ 130"];
    cell.priceLabel.textColor = [UIColor colorWithHexString:@"fa3636"];
    NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:priceArr[indexPath.row]];
    [AttributedStr addAttribute:NSFontAttributeName
                          value:[UIFont systemFontOfSize:10.0]
                          range:NSMakeRange(0, 2)];
    [AttributedStr addAttribute:NSFontAttributeName
                          value:[UIFont fontWithName:@"Arial Rounded MT Bold" size:17]
                          range:NSMakeRange(2, 3)];
    cell.priceLabel.attributedText = AttributedStr;
    NSArray *numberArr = @[@"100人购买",@"300人购买"];
    cell.peopleLabel.text = numberArr[indexPath.row];
    
    cell.miniteLabel.text = @"50";
    cell.buyButtonClick = ^{
        [self buyClick];
    };
    cell.purchaseButtonClick = ^{
        [self purchaseClick];   
    };
    
    return cell;
}
- (void)buyClick {
    
}
- (void)purchaseClick {
    
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
