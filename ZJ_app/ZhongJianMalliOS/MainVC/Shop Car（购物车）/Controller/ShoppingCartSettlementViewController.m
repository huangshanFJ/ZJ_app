//
//  ShoppingCartSettlementViewController.m
//  ZhongJianMalliOS
//
//  Created by 段 on 2018/3/2.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "ShoppingCartSettlementViewController.h"
#import "OrderDetailAdressCell.h"
#import "OrderAdressTableViewCell.h"
#import "ShopCarOrderCell.h"
#import "OrderHeadView.h"
#import "AdressViewController.h"
#import "OrderPriceModel.h"
#import "DetailOrderPriceModel.h"
@interface ShoppingCartSettlementViewController ()<UITableViewDelegate,UITableViewDataSource> {
    
    BOOL haveAdress;
    NSDictionary *adressDiction;
  
}
@property (nonatomic,strong)UITableView *orderTableView;
@property (nonatomic,strong)UILabel *priceNumberLabel;

@end
static NSString *orderDetailAdressCellID = @"OrderDetailAdressCell";
static NSString *orderAdressCellID = @"OrderAdressTableViewCell";
static NSString *shopCarOrderCellID = @"ShopCarOrderCell";

@implementation ShoppingCartSettlementViewController
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    adressDiction = [NSDictionary dictionary];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(selectedAdress:) name:@"selectedAdress" object:nil];
    [self setNav];
    //
    [self creatTableView];
    //
    [self setBottomView];
//
    [self requestData];
//
    
}
- (void)requestData {
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *token = [user objectForKey:@"userToken"];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer new];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSString *url = [NSString stringWithFormat:@"%@%@",HTTPUrl,@"/zjapp/v1/AddressManager/getDefaultAddressOfUser"];
    NSDictionary *dic = @{
                          @"token":token
                          };
    [manager POST:url parameters:dic progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"-=-=-=-%@",responseObject);
        if ([responseObject[@"error_code"] intValue] == 0) {
//            if ([responseObject[@"data"] isEqualToString:@""] || [responseObject[@"data"] count] < 2) {
             if ([responseObject[@"data"] isKindOfClass:[NSString class]] || [responseObject[@"data"] count] < 2) {
                NSLog(@"111");
            }else{
                adressDiction = responseObject[@"data"];
                if ([adressDiction count] != 0) {
                    haveAdress = YES;
                }else {
                    haveAdress = NO;
                }
            }
            
        }else {
            NSString *title = [NSString stringWithFormat:@"%@",responseObject[@"error_message"]];
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:nil preferredStyle:UIAlertControllerStyleAlert];
            [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                LoginViewController *login = [LoginViewController new];
                
                [self.navigationController pushViewController:login animated:YES];
            }]];
            //            alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertControllerStyleAlert handler:^(UIAlertAction * _Nonnull action) {
            //
            //            }]
            [self presentViewController:alert animated:YES completion:^{
                
            }];
        }
        [_orderTableView reloadData];
        [hud hideAnimated:YES];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
        [hud hideAnimated:YES];
    }];
    
    NSString *url1 = [NSString stringWithFormat:@"%@%@%@",HTTPUrl,@"/zjapp/v1/PersonalCenter/initPersonalWallet/",token];
    [manager GET:url1 parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"成功=%@",responseObject);
        [hud hideAnimated:YES];
        if ([responseObject[@"error_code"] intValue] == 0) {
//            priceDiction = responseObject[@"data"][@"personDataMap"];
//            [_orderTableView reloadData];
        }else if ([responseObject[@"error_code"] intValue] == 3) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"该账号已在其他手机登陆" message:@"" preferredStyle:UIAlertControllerStyleAlert];
            [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                [self.navigationController pushViewController:[LoginViewController new] animated:YES];
            }]];
            [self presentViewController:alert animated:YES completion:nil];
        }
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
        [hud hideAnimated:YES];
    }];
}
- (void)setNav {
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
    title.text = @"确认订单";
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
        make.top.equalTo(title.mas_bottom).offset(-1);
        make.height.mas_offset(1);
    }];
    
}
- (void)creatTableView {
    _orderTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, KWIDTH, KHEIGHT-44-64) style:UITableViewStyleGrouped];
    _orderTableView.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];
    _orderTableView.delegate = self;
    _orderTableView.dataSource = self;
    
    _orderTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_orderTableView];

}
- (void)setBottomView {
    UIView *bottomView = [[UIView alloc] init];
    bottomView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(0);
        make.width.mas_offset(KWIDTH);
        make.height.mas_offset(44);
        make.bottom.mas_offset(0);
    }];
    UILabel *totalLabel = [[UILabel alloc] init];
    totalLabel.text = @"实付：";
    totalLabel.font = [UIFont systemFontOfSize:15];
    totalLabel.textColor = [UIColor colorWithHexString:@"444444"];
    [bottomView addSubview:totalLabel];
    [totalLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(10);
        make.height.mas_offset(44);
        make.top.mas_offset(0);
    }];
