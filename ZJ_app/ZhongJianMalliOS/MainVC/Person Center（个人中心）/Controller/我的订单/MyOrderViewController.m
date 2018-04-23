//
//  MyOrderViewController.m
//  ZhongJianMalliOS
//
//  Created by 段 on 2017/12/15.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "MyOrderViewController.h"
#import "MyOrderViewCell.h"
#import "CommentViewController.h"
#import "MyOrderModel.h"
#import "MyOrderHeadView.h"
#import "MyOrderFooterView.h"
#import "DismissOrderForRefundViewController.h"
#import "CommentDetailViewController.h"

@interface MyOrderViewController ()<UITableViewDelegate,UITableViewDataSource>{
    
    UIView *lineBottom;
    //是否是最后一页
    BOOL is_noMore;
    //页数
    int _pageNum;
    NSMutableArray *_dataArray;
    NSString *type;
    UIView *noDataImageview;
    NSString *token;
}

@property (nonatomic,strong)UITableView *myOrderTableView;

@end
static NSString *const orderCellID = @"MyOrderViewCell";
@implementation MyOrderViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    self.navigationController.navigationBar.barStyle = UIStatusBarStyleDefault;

}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self configNav];
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    token = [user objectForKey:@"userToken"];
    noDataImageview = [[UIView alloc] init];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(selectedReason:) name:@"selectedReason" object:nil];
    _dataArray = [NSMutableArray arrayWithCapacity:0];
    //all全部 wp待付款 ws待发货 wr待收货 wc待评价
    if (_selectedIndex == 0) {
        type = @"all";
    }else if (_selectedIndex == 1) {
        type = @"wp";
    }else if (_selectedIndex == 2) {
        type = @"ws";
    }else if (_selectedIndex == 3) {
        type = @"wr";
    }else {
        type = @"wc";
    }
    [self requestDataIsMore:NO seletype:type];
    [self configTableView];
}
- (void)requestDataIsMore:(BOOL)isMore seletype:(NSString *)seletype {
    
    if (!isMore) {
        _pageNum = 0;
        
    }else if(is_noMore == NO)
    {
        _pageNum++;
    }
    if (_pageNum == 0) {
        [_dataArray removeAllObjects];
    }
    NSString *page = [NSString stringWithFormat:@"%d",_pageNum];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer new];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    
    NSString *url = [NSString stringWithFormat:@"%@%@%@/%@",HTTPUrl,@"/zjapp/v1/PersonalCenter/getOrder/",token,seletype];
    NSDictionary *dic = @{
                          @"type":type,
                          @"page":page,
                          @"pageNum":@"10"
                          };
    [manager GET:url parameters:dic progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",responseObject);
        NSArray *data = [NSArray arrayWithArray:responseObject[@"data"]];
        if ([responseObject[@"error_code"] intValue] == 0 ) {
            for (NSDictionary *dict in data) {
                MyOrderModel *model = [[MyOrderModel alloc] init];
                model.createtime = [NSString stringWithFormat:@"%@",dict[@"createtime"]];
                model.curstatus = [NSString stringWithFormat:@"%@",dict[@"curstatus"]];
                model.orderId = [NSString stringWithFormat:@"%@",dict[@"id"]];
                model.orderno = [NSString stringWithFormat:@"%@",dict[@"orderno"]];
                model.realpay = [NSString stringWithFormat:@"%@",dict[@"realpay"]];
                model.receivedtime = [NSString stringWithFormat:@"%@",dict[@"receivedtime"]];
                model.senddate = [NSString stringWithFormat:@"%@",dict[@"senddate"]];
                model.tolnum = [NSString stringWithFormat:@"%@",dict[@"tolnum"]];
                model.totalamount = [NSString stringWithFormat:@"%@",dict[@"totalamount"]];
                [model setOrderlines:dict[@"orderlines"]];
                [_dataArray addObject:model];
            }
            
        }
        NSLog(@"-===========%ld",_dataArray.count);
        if (data.count < 10) {
            is_noMore = YES;
        }else
        {
            is_noMore = NO;
        }
        if (_dataArray.count == 0) {
            _myOrderTableView.mj_footer.hidden = YES;
            [self initWithZeroView:NO];
//
        }else {
            _myOrderTableView.mj_footer.hidden = NO;
//
            UIView* subView = [self.view viewWithTag:1111];
            [subView removeFromSuperview];
 
        }
        
        [_myOrderTableView reloadData];
        [self endRefresh];
        
        [hud hideAnimated:YES];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
        [hud hideAnimated:YES];
    }];
    
    
    
    
}
- (void)initWithZeroView:(BOOL)hiden {
    
    noDataImageview.frame = CGRectMake(0, 104, KWIDTH, KHEIGHT-104);
    noDataImageview.tag = 1111;
    noDataImageview.hidden = hiden;
    [self.view addSubview:noDataImageview];
    UIImageView *noDataImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, KWIDTH, KHEIGHT-104)];
    noDataImage.image = [UIImage imageNamed:@"暂无订单"];
