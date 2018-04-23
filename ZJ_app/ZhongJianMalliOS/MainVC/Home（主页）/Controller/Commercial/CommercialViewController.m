//
//  CommercialViewController.m
//  ZhongJianMalliOS
//
//  Created by 段 on 2017/12/5.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "CommercialViewController.h"
#import "JKBannarView.h"
#import "CommercialCell.h"
#import "CourseIntroductionViewController.h"

@interface CommercialViewController ()<UITableViewDelegate,UITableViewDataSource> {
    UIView *lineBottom;
}

@property (nonatomic,strong)UITableView *commercialTable;
@end
static NSString *commercialCellID = @"CommercialCell";
@implementation CommercialViewController
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self initNav];
    
    [self initTopView];
    
    [self initTableView];
    
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
    titleLabel.text = @"商学院";
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
   
    UIView *bottomView = [[UIView alloc] init];
    bottomView.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];
    [self.view addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(0);
        make.bottom.mas_offset(-1);
        make.height.mas_offset(1);
        make.right.mas_offset(0);
    }];
    
}
- (void)initTopView {
    NSMutableArray *imageViews = [[NSMutableArray alloc]init];
    [imageViews addObjectsFromArray:@[@"banner",@"banner1",@"banner2"]];
    JKBannarView *bannerView = [[JKBannarView alloc]initWithFrame:CGRectMake(0, 64, CGRectGetWidth(self.view.bounds), 188) viewSize:CGSizeMake(CGRectGetWidth(self.view.bounds),188)];
    bannerView.items = imageViews;
    
    [bannerView imageViewClick:^(JKBannarView * _Nonnull barnerview, NSInteger index) {
        NSLog(@"点击图片%ld",(long)index);
        //        [self pushNext];
    }];
    [self.view addSubview:bannerView];
}
- (void)initTableView
{
    _commercialTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 64+188, KHEIGHT-64-188, KWIDTH) style:UITableViewStylePlain];
    _commercialTable.delegate = self;
    _commercialTable.dataSource = self;
    _commercialTable.backgroundColor = [UIColor whiteColor];
    _commercialTable.separatorStyle = UITableViewCellSeparatorStyleNone;

    [self.view addSubview:_commercialTable];
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 47;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return  2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 111;
}
- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KWIDTH, 47)];
    topView.backgroundColor = [UIColor whiteColor];
    UIView *grayTopView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KWIDTH, 7)];
    grayTopView.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];
    [topView addSubview:grayTopView];
    
    NSArray *titleArr = @[@"热门推荐",@"众健科技",@"金牌课程"];
    for (int i = 0; i < titleArr.count; i++) {
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(10+(KWIDTH-20)/3*i, 10, KWIDTH/3, 30);
        [button setTitleColor:[UIColor colorWithHexString:@"444444"] forState:UIControlStateNormal];
        [button setTitle:titleArr[i] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:13];
        button.tag = 300+i;
        [button addTarget:self action:@selector(titleLableButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        CGFloat labelWidth = [button.titleLabel.text sizeWithFont:button.titleLabel.font].width;
        
        if ( i == 0 ) {
            lineBottom = [[UIView alloc] init];
            lineBottom.backgroundColor = zjTextColor;
            
            lineBottom.frame = CGRectMake(0, 29, labelWidth, 1);
            [button.titleLabel addSubview:lineBottom];
            
        }else {
            
            
        }
        [topView addSubview:button];
        
    }
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];
    [topView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(0);
        make.height.mas_offset(1);
        make.right.mas_offset(0);
        make.bottom.mas_offset(-1);
    }];
        
//    }
    return topView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CommercialCell *cell = [[CommercialCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:commercialCellID];
    if (!cell) {
        cell = [[CommercialCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:commercialCellID];
    }
    
    cell.iconImage.backgroundColor = [UIColor redColor];
    cell.headTitleLabel.text = @"儒家文化课程";
    cell.isOnLineLabel.text = @"线下";
    cell.isOnLineLabel.textColor = zjTextColor;
    cell.detailTitleLabel.text = @"dbysgayfgayfgsyfa";
    cell.priceLabel.text = @"11150";
    cell.numberPeopleLabel.hidden = YES;
    
    cell.selectionStyle = UITableViewCellStyleDefault;
    return cell;
}
- (void)titleLableButtonClick:(UIButton *)sender {
    CGFloat labelWidth = [sender.titleLabel.text sizeWithFont:sender.titleLabel.font].width;

    if (sender.tag == 300) {
        lineBottom.frame = CGRectMake(0, 29, labelWidth, 1);
        [sender.titleLabel addSubview:lineBottom];
    }else if (sender.tag == 301) {
        lineBottom.frame = CGRectMake(0, 29, labelWidth, 1);
        [sender.titleLabel addSubview:lineBottom];
    }else {
        lineBottom.frame = CGRectMake(0, 29, labelWidth, 1);
        [sender.titleLabel addSubview:lineBottom];
    }
        
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.navigationController pushViewController:[CourseIntroductionViewController new] animated:YES];
    
}
- (void)backButtonClick {
    self.navigationController.navigationBar.hidden = NO;
    [self.navigationController popViewControllerAnimated:YES];
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
