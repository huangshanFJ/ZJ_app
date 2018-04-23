//
//  RegistrationInformationViewController.m
//  ZhongJianMalliOS
//
//  Created by 段 on 2017/12/6.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "RegistrationInformationViewController.h"
#import "InformationCell.h"

@interface RegistrationInformationViewController ()<UITableViewDelegate,UITableViewDataSource>{
    
    UIImageView *progressImageOne;//进度
    UIImageView *progressImageTwo;
    UIImageView *progressImageThree;
    
    UIImageView *progressLineOne;
    UIImageView *progressLineTwo;

    
    UILabel *fillInformationLabel;//填写信息
    UILabel *payMoneyLabel;//付款
    UILabel *finishLabel;//完成
    UILabel *getCodeLabel;
    UITextField *checkTF;
    
}

@property (nonatomic,strong)UITableView *informationTableView;

@end

static NSString *const informationCellID = @"InformationCell";

@implementation RegistrationInformationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
 
    [self initNavView];
    
    [self initTableView];
    
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
    titleLabel.text = @"报名信息";
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
- (void)initTableView {
    _informationTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, KWIDTH, KHEIGHT-64) style:UITableViewStylePlain];
    _informationTableView.delegate = self;
    _informationTableView.dataSource = self;
    _informationTableView.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];
    _informationTableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KWIDTH, KHEIGHT*0.4)];
    UIButton *sureButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [sureButton setTitle:@"确定" forState:UIControlStateNormal];
    sureButton.titleLabel.font = [UIFont systemFontOfSize:17];
    sureButton.layer.cornerRadius = 20;
    sureButton.layer.masksToBounds = YES;
    sureButton.backgroundColor = zjTextColor;
    [sureButton addTarget:self action:@selector(sureButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [footView addSubview:sureButton];
    [sureButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(10);
        make.height.mas_offset(40);
        make.right.mas_offset(-10);
        make.top.mas_offset(60);
    }];
    
    _informationTableView.tableFooterView = footView;
    [self.view addSubview:_informationTableView];
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KWIDTH, 56)];
    topView.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];
    
    progressImageOne = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"fullin_blue"]];
    [topView addSubview:progressImageOne];
    [progressImageOne mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(42);
        make.top.mas_offset(10);
        make.height.mas_offset(16);
        make.width.mas_offset(16);
    }];
    fillInformationLabel = [[UILabel alloc] init];
    fillInformationLabel.font = [UIFont systemFontOfSize:11];
    fillInformationLabel.text = @"填写信息";
    fillInformationLabel.textColor = zjTextColor;
    fillInformationLabel.textAlignment = 1;
    [topView addSubview:fillInformationLabel];
    [fillInformationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(progressImageOne.mas_centerX).offset(0);
        make.top.equalTo(progressImageOne.mas_bottom).offset(0);
        make.height.mas_offset(25);
        make.width.mas_offset(70);
    }];
    progressLineOne = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg_gray"]];
    [topView addSubview:progressLineOne];
    [progressLineOne mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(progressImageOne.mas_right).offset(0);
        make.centerY.equalTo(progressImageOne.mas_centerY).offset(0);
        make.height.mas_offset(3);
        make.width.mas_offset(KWIDTH*0.32);
    }];

    progressImageTwo = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"fullin_gray"]];
    [topView addSubview:progressImageTwo];
    [progressImageTwo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(progressLineOne.mas_right).offset(0);
        make.top.mas_offset(10);
        make.height.mas_offset(16);
        make.width.mas_offset(16);
    }];
    payMoneyLabel = [[UILabel alloc] init];
    payMoneyLabel.font = [UIFont systemFontOfSize:11];
    payMoneyLabel.text = @"付款";
    payMoneyLabel.textColor = [UIColor colorWithHexString:@"999999"];
    payMoneyLabel.textAlignment = 1;
    [topView addSubview:payMoneyLabel];
    [payMoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(progressImageTwo.mas_centerX).offset(0);
        make.top.equalTo(progressImageOne.mas_bottom).offset(0);
        make.height.mas_offset(25);
        make.width.mas_offset(70);
    }];