//    noDataImage.hidden
    [noDataImageview addSubview:noDataImage];
    [noDataImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_offset(0);
        make.width.mas_offset(180);
        make.height.mas_offset(175);
        make.centerY.mas_offset(-50);
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
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, KWIDTH, 40)];
    headView.backgroundColor = [UIColor whiteColor];
    NSArray *titleArr = @[@"全部",@"待付款",@"待发货",@"待收货",@"待评价"];
    for (int i = 0; i < titleArr.count; i++) {
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(10+(KWIDTH-20)/5*i, 0, KWIDTH/6, 40);
        [button setTitleColor:[UIColor colorWithHexString:@"444444"] forState:UIControlStateNormal];
        [button setTitle:titleArr[i] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:13];
        button.tag = 300+i;
        [button addTarget:self action:@selector(titleLableButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        CGFloat labelWidth = [button.titleLabel.text sizeWithFont:button.titleLabel.font].width;
        if ( i == _selectedIndex ) {
            lineBottom = [[UIView alloc] init];
            lineBottom.backgroundColor = zjTextColor;
            lineBottom.frame = CGRectMake(0, 27, labelWidth, 1);
            [button.titleLabel addSubview:lineBottom];
            
        }else {
        }
        
        [headView addSubview:button];
    }
    [self.view addSubview:headView];
}

- (void)configTableView {
    _myOrderTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 104, KWIDTH, KHEIGHT-104) style:UITableViewStyleGrouped];
    _myOrderTableView.delegate = self;
    _myOrderTableView.dataSource = self;
    _myOrderTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _myOrderTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        // 进入刷新状态后会自动调用这个block
 
        [self requestDataIsMore:NO seletype:type];
    }];
    _myOrderTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [self requestDataIsMore:YES seletype:type];
    }];
    [self.view addSubview:_myOrderTableView];
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 90;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 37;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 90;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    MyOrderHeadView *headView = [[MyOrderHeadView alloc] initWithFrame:CGRectMake(0, 0, KWIDTH, 37)];
    
    MyOrderModel *model = [[MyOrderModel alloc] init];
    model = _dataArray[section];
    if (_dataArray.count > 0) {
        if ([model.curstatus intValue] == -2 || [model.curstatus intValue] == -3)  {
            headView.orderStateKindLabel.text = @"已关闭";
        }else if ([model.curstatus intValue] == -1) {
            headView.orderStateKindLabel.text = @"待付款";
        }else if ([model.curstatus intValue] == 0) {
            headView.orderStateKindLabel.text = @"待发货";//@"已支付";
        }else if ([model.curstatus intValue] == 1) {
            headView.orderStateKindLabel.text = @"已发货";
        }else if ([model.curstatus intValue] == 2) {
            headView.orderStateKindLabel.text = @"确认收货";
        }else if ([model.curstatus intValue] == 3) {
            headView.orderStateKindLabel.text = @"评价(完成)";
        }else if ([model.curstatus intValue] == 4) {
            headView.orderStateKindLabel.text = @"申请退货";
        }else if ([model.curstatus intValue] == 5) {
            headView.orderStateKindLabel.text = @"申请取消";
        }
        headView.creatTimeLabel.text = [NSString stringWithFormat:@"%@",model.createtime];
        
    }
    return headView;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    MyOrderFooterView *footView = [[MyOrderFooterView alloc] initWithFrame:CGRectMake(0, 0, KWIDTH, 90)];
    
    MyOrderModel *model = [[MyOrderModel alloc] init];
    model = _dataArray[section];
    
    NSString *numberString = model.tolnum;
    footView.totalNumberLabel.text = [NSString stringWithFormat:@"共%@件商品",numberString];
    NSString *priceString = [NSString stringWithFormat:@"￥ %@",model.realpay];//@"128";
    NSString *needString = @"需付款:";
    NSMutableAttributedString *needAttribut = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@%@",needString,priceString]];
    [needAttribut addAttribute:NSFontAttributeName
                         value:[UIFont systemFontOfSize:11]
                         range:NSMakeRange(0, needString.length)];
    [needAttribut addAttribute:NSFontAttributeName
                         value:[UIFont systemFontOfSize:15]
                         range:NSMakeRange(needString.length, priceString.length)];
    footView.needPriceLabel.attributedText = needAttribut;
    if (_dataArray.count > 0) {
//        NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
//        NSString *token = [user objectForKey:@"userToken"];
        
        if ([model.curstatus intValue] == -2)  {
            
            [footView.rightButton setTitle:@"取消完成" forState:UIControlStateNormal];
            
            [footView.rightButton setBackgroundColor:lightgrayTextColor];
            
        }else if ( [model.curstatus intValue] == -3) {
            [footView.rightButton setTitle:@"退货完成" forState:UIControlStateNormal];
            [footView.rightButton setBackgroundColor:lightgrayTextColor];
        }else if ([model.curstatus intValue] == -1) {
//            headView.orderStateKindLabel.text = @"等待支付";
            [footView.rightButton setTitle:@"立即支付" forState:UIControlStateNormal];
            footView.rightButtonClickBlock = ^{
                NSString *url = [NSString stringWithFormat:@"%@%@%@",HTTPUrl,@"/zjapp/v1/PersonalCenter/HandleEOrder/",token];
                 [self requestPayOrderNo:model.orderno url:url];
                
            };
            footView.leftButton.hidden = NO;
            [footView.leftButton setTitle:@"取消订单" forState:UIControlStateNormal];
            [footView.leftButton setTitleColor:lightBlackTextColor forState:UIControlStateNormal];
            footView.leftButtonClickBlock = ^{
                NSString *url = [NSString stringWithFormat:@"%@%@%@",HTTPUrl,@"/zjapp/v1/PersonalCenter/cancelOrder/",token];
                [self dismissViewOrder:model.orderno url:url];
            };

        }else if ([model.curstatus intValue] == 0) {
//            headView.orderStateKindLabel.text = @"已支付";
            [footView.rightButton setTitle:@"申请退款" forState:UIControlStateNormal];
            [footView.rightButton setBackgroundColor:zjTextColor];
            footView.rightButtonClickBlock = ^{
                
                [self dismissOrderRefundorderNo:model.orderno];
            };
        
        }else if ([model.curstatus intValue] == 1) {
//            headView.orderStateKindLabel.text = @"已发货";
            [footView.rightButton setTitle:@"确认收货" forState:UIControlStateNormal];
            [footView.rightButton setBackgroundColor:zjTextColor];
            footView.rightButtonClickBlock = ^{
                
            };
            
            [footView.leftButton setTitle:@"申请退货" forState:UIControlStateNormal];
            footView.leftButton.hidden = NO;
            [footView.leftButton setTitleColor:lightBlackTextColor forState:UIControlStateNormal];
            footView.leftButtonClickBlock = ^{
                
            };
            

        }else if ([model.curstatus intValue] == 2) {
//            headView.orderStateKindLabel.text = @"确认收货";
            [footView.rightButton setTitle:@"评价" forState:UIControlStateNormal];
            [footView.rightButton setBackgroundColor:zjTextColor];
            footView.rightButtonClickBlock = ^{
                
            };

        }else if ([model.curstatus intValue] == 3) {
//            headView.orderStateKindLabel.text = @"评价(完成)";
            [footView.rightButton setTitle:@"订单完成" forState:UIControlStateNormal];
            [footView.rightButton setTitleColor:lightgrayTextColor forState:UIControlStateNormal];
        }else if ([model.curstatus intValue] == 4) {
//            headView.orderStateKindLabel.text = @"申请退货";
            [footView.rightButton setTitle:@"审核中" forState:UIControlStateNormal];
            footView.rightButton.backgroundColor = lightgrayTextColor;
            footView.rightButtonClickBlock = ^{
                
            };

        }else if ([model.curstatus intValue] == 5) {
//            headView.orderStateKindLabel.text = @"申请取消";
            [footView.rightButton setTitle:@"审核中" forState:UIControlStateNormal];
//            [footView.rightButton setTitleColor:zjTextColor forState:UIControlStateNormal];
            footView.rightButton.backgroundColor = lightgrayTextColor;
            footView.rightButtonClickBlock = ^{
                
            };
        }
    }
   
    return footView;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _dataArray.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (_dataArray.count > 0) {
        MyOrderModel *model = [[MyOrderModel alloc] init];
        model = _dataArray[section];
        NSArray *list = [NSArray arrayWithArray:model.orderlines];
        return list.count;
    }else {
        return 0;
    }
   
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MyOrderViewCell *cell = [[MyOrderViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:orderCellID];
    if (!cell) {
        cell = [[MyOrderViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:orderCellID];
    }
    MyOrderModel *model = [[MyOrderModel alloc] init];
    model = _dataArray[indexPath.section];
    if (_dataArray.count > 0) {
        
        NSString *urlStr = [NSString stringWithFormat:@"%@%@",HTTPUrl,model.orderlines[indexPath.row][@"photo"]];
        [cell.headImage sd_setImageWithURL:[NSURL URLWithString:urlStr] placeholderImage:[UIImage imageNamed:@"picture1"]];
        NSString *text = [NSString stringWithFormat:@"%@",model.orderlines[indexPath.row][@"productname"]];
        cell.orderNameLabel.text = text;
        cell.orderPriceLabel.text = [NSString stringWithFormat:@"￥ %@",model.orderlines[indexPath.row][@"price"]];
        cell.orderNumberLabel.text = [NSString stringWithFormat:@"x%@",model.orderlines[indexPath.row][@"productnum"]];
        
        
        
    }
  
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    MyOrderModel *model = [[MyOrderModel alloc] init];
    model = _dataArray[indexPath.section];
    NSInteger status = [model.curstatus integerValue];
    if (status == -2 || status == -3 || status == -1 || status == 0 || status == 5) {
        CommentViewController *comVC = [CommentViewController new];
        comVC.orderID = model.orderId;
        [self.navigationController pushViewController:comVC animated:YES];
    }else {
        CommentDetailViewController *comVC = [CommentDetailViewController new];
        
        comVC.orderID = model.orderId;
        [self.navigationController pushViewController:comVC animated:YES];
        
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}
#pragma mark --- headRTitle
- (void)titleLableButtonClick:(UIButton *)sender {
    CGFloat labelWidth = [sender.titleLabel.text sizeWithFont:sender.titleLabel.font].width;
    if (sender.tag == 300) {
        type = @"all";
        NSLog(@"全部");
        lineBottom.frame = CGRectMake(0, 27, labelWidth, 1);
        [sender.titleLabel addSubview:lineBottom];
    }else if (sender.tag == 301) {
        NSLog(@"待付款");
        type = @"wp";
        lineBottom.frame = CGRectMake(0, 27, labelWidth, 1);
        [sender.titleLabel addSubview:lineBottom];
       
    }else if (sender.tag == 302) {
        NSLog(@"待发货");
         type = @"ws";
        lineBottom.frame = CGRectMake(0, 27, labelWidth, 1);
        [sender.titleLabel addSubview:lineBottom];
    }else if (sender.tag == 303) {
        NSLog(@"待收货");
        type = @"wr";
        lineBottom.frame = CGRectMake(0, 27, labelWidth, 1);
        [sender.titleLabel addSubview:lineBottom];
        
    }else {
        NSLog(@"待评价");
        type = @"wc";
        lineBottom.frame = CGRectMake(0,27, labelWidth, 1);
        [sender.titleLabel addSubview:lineBottom];
 
    }
   
    [self requestDataIsMore:NO seletype:type];
}
#pragma mark ----立即支付
- (void)requestPayOrderNo:(NSString *)order url:(NSString *)url{
//    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
//    NSString *token = [user objectForKey:@"userToken"];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer new];
     
    NSDictionary *dic = @{
                          @"orderNo":order
                          };
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.label.text = @"支付中";
    [manager POST:url parameters:dic progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",responseObject);
        if ([responseObject[@"error_code"] integerValue] == 0) {
            NSString *typeStr = [NSString stringWithFormat:@"%@",responseObject[@"data"][@"type"]];
            if ([typeStr isEqualToString:@"1"]) {
                
                NSString *url = [NSString stringWithFormat:@"%@%@%@",HTTPUrl,@"/zjapp/v1/PersonalCenter/syncHandleOrder/",token];
                NSString *orderNo = [NSString stringWithFormat:@"%@",responseObject[@"data"][@"orderNo"]];
                NSDictionary *paramet = @{
                                          @"orderNo":orderNo
                                          };
                [manager POST:url parameters:paramet progress:^(NSProgress * _Nonnull uploadProgress) {
                    
                } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                    NSLog(@"%@",responseObject);
                    
                    if ([responseObject[@"error_code"] intValue] == 0) {
                        
                        __block MyOrderViewController *weakSelf = self;
                        dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC));
                        dispatch_after(delayTime, dispatch_get_main_queue(), ^{
//
                            [hud hideAnimated:YES];
                            [weakSelf requestDataIsMore:NO seletype:type];
                        });
                        
                    }
                } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                    NSLog(@"%@",error);
                     [hud hideAnimated:YES];
                }];
                
            }else {
                NSString *appScheme = @"com.zhongjianAlipay";
                NSString *orderString = [NSString stringWithFormat:@"%@",responseObject[@"data"][@"singData"]];
                // NOTE: 调用支付结果开始支付
                [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
                    NSLog(@"reslut = %@",resultDic);
                }];
            }
        }else {
            NSString *message = [NSString stringWithFormat:@"%@",responseObject[@"error_message"]];
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:message message:nil preferredStyle:UIAlertControllerStyleAlert];
            [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                
            }]];
            [self presentViewController:alert animated:YES completion:^{
                
            }];
            
        }
        [hud hideAnimated:YES];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
        [hud hideAnimated:YES];
    }];
 
}
#pragma mark ---取消订单
- (void)dismissViewOrder:(NSString *)order url:(NSString*)url {
   
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer new];

    NSDictionary *dic = @{
                          @"orderNo":order
                          };

    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [manager POST:url parameters:dic progress:^(NSProgress * _Nonnull uploadProgress) {

    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",responseObject);
         if ([responseObject[@"error_code"] intValue] == 0) {
              [self requestDataIsMore:NO seletype:type];
         }

        [hud hideAnimated:YES];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
        [hud hideAnimated:YES];
    }];
   
}
#pragma mark -----申请退款
- (void)dismissOrderRefundorderNo:(NSString *)order {
    DismissOrderForRefundViewController *refundVC = [DismissOrderForRefundViewController new];
    refundVC.seleOrderNo = order;
    refundVC.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    
    [self presentViewController:refundVC animated:NO completion:^{
        refundVC.view.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
    }];
}