//    _priceNumberLabel = [[UILabel alloc] init];
//    _priceNumberLabel.textColor = redTextColor;
//    NSString *orderPrice = [NSString stringWithFormat:@"%@",_orderDiction[@"price"]];
//    NSString *orderNum = [NSString stringWithFormat:@"%@",_orderDiction[@"shopNum"]];
//    double price = [orderPrice doubleValue];
//    double num = [orderNum doubleValue];
//    totalMoney = price * num;
//    remain = totalMoney;
//    totalPriceLabel.text = [NSString stringWithFormat:@"￥ %.2f",totalMoney];
//    NSString *totalPrice = [NSString stringWithFormat:@"%.2f",totalMoney];
//    NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"￥ %@",totalPrice]];
//    [AttributedStr addAttribute:NSFontAttributeName
//                          value:[UIFont systemFontOfSize:15.0]
//                          range:NSMakeRange(0, 2)];
//    [AttributedStr addAttribute:NSFontAttributeName
//                          value:[UIFont fontWithName:@"Arial Rounded MT Bold" size:15]
//                          range:NSMakeRange(2, totalPrice.length)];
//    _priceNumberLabel.attributedText = AttributedStr;
//    [bottomView addSubview:_priceNumberLabel];
//    [_priceNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(totalLabel.mas_right).offset(0);
//        //        make.width
//        make.top.mas_offset(0);
//        make.height.mas_offset(44);
//    }];
 
//    UIButton *sendOrderButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    sendOrderButton.backgroundColor = [UIColor colorWithHexString:@"6493fe"];
//    [sendOrderButton setTitle:@"提交订单" forState:UIControlStateNormal];
//    sendOrderButton.titleLabel.font = [UIFont systemFontOfSize:15];
//    [sendOrderButton addTarget:self action:@selector(sendOrderClick:) forControlEvents:UIControlEventTouchUpInside];
//    [bottomView addSubview:sendOrderButton];
//    [sendOrderButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.mas_offset(0);
//        make.width.mas_offset(120);
//        make.top.mas_offset(0);
//        make.height.mas_offset(44);
//    }];
//
    
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //    if (dataArray > 0) {
//    NSLog(@"===%lu",[_dataArray[section][@"productList"]count]);
    NSArray *dataArray;
    if (section >0) {
        
        dataArray =((OrderPriceModel*)_dataArray[section-1]).productList;
        
    }
//    return  section == 0 ? 1  :  [_dataArray[section-1][@"productList"]count];
    return  section == 0 ? 1  : dataArray.count;

//    return 1;
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _dataArray.count + 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (haveAdress == YES) {
            return 72;
        }else {
            return 50;
        }
    }else {
        return 190;
    }
 
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
//    return section == 0 ? 0 : ([_dataArray[section-1][@"productList"]count] *90);
    return section == 0 ? 0 : (((OrderPriceModel*)_dataArray[section-1]).productList.count *90);
    
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headView = nil;
    if (section > 0 ) {
//        UIView *sectionHead = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KWIDTH, 90*[_dataArray[section-1][@"productList"]count])];
         UIView *sectionHead = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KWIDTH, 90*[((OrderPriceModel*)_dataArray[section-1]).productList count])];
        
       
        sectionHead.backgroundColor = [UIColor whiteColor];
        
        for (int i = 0; i < ((OrderPriceModel*)_dataArray[section-1]).productList.count; i++  ) {
            NSString *price;
            NSString *priceNumber;
//            NSString *totalNumber;
            UIImageView *_headImage = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10+90*i, 70, 70)];
            _headImage.layer.cornerRadius = 5;
            
//
            
//            NSString *imageUrl = [NSString stringWithFormat:@"%@%@",HTTPUrl,_dataArray[section-1][@"productList"][i][@"product"][@"productphotos"][0][@"photo"]];
            
         DetailOrderPriceModel *detailModle =   (DetailOrderPriceModel *)(((OrderPriceModel*)_dataArray[section-1]).productList[i]);
//         NSDictionary *dic =   (NSDictionary *)( detailModle.productphotos.firstObject);
            
//            NSString *imageUrl = [dic objectForKey:@"photo"];
          
            
            NSString *imageUrl;
            if (detailModle.productphotos.count > 0) {
               
                imageUrl = [NSString stringWithFormat:@"%@%@",HTTPUrl,detailModle.photo];
            }else {
                imageUrl = @"";
            }
            
            [_headImage sd_setImageWithURL:[NSURL URLWithString:imageUrl]];
            
            _headImage.layer.masksToBounds = YES;
            [sectionHead addSubview:_headImage];
            
            UILabel *_headLabel = [[UILabel alloc] initWithFrame:CGRectMake(90, 25+90*i, KWIDTH-90-15, 20)];
            