//
    progressLineTwo = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg_gray"]];
    [topView addSubview:progressLineTwo];
    [progressLineTwo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(progressImageTwo.mas_right).offset(0);
        make.centerY.equalTo(progressImageOne.mas_centerY).offset(0);
        make.height.mas_offset(3);
        make.width.mas_offset(KWIDTH*0.32);
    }];
//
    progressImageThree = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"fullin_gray"]];
    [topView addSubview:progressImageThree];
    [progressImageThree mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(progressLineTwo.mas_right).offset(0);
        make.top.mas_offset(10);
        make.height.mas_offset(16);
        make.width.mas_offset(16);
    }];
//
    finishLabel = [[UILabel alloc] init];
    finishLabel.text = @"完成";
    finishLabel.textColor = lightgrayTextColor;
    finishLabel.font = [UIFont systemFontOfSize:11];
    finishLabel.textAlignment = 1;
    [topView addSubview:finishLabel];
    [finishLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(progressImageThree.mas_centerX).offset(0);
        make.top.equalTo(progressImageOne.mas_bottom).offset(0);
        make.height.mas_offset(25);
        make.width.mas_offset(70);
    }];
    
    return topView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 56;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 6;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 45;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    InformationCell *cell = [[InformationCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:informationCellID];
    if (!cell) {
        cell = [[InformationCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:informationCellID];
    }
    NSArray *textArr = @[@"课程",@"价格",@"姓名",@"手机号",@"验证码",@"地区"];
    cell.kindName.text = textArr[indexPath.row];
    if (indexPath.row == 0) {
        cell.informationLabel.hidden = NO;
        cell.informationLabel.text = @"《儒家文化课程》";
    }else if (indexPath.row == 1) {
        cell.informationLabel.hidden = NO;
        NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:@"￥ 3000"];
        [AttributedStr addAttribute:NSFontAttributeName
                              value:[UIFont systemFontOfSize:15.0]
                              range:NSMakeRange(0, 2)];
        [AttributedStr addAttribute:NSFontAttributeName
                              value:[UIFont fontWithName:@"Arial Rounded MT Bold" size:17]
                              range:NSMakeRange(2, 4)];
        cell.informationLabel.textColor = redTextColor;
        cell.informationLabel.attributedText = AttributedStr;
    }else if (indexPath.row == 2) {
        cell.infoTextField.hidden = NO;
        cell.infoTextField.placeholder = @"您的姓名";
    }else if (indexPath.row == 3) {
        cell.infoTextField.hidden = NO;
        cell.infoTextField.placeholder = @"请输入手机号";
    }else if (indexPath.row == 4) {
        getCodeLabel = [[UILabel alloc] init];
        getCodeLabel.text = @"获取验证码";
        getCodeLabel.textAlignment = 2;
        getCodeLabel.userInteractionEnabled = YES;
        getCodeLabel.textColor = zjTextColor;
        getCodeLabel.font = [UIFont systemFontOfSize:13];
        [cell addSubview:getCodeLabel];
        [getCodeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_offset(-10);
            make.top.mas_offset(0);
            make.height.mas_offset(45);
        }];
        UITapGestureRecognizer *tapCode = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick)];
        [getCodeLabel addGestureRecognizer:tapCode];
        checkTF = [[UITextField alloc] init];
        
        [cell addSubview:checkTF];
        [checkTF mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(getCodeLabel.mas_left).offset(-10);
            make.width.mas_offset(KWIDTH*0.3);
            make.top.mas_offset(0);
            make.height.mas_offset(45);
        }];
        
    }else {
        cell.nextImage.hidden = NO;
    }
    
    cell.selectionStyle = UITableViewCellStyleDefault;
    return cell;
}
- (void)sureButtonClick:(UIButton *)sender {
    NSLog(@"确定");
    
}
- (void)tapClick {
    NSLog(@"获取验证码");
    
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