#pragma mark 开始进入刷新状态
- (void)endRefresh
{
    
    [_myOrderTableView.mj_header endRefreshing];
    if (is_noMore == YES) {
        
        _myOrderTableView.mj_footer.state = MJRefreshStateNoMoreData;
        //        _fansTableView.mj_footer.hidden = YES;
    }else {
        [_myOrderTableView.mj_footer endRefreshing];
    }
}
#pragma mark ---- 退款理由
- (void)selectedReason:(NSNotification *)notification {
    NSLog(@"接受到通知");
    NSDictionary *dic = notification.userInfo;
    NSLog( @"######%@",dic);
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer new];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSDictionary *parame = @{
                          @"orderNo":dic[@"orderNo"],
                          @"memo":dic[@"memo"]
                          };
    NSString *url = [NSString stringWithFormat:@"%@%@%@",HTTPUrl,@"/zjapp/v1/PersonalCenter/ApplyRefund/",token];
    [manager POST:url parameters:parame progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",responseObject);
        if ([responseObject[@"error_code"] integerValue] == 0) {
            [self requestDataIsMore:NO seletype:type];
        }
        [hud hideAnimated:YES];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
        
        [hud hideAnimated:YES];
        
    }];

    
    
}
- (void)backButtonClick {
    self.navigationController.navigationBar.hidden = NO;
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)dealloc{
    //第一种方法.这里可以移除该控制器下的所有通知
    // 移除当前所有通知
    NSLog(@"移除了所有的通知");
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
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