//            NSString *title = [NSString stringWithFormat:@"%@",_dataArray[section-1][@"productList"][i][@"product"][@"productname"]];
            NSString *title =detailModle.productname;
           
            _headLabel.text = title;
            
            _headLabel.textColor = [UIColor colorWithHexString:@"444444"];
            _headLabel.font = [UIFont systemFontOfSize:13];
            [sectionHead addSubview:_headLabel];
            
            UILabel *_priceLabel = [[UILabel alloc] init];
            _priceLabel.frame = CGRectMake(90, 50+90*i, 100, 20);
            _priceLabel.font = [UIFont systemFontOfSize:15];
            
//            NSString *orderPrice = [NSString stringWithFormat:@"%@",_dataArray[section-1][@"productList"][i][@"product"][@"price"]];
            NSString *orderPrice =detailModle.price;
            
    
//            price = [NSDecimalNumber decimalNumberWithString:orderPrice];
            price = orderPrice;

            NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"￥ %@",orderPrice]];
            [AttributedStr addAttribute:NSFontAttributeName
                                  value:[UIFont systemFontOfSize:15.0]
                                  range:NSMakeRange(0, 2)];
            [AttributedStr addAttribute:NSFontAttributeName
                                  value:[UIFont fontWithName:@"Arial Rounded MT Bold" size:15]
                                  range:NSMakeRange(2, orderPrice.length)];
            _priceLabel.attributedText = AttributedStr;
            
            _priceLabel.textColor = [UIColor colorWithHexString:@"ff3a00"];
            [sectionHead addSubview:_priceLabel];

            UILabel *_numberLabel = [[UILabel alloc] init];
            _numberLabel.frame = CGRectMake(200,50+90*i, 100, 20);
            _numberLabel.textColor = [UIColor colorWithHexString:@"999999"];
            _numberLabel.font = [UIFont systemFontOfSize:12];
            
//            _numberLabel.text = [NSString stringWithFormat:@"x%@",_dataArray[section-1][@"productList"][i][@"productnum"]];
            _numberLabel.text =[NSString stringWithFormat:@"x%@",detailModle.productnum];
//            priceNumber = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",_dataArray[section-1][@"productList"][i][@"productnum"]]];
             priceNumber =detailModle.productnum;
            [sectionHead addSubview:_numberLabel];
            [_numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(_priceLabel.mas_right).offset(8);
                make.height.mas_offset(10);
                //        make.bottom.mas_offset(-10);
                make.centerY.equalTo(_priceLabel.mas_centerY).offset(0);
                //        make.width.mas_offset(50);
            }];            
//            OrderHeadView *sectionHead = [[OrderHeadView alloc] initWithFrame:CGRectMake(0, 0, KWIDTH, 90*i)];
//            sectionHead.headImage.image = [UIImage imageNamed:@"picture1"];
//            totalNumber = [priceNumber decimalNumberByMultiplyingBy:price];
//            NSLog(@"总价钱是=%@",totalNumber);
            
        }
        
   headView = sectionHead;
        
        
    }else {
        UIView *bgview = [[UIView alloc] initWithFrame:CGRectZero];
        headView = bgview;
    }
    return headView;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = nil;
    if (indexPath.section == 0) {
        if (haveAdress == YES) {
            OrderDetailAdressCell *orderDetailAressCell = [[OrderDetailAdressCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:orderDetailAdressCellID];
            if ([adressDiction count] != 0) {
                orderDetailAressCell.nameLabel.text = [NSString stringWithFormat:@"%@",adressDiction[@"Name"]];
                orderDetailAressCell.phoneLabel.text = [NSString stringWithFormat:@"%@",adressDiction[@"Phone"]];
                orderDetailAressCell.detailAdressLabel.text = [NSString stringWithFormat:@"%@%@%@%@",adressDiction[@"ProvinceName"],adressDiction[@"CityName"],adressDiction[@"RegionName"],adressDiction[@"DetailAddress"]];
            }
            
            cell = orderDetailAressCell;
            
        }else {
            OrderAdressTableViewCell *adressCell = [[OrderAdressTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:orderAdressCellID];
            adressCell.adressLabel.text = @"请添加收货地址";
            cell = adressCell;
        }
    }else {
        ShopCarOrderCell *orderCell = [[ShopCarOrderCell alloc] init];
    
        
        cell = orderCell;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
    
        AdressViewController *adress = [AdressViewController new];
        
        adress.fromVCid = @"1";
        [self.navigationController pushViewController:adress animated:YES];
    }
}
#pragma mark ---订单价钱处理
- (void)orderPriceHandling {
    
    
    
    
}
#pragma mark---传过来的地址
- (void)selectedAdress:(NSNotification *)notification{
    NSLog(@"接受到通知");
    NSDictionary *dic = notification.userInfo;
    NSLog( @"######%@",dic);
    adressDiction = dic;
    haveAdress = YES;
    [_orderTableView reloadData];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)backButtonClick {
    self.navigationController.navigationBar.hidden = NO;
    [self.navigationController popViewControllerAnimated:YES];
}
- (UILabel *)creatLabeltext:(NSString *)text {
    UILabel *label = [[UILabel alloc] init];
    label.textColor = redTextColor;
    label.text = text;
    label.font = [UIFont systemFontOfSize:13];
    
    
    return label;
}



@end
