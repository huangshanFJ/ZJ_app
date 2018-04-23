//
//  AttornViewController.m
//  ZhongJianMalliOS
//
//  Created by 段 on 2017/12/26.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "AttornViewController.h"
#import "AttornPassViewController.h"

@interface AttornViewController ()<UITableViewDelegate,UITableViewDataSource> {
    
}

@property (nonatomic,strong)UITextField *phoneTextField;
@property (nonatomic,strong)UITextField *moneyTextField;
@property (nonatomic,strong)UILabel *priceLabel;
@property (nonatomic,strong)UITableView *attornTable;

@end

@implementation AttornViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.barStyle = UIStatusBarStyleDefault;

    [self configNav];
    
    [self configTableView];
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
    title.text = @"转让现金币";
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
    
    _attornTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, KWIDTH, KHEIGHT-64) style:UITableViewStylePlain];
    _attornTable.delegate = self;
    _attornTable.dataSource = self;
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KWIDTH, 6)];
    headView.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];
    _attornTable.tableHeaderView = headView;
    
    UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KWIDTH, KHEIGHT-64-6-45.5*3)];
    footView.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];
    _attornTable.tableFooterView = footView;
    UIButton *sureButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [sureButton setTitle:@"确定转让" forState:UIControlStateNormal];
    [sureButton setBackgroundColor:zjTextColor];
    sureButton.layer.masksToBounds = YES;
    sureButton.layer.cornerRadius = 20;
    [sureButton addTarget:self action:@selector(sureButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [footView addSubview:sureButton];
    [sureButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(10);
        make.right.mas_offset(-10);
        make.height.mas_offset(40);
        make.top.equalTo(footView.mas_top).mas_offset(60);
    }];
    
    [self.view addSubview:_attornTable];

}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 45.5;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cellID"];
    }
    UILabel *kindName = [UILabel new];
    kindName.textColor = lightBlackTextColor;
    kindName.font = [UIFont systemFontOfSize:13];
    [cell addSubview:kindName];
    [kindName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(10);
        make.height.mas_offset(45);
        make.centerY.mas_offset(0);
    }];
    NSArray *kindArr = @[@"转让给",@"转让金额",@"现有额度"];
    kindName.text = kindArr[indexPath.row];
   
    if (indexPath.row == 0) {
        _phoneTextField = [[UITextField alloc] init];
        _phoneTextField.textAlignment = 2;
        _phoneTextField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;

        _phoneTextField.font = [UIFont systemFontOfSize:12];
        _phoneTextField.placeholder = @"请输入对方众健号";
        [cell addSubview:_phoneTextField];
        [_phoneTextField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_offset(-10);
            make.height.mas_offset(45);
            make.centerY.mas_offset(0);
            make.width.mas_offset(KWIDTH*0.5);
        }];
        
    }else if (indexPath.row == 1) {
        _moneyTextField = [[UITextField alloc] init];
        _moneyTextField.textAlignment = 2;
        _moneyTextField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
        _moneyTextField.font = [UIFont systemFontOfSize:12];
        _moneyTextField.placeholder = @"请输入转入金额";
        [cell addSubview:_moneyTextField];
        [_moneyTextField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_offset(-10);
            make.height.mas_offset(45);
            make.centerY.mas_offset(0);
            make.width.mas_offset(KWIDTH*0.5);
        }];
        
    }else {
        _priceLabel = [[UILabel alloc] init];
        _priceLabel.textAlignment = 2;
        NSString *textSrring = [NSString stringWithFormat:@"￥%@",_money];
        NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:textSrring];
        [AttributedStr addAttribute:NSFontAttributeName
                              value:[UIFont systemFontOfSize:13.0]
                              range:NSMakeRange(0, 1)];
        [AttributedStr addAttribute:NSFontAttributeName
                              value:[UIFont fontWithName:@"Arial Rounded MT Bold" size:17]
                              range:NSMakeRange(1, textSrring.length-1)];
        _priceLabel.attributedText = AttributedStr;
        [cell addSubview:_priceLabel];
        [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_offset(-10);
            make.height.mas_offset(45);
            make.centerY.mas_offset(0);
            make.width.mas_offset(KWIDTH*0.5);
        }];
    }
    
    
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)sureButtonClick:(UIButton *)sender {
    
    
    AttornPassViewController *payVC = [AttornPassViewController new];
    
    [self presentViewController:payVC animated:YES completion:^{
        payVC.money = _moneyTextField.text;
        payVC.sysID = _phoneTextField.text;
    }];
  
    
    
    
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
