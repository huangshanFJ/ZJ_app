//
//  CommentViewController.m
//  ZhongJianMalliOS
//
//  Created by 段 on 2017/12/18.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "CommentViewController.h"
#import "OrderDetailAdressCell.h"
#import "OrderHeadView.h"
#import "DetailOrderTableViewCell.h"
#import "OrderDetailCell.h"
#import "OrderStateTableViewCell.h"
#import "CommentingViewController.h"
@interface CommentViewController ()<UITableViewDelegate,UITableViewDataSource> {
    
    NSString *token;
    NSDictionary *dataDiction;
    
}

@property (nonatomic,strong)UITableView *detailTableView;

@end
static NSString *const OrderStateTableViewCellID = @"OrderStateTableViewCell";
static NSString *const orderAdressCellID = @"OrderDetailAdressCell";
static NSString *const timeCellID = @"DetailOrderTableViewCell";
static NSString *const OrderDetailCellID = @"OrderDetailCell";
@implementation CommentViewController


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    self.navigationController.navigationBar.barStyle = UIStatusBarStyleDefault;

}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    token = [user objectForKey:@"userToken"];
    dataDiction = [NSDictionary dictionary];
    [self requestData];
    
    [self configNav];
    
    [self configTableView];
    
    [self configBottom];
}
- (void)requestData {
    NSString *url = [NSString stringWithFormat:@"%@%@%@/%@",HTTPUrl,@"/zjapp/v1/PersonalCenter/getOrderDetails/",token,_orderID];
//    NSInteger order = [_orderID integerValue];
//    NSNumber *orderID = [NSNumber numberWithInteger:order];
//    NSDictionary *dic = @{
//                          @"orderId":orderID
//                          };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer new];
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [manager GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",responseObject);
        if ([responseObject[@"error_code"] integerValue] == 0) {
            dataDiction = responseObject[@"data"];
        }
        
        [_detailTableView reloadData];
        [hud hideAnimated:YES];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
        [hud hideAnimated:YES];
    }];
    
    
    
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
    title.text = @"我的订单";
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
    _detailTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, KWIDTH, KHEIGHT-64-45) style:UITableViewStylePlain];
    _detailTableView.delegate = self;
    _detailTableView.dataSource = self;
    
    _detailTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KWIDTH, KHEIGHT-64-45-45*6-90-85-65-12)];
    footView.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];
    _detailTableView.tableFooterView = footView;
    
    [self.view addSubview:_detailTableView];
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return section == 0 ? 10 : 1;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return section == 1 ? 6 : 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (indexPath.row == 1) {
            return 77;
        }else if (indexPath.row == 2) {
            return 90;
        }else {
            return 45;
        }
    }else {
        return 60;
    }
   
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KWIDTH, 6)];
    headView.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];
    return headView;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = nil;
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            OrderStateTableViewCell *stateCell = [[OrderStateTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:OrderStateTableViewCellID];
            if ([dataDiction count] > 0) {
                if ([dataDiction[@"curstatus"] intValue] == -2 || [dataDiction[@"curstatus"] intValue] == -3)  {
                    stateCell.stateLabel.text = @"订单已关闭";
                }else if ([dataDiction[@"curstatus"] intValue] == -1) {
                    stateCell.stateLabel.text = @"订单待付款";
                }else if ([dataDiction[@"curstatus"] intValue] == 0) {
                    stateCell.stateLabel.text = @"订单待发货";//@"已支付";
                }else if ([dataDiction[@"curstatus"] intValue] == 1) {
                    stateCell.stateLabel.text = @"订单已发货";
                }else if ([dataDiction[@"curstatus"] intValue] == 2) {
                    stateCell.stateLabel.text = @"订单确认收货";
                }else if ([dataDiction[@"curstatus"] intValue] == 3) {
                    stateCell.stateLabel.text = @"订单评价(完成)";
                }else if ([dataDiction[@"curstatus"] intValue] == 4) {
                    stateCell.stateLabel.text = @"订单申请退货";
                }else if ([dataDiction[@"curstatus"] intValue] == 5) {
                    stateCell.stateLabel.text = @"订单申请取消";
                }
                
            }
            
            cell = stateCell;
        }else if (indexPath.row == 1) {
            OrderDetailAdressCell *adressCell = [[OrderDetailAdressCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:orderAdressCellID];
            if ([dataDiction count] > 0) {
                adressCell.nameLabel.text = [NSString stringWithFormat:@"%@",dataDiction[@"receivername"]];
                adressCell.phoneLabel.text = [NSString stringWithFormat:@"%@",dataDiction[@"receiverphone"]];
                adressCell.detailAdressLabel.text = [NSString stringWithFormat:@"%@%@%@%@",dataDiction[@"provincename"],dataDiction[@"cityname"],dataDiction[@"regionname"],dataDiction[@"address"]];
            }
 
            
            cell = adressCell;
        }else if (indexPath.row == 2) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"shopCellID"];
            
            OrderHeadView *sectionHead = [[OrderHeadView alloc] initWithFrame:CGRectMake(0, 0, KWIDTH, 90)];
            if ([dataDiction count] > 0) {
                NSString *urlStr = [NSString stringWithFormat:@"%@%@",HTTPUrl,dataDiction[@"orderlines"][0][@"photo"]];
                
                [sectionHead.headImage sd_setImageWithURL:[NSURL URLWithString:urlStr] placeholderImage:[UIImage imageNamed:@"picture1"]];
               
                sectionHead.headLabel.text = [NSString stringWithFormat:@"%@",dataDiction[@"orderlines"][0][@"productname"]];
                NSString *priceStr = [NSString stringWithFormat:@"%@",dataDiction[@"orderlines"][0][@"price"]];
                NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"￥ %@",priceStr]];
                [AttributedStr addAttribute:NSFontAttributeName
                                      value:[UIFont systemFontOfSize:15.0]
                                      range:NSMakeRange(0, 2)];
                [AttributedStr addAttribute:NSFontAttributeName
                                      value:[UIFont fontWithName:@"Arial Rounded MT Bold" size:15]
                                      range:NSMakeRange(2, priceStr.length)];
                sectionHead.priceLabel.attributedText = AttributedStr;
                sectionHead.numberLabel.text = [NSString stringWithFormat:@"x%@",dataDiction[@"orderlines"][0][@"productnum"]];
            }
            
            [cell addSubview:sectionHead];
            
        }else {
            OrderDetailCell *orderDetailCell = [[OrderDetailCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:OrderDetailCellID];
            if (!orderDetailCell) {
                orderDetailCell = [[OrderDetailCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:OrderDetailCellID];
            }
            if ([dataDiction count] > 0) {
                NSArray *cellArr = @[@"商品总额",@"运费",@"现金红包抵扣",@"购物币抵扣",@"现金币抵扣",@"积分抵扣",@"实付款"];
                orderDetailCell.kindLabel.text = cellArr[indexPath.row-3];
                
                if (indexPath.row == 3) {
                    orderDetailCell.stateLabel.text = [NSString stringWithFormat:@"￥%@",dataDiction[@"totalamount"]];//@"￥192";
                    orderDetailCell.stateLabel.textColor = lightBlackTextColor;
                }else if (indexPath.row == 9) {
                    orderDetailCell.stateLabel.textColor = redTextColor;
                    orderDetailCell.stateLabel.text = [NSString stringWithFormat:@"￥ %@",dataDiction[@"realpay"]];//@"￥ 128";
                    orderDetailCell.stateLabel.font = [UIFont fontWithName:@"Arial Rounded MT Bold" size:15];
                    orderDetailCell.kindLabel.textColor = lightBlackTextColor;
                }else {
                    NSString *freight = [NSString stringWithFormat:@"-￥%@",dataDiction[@"freight"]];//运费
                    NSString *useCoupon = [NSString stringWithFormat:@"-￥%@",dataDiction[@"usecoupon"]];//红包
                    NSString *usePointNum = [NSString stringWithFormat:@"-￥%@",dataDiction[@"usepointnum"]];//购物币
                    NSString *useElecNum = [NSString stringWithFormat:@"-￥%@",dataDiction[@"useelecnum"]];//现金币
                    NSString *usevipremainnum = [NSString stringWithFormat:@"-￥%@",dataDiction[@"usevipremainnum"]];//积分
                    NSArray *textArr = @[freight,useCoupon,usePointNum,useElecNum,usevipremainnum];
                    
                    orderDetailCell.stateLabel.text = textArr[indexPath.row-4];
                    orderDetailCell.stateLabel.textColor = redTextColor;
                }
            }
            
            cell = orderDetailCell;
        }
    }else {
       
        DetailOrderTableViewCell *timeCell = [[DetailOrderTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:timeCellID];
        if ([dataDiction count] > 0) {
            timeCell.orderIDLabel.text = [NSString stringWithFormat:@"%@",dataDiction[@"orderno"]];
            timeCell.creatTimeLabel.text = [NSString stringWithFormat:@"%@",dataDiction[@"createtime"]];
        }
        
//        timeCell.payTimeLabel.text = @"2017-10-10 20:80";
        
        cell = timeCell;
       
    }
    
    
    cell.selectionStyle = UITableViewCellStyleDefault;
    
    return cell;
}
- (void)configBottom {
    UIView *bottomView = [[UIView alloc] init];
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
        make.width.mas_offset(KWIDTH);
        make.height.mas_offset(0.5);
        make.top.equalTo(bottomView.mas_top).offset(0);
    }];
    UIButton *payButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [payButton setTitle:@"立即支付" forState:UIControlStateNormal];
    payButton.titleLabel.font = [UIFont systemFontOfSize:13];
    payButton.layer.masksToBounds = YES;
    payButton.layer.cornerRadius = 11;
    payButton.backgroundColor = zjTextColor;
    [payButton addTarget:self action:@selector(payButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:payButton];
    [payButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-10);
        make.height.mas_offset(28);
        make.width.mas_offset(70);
        make.centerY.equalTo(bottomView.mas_centerY).offset(0);
    }];
    
    UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [cancelButton setTitleColor:[UIColor colorWithHexString:@"444444"] forState:UIControlStateNormal];
    [cancelButton setTitle:@"申请退款" forState:UIControlStateNormal];
    cancelButton.backgroundColor = [UIColor whiteColor];
//    cancelButton.hidden = YES;
    cancelButton.titleLabel.font = [UIFont systemFontOfSize:13];
    cancelButton.layer.masksToBounds = YES;
    cancelButton.layer.cornerRadius = 11;
    cancelButton.layer.borderWidth = 0.5;
    cancelButton.layer.borderColor = [UIColor colorWithHexString:@"e2e2e2"].CGColor;
    [cancelButton addTarget:self action:@selector(cancelButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:cancelButton];
    [cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(payButton.mas_left).offset(-10);
        make.height.mas_offset(28);
        make.width.mas_offset(70);
        make.centerY.equalTo(bottomView.mas_centerY).offset(0);
    }];
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
//    [self.navigationController pushViewController:[CommentingViewController new] animated:YES];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)payButtonClick {
    
}
- (void)cancelButtonClick {
    
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
