//
//  CourseIntroductionViewController.m
//  ZhongJianMalliOS
//
//  Created by 段 on 2017/12/5.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "CourseIntroductionViewController.h"
#import "IntrolduceCell.h"
#import "CourseCell.h"
#import "RegistrationInformationViewController.h"

@interface CourseIntroductionViewController ()<UITableViewDelegate,UITableViewDataSource> {
    UIView *bottomView;//底部视图
    UILabel *_priceNumberLabel;//价格
}

@property (nonatomic,strong)UITableView *introlduceTable;
@end
static NSString *const introduceCellID = @"IntrolduceCell";
static NSString *const courseCellID = @"CourseCell";

@implementation CourseIntroductionViewController
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self initNavView];
    
    [self initTableView];
    
    [self initBottomView];
}
- (void)initNavView {
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
    titleLabel.text = @"课程介绍";
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
    
    UIView *line1 = [[UIView alloc] init];
    line1.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];
    [self.view addSubview:line1];
    [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(0);
        make.top.mas_offset(63);
        make.height.mas_offset(1);
        make.right.mas_offset(0);
    }];
}
- (void)initBottomView {
    bottomView = [[UIView alloc] init];
    bottomView.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(0);
        make.right.mas_offset(0);
        make.bottom.mas_offset(0);
        make.height.mas_offset(45);
    }];
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];
    [bottomView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(0);
        make.top.equalTo(bottomView.mas_top).offset(0);
        make.height.mas_offset(1);
        make.right.mas_offset(0);
    }];
    
    UILabel *totalLabel = [[UILabel alloc] init];
    totalLabel.text = @"合计：";
    totalLabel.font = [UIFont systemFontOfSize:15];
    totalLabel.textColor = [UIColor colorWithHexString:@"444444"];
    [bottomView addSubview:totalLabel];
    [totalLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(10);
        make.height.mas_offset(44);
        make.top.mas_offset(0);
    }];
    _priceNumberLabel = [[UILabel alloc] init];
    _priceNumberLabel.textColor = redTextColor;
    NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:@"￥ 128"];
    [AttributedStr addAttribute:NSFontAttributeName
                          value:[UIFont systemFontOfSize:15.0]
                          range:NSMakeRange(0, 2)];
    [AttributedStr addAttribute:NSFontAttributeName
                          value:[UIFont fontWithName:@"Arial Rounded MT Bold" size:15]
                          range:NSMakeRange(2, 3)];
    _priceNumberLabel.attributedText = AttributedStr;
    [bottomView addSubview:_priceNumberLabel];
    [_priceNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(totalLabel.mas_right).offset(0);
        //        make.width
        make.top.mas_offset(0);
        make.height.mas_offset(45);
    }];
    
    
    UIButton *sendOrderButton = [UIButton buttonWithType:UIButtonTypeCustom];
    sendOrderButton.backgroundColor = [UIColor colorWithHexString:@"6493fe"];
    [sendOrderButton setTitle:@"立即报名" forState:UIControlStateNormal];
    sendOrderButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [sendOrderButton addTarget:self action:@selector(enterForClick:) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:sendOrderButton];
    [sendOrderButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(0);
        make.width.mas_offset(120);
        make.top.mas_offset(0);
        make.height.mas_offset(45);
    }];

}
- (void)initTableView {
    _introlduceTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, KWIDTH, KHEIGHT-64) style:UITableViewStyleGrouped];
    _introlduceTable.delegate = self;
    _introlduceTable.dataSource = self;
    _introlduceTable.backgroundColor = [UIColor whiteColor];
    _introlduceTable.sectionFooterHeight = 0;//这个距离的计算是header的高度加上footer的高度。
    UIView *footView = [[UIView alloc] init];
    footView.frame = CGRectMake(0, 0, KWIDTH, KHEIGHT);
    _introlduceTable.tableFooterView = footView;
    _introlduceTable.separatorStyle = UITableViewCellSeparatorStyleNone;

    
    [self.view addSubview:_introlduceTable];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return section == 0 ? 175 : 7;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return indexPath.section == 0 ? 95 : 50;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headView = nil;
    if (section == 0) {
        UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KWIDTH, 175)];
        UIImageView *headImage = [[UIImageView alloc] initWithFrame:bgView.frame];
        headImage.image = [UIImage imageNamed:@"banner1"];
        [bgView addSubview:headImage];
        headView = bgView;
        
    }else {
        UIView *lightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KWIDTH, 7)];
        lightView.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];
        headView = lightView;
    }
    
    
    return headView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = nil;
    if (indexPath.section == 0) {
        IntrolduceCell *introlduceCell = [[IntrolduceCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:introduceCellID];

        introlduceCell.courseLabel.text = @"儒家文化课程";
        introlduceCell.lecturerLabel.text = @"讲师：xxx";
        introlduceCell.timeLabel.text = @"时间：12.10-12.11";
        
        cell = introlduceCell;
    }else {
     
        CourseCell *courseCell = [[CourseCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:courseCellID];
        courseCell.headTitleLabel.text = @"课程介绍";
        
        cell = courseCell;
    }
    
    return cell;
}

- (void)enterForClick:(UIButton *)sender {
    [self.navigationController pushViewController:[RegistrationInformationViewController new] animated:YES];
    
}
- (void)backButtonClick {
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
