//
//  HealthViewController.m
//  ZhongJianMalliOS
//
//  Created by 段 on 2017/10/31.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "HealthViewController.h"
#import "UIBarButtonItem+DCBarButtonItem.h"
#import "NewsViewController.h"
//#import "SearhViewController.h"
#import "HealthCell.h"

@interface HealthViewController ()<UITableViewDelegate,UITableViewDataSource> {
    
    UIView *lineBottomView;
}

@property (nonatomic,strong)UITableView *healthTableView;

@end
static NSString *const healthCellID = @"HealthCell";
@implementation HealthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"健康圈";
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self setUpNav];
 
    [self creatTableView];
}
//导航
- (void)setUpNav {
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem ItemWithImage:[UIImage imageNamed:@"scan_gray"] WithHighlighted:[UIImage imageNamed:@"scan_gray"] Target:self action:@selector(richScanItemClick)];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem ItemWithImage:[UIImage imageNamed:@"news_gray"] WithHighlighted:[UIImage imageNamed:@"news_gray"] Target:self action:@selector(messageItemClick)];
    
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KWIDTH-90, 24)];
    titleView.backgroundColor = [UIColor colorWithHexString:@"e4e4e4"];
    titleView.layer.cornerRadius = 5;
    titleView.layer.masksToBounds = YES;
    titleView.userInteractionEnabled = YES;
    UIImageView *searchImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"search_gray"]];
    searchImage.frame = CGRectMake(8, 4, 15, 15);
    [titleView addSubview:searchImage];
    
    UITapGestureRecognizer *navTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(goSearchVC)];
    [titleView addGestureRecognizer:navTap];
    
    self.navigationItem.titleView = titleView;
}
- (void)creatTableView {
    
    _healthTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, KWIDTH, KHEIGHT-64-44) style:UITableViewStylePlain];
    _healthTableView.delegate = self;
    _healthTableView.dataSource = self;
    _healthTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.view addSubview:_healthTableView];
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 47;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KWIDTH, 47)];
    headView.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];
    
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, 7, KWIDTH, 40)];
    bottomView.backgroundColor = [UIColor whiteColor];
    [headView addSubview:bottomView];
    NSArray *buttonArr = @[@"精选",@"最新"];
    for (int i = 0; i<buttonArr.count; i++) {
        UIButton *healthButton = [UIButton buttonWithType:UIButtonTypeCustom];
        healthButton.frame = CGRectMake(0+i*KWIDTH/2, 0, KWIDTH/2, 40);
        [healthButton setTitle:buttonArr[i] forState:UIControlStateNormal];
        healthButton.titleLabel.font = [UIFont systemFontOfSize:15];
        healthButton.tag = 100+i;
        [healthButton setTitleColor:[UIColor colorWithHexString:@"444444"] forState:UIControlStateNormal];
        [healthButton addTarget:self action:@selector(healthButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [bottomView addSubview:healthButton];
        if (i==0) {
            CGFloat labelWidth = [healthButton.titleLabel.text sizeWithFont:healthButton.titleLabel.font].width;
            
            lineBottomView = [[UIView alloc] init];
            lineBottomView.backgroundColor = zjTextColor;
            
            lineBottomView.frame = CGRectMake(0, 28, labelWidth, 1);
            [healthButton.titleLabel addSubview:lineBottomView];
        }
        
    }
    UILabel *line = [UILabel new];
    line.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];
    [headView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(0);
        make.height.mas_offset(1);
        make.right.mas_offset(0);
        make.bottom.mas_offset(-1);
    }];
    
    return headView;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 285.0f;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HealthCell *cell = [[HealthCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:healthCellID];
    if (!cell) {
        cell = [[HealthCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:healthCellID];
    }
    cell.headImageView.image = [UIImage imageNamed:@"banner"];
    cell.headTitleLabel.text = @"众健科技分享经济高峰论坛";
    cell.detailTitleLabel.text = @"大叔大婶干撒鬼打鬼对天发誓多发点人头攒动不大师傅各方";
    
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)healthButtonClick:(UIButton *)sender {
    CGFloat labelWidth = [sender.titleLabel.text sizeWithFont:sender.titleLabel.font].width;
    if (sender.tag == 100) {
        lineBottomView.frame = CGRectMake(0, 28, labelWidth, 1);
        [sender.titleLabel addSubview:lineBottomView];
    }else {
        lineBottomView.frame = CGRectMake(0, 28, labelWidth, 1);
        [sender.titleLabel addSubview:lineBottomView];
    }
}
- (void)richScanItemClick {
    NSLog(@"点击了扫描");
}
- (void)messageItemClick {
    NSLog(@"点击了消息");
    [self.navigationController pushViewController:[NewsViewController new] animated:YES];
}
- (void)goSearchVC {
    NSLog(@"点击了搜索");
//    [self.navigationController pushViewC  ontroller:[SearhViewController new] animated:YES];
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
