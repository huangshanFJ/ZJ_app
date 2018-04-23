//
//  SettlementViewController.m
//  ZhongJianMalliOS
//
//  Created by 段 on 2017/11/29.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "SettlementViewController.h"
#import "OrderAdressTableViewCell.h"
#import "OrderHeadView.h"
#import "OrderNumberCell.h"
#import "OrderCouponCell.h"
#import "OrderCouponNumberCell.h"
#import "OrderDetailAdressCell.h"
#import "AddNewAdressViewController.h"
#import "AdressViewController.h"
#import "MyOrderViewController.h"
#import "YNPayPasswordView.h"
#import "OrderPriceModel.h"
#import "DetailOrderPriceModel.h"
#import "ShopSettleCell.h"
#import "ShopOrderModel.h"
#import "ShopOrderSubModel.h"
#import "MJExtension.h"

//#import "PaymentPassViewController.h"
#import "PasswordAlertView.h"
#import "UIAlertController+ZJAdditions.h"

#import "ZJPaymentPswLogic.h"
#import "ZJHandleOrderCLogic.h"
#import "ZJCreateOrderLogic.h"

@interface SettlementViewController ()<UITableViewDelegate,UITableViewDataSource,PasswordAlertViewDelegate,VerifyPaymentPswDelegate,HandleOrderCDelegate,CreateOrderLogicDelegate>{
    BOOL haveAdress;
    int number;
    NSDictionary *dataDiction;
    NSDictionary *priceDiction;
    double totalMoney;
    
    UILabel *totalPriceLabel;//总金额
    UILabel *redMoneyPriceLabel;//现金红包
    UILabel *shopPriceLabel;//购物币
    UILabel *redyMoneyPriceLabel;//现金币
    UILabel *integralPriceLabel;//积分
    
    double remain;//实付钱(各种减免最后需要支付的)
    double redPay;//现金红包抵用
    double shopPay;//购物币抵用
    double redyPay;//现金币抵用
    double integralPay;//积分抵用
    
    
}
@property (nonatomic,strong)UITableView *orderTableView;
@property (nonatomic,strong)UILabel *priceNumberLabel;
@property (nonatomic,strong)UISwitch *shoppingSwich;//购物币抵用
@property (nonatomic,strong)UISwitch *redyMoneySwich;//现金币
@property (nonatomic,strong)UISwitch *redSwich;//红包
@property (nonatomic,strong)UISwitch *integralSwich;//积分抵用

@property (nonatomic,strong) NSMutableArray *shopGoodsArray;
@property (nonatomic,strong) NSMutableArray *submitGoodsArray;

@property (nonatomic, strong) PasswordAlertView *passwordAlert;
@property (nonatomic, copy) NSString *orderNoC;


@property (nonatomic, strong) ZJCreateOrderLogic *createLogic;
@property (nonatomic, strong) ZJPaymentPswLogic *payLogic;
@property (nonatomic, strong) ZJHandleOrderCLogic *handLogic;

@end
static NSString *const adressCellID = @"OrderAdressTableViewCell";
static NSString *const orderNumberCellID = @"OrderNumberCell";
static NSString *const orderCouponCCellID = @"OrderCouponCell";
static NSString *const orderCouponNumberCellID = @"OrderCouponNumberCell";
static NSString *const orderDetailAdressCellID = @"OrderDetailAdressCell";

static NSString *const ShopSettleCellID = @"ShopSettleCell";

@implementation SettlementViewController

- (NSMutableArray *)shopGoodsArray{
    if (!_shopGoodsArray) {
        _shopGoodsArray = [NSMutableArray array];
    }
    return _shopGoodsArray;
}

- (NSMutableArray *)submitGoodsArray{
    if (!_submitGoodsArray) {
        _submitGoodsArray = [NSMutableArray array];
    }
    return _submitGoodsArray;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
//    _orderDiction = [NSDictionary dictionary];
    dataDiction = [NSDictionary dictionary];
    priceDiction = [NSDictionary dictionary];
    
    number = 1;
    haveAdress = NO;
    redPay = 0;//现金红包抵用
    shopPay = 0;//购物币抵用
    redyPay = 0;//现金币抵用
    integralPay = 0;//积分抵用
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(selectedAdress:) name:@"selectedAdress" object:nil];
    [self requestData];
    [self setNav];
    
    [self creatTableView];
    
    [self setBottomView];
    
//    [self.view addSubview:self.passwordAlert];
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
            //hide by zy
//            if ([responseObject[@"data"] isEqualToString:@""] || [responseObject[@"data"] count] < 2) {
            if ([responseObject[@"data"] isKindOfClass:[NSString class]] || [responseObject[@"data"] count] < 2) {
                
                
                NSLog(@"111");
                
            }else{

                dataDiction = responseObject[@"data"];
                if ([dataDiction count] != 0) {
                    haveAdress = YES;
                }else {
                    haveAdress = NO;
                }
            }
           
        }else {
            
            NSString *title = [NSString stringWithFormat:@"%@",responseObject[@"error_message"]];
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:nil preferredStyle:UIAlertControllerStyleAlert];
            [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
//                LoginViewController *login = [LoginViewController new];
                
//                [self.navigationController pushViewController:login animated:YES];
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
            priceDiction = responseObject[@"data"][@"personDataMap"];
            [_orderTableView reloadData];
            
            if (self.isFromShop) {
                [self updateBelance1];
            }

        }
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
        [hud hideAnimated:YES];
    }];
    
    
}
- (void)setNav {
//    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    [backButton addTarget:self action:@selector(backButtonClick) forControlEvents:UIControlEventTouchUpInside];
//    backButton.tag = 100;
//    [backButton setBackgroundImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
//    [self.view addSubview:backButton];
//    [backButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_offset(10);
//        make.width.mas_offset(20);
//        make.height.mas_offset(20);
//        make.top.mas_offset(30);
//    }];
    
    UIView *backView = [[UIView alloc] init];
    [backView addTapGestureRecognizer:self action:@selector(backButtonClick)];
    [self.view addSubview:backView];
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(10);
        make.width.mas_offset(40);
        make.height.mas_offset(40);
        make.top.mas_offset(30);
    }];
    
    UIImageView *backImg = [[UIImageView alloc] init];
    [backImg setImage:[UIImage imageNamed:@"back"]];
    [backView addSubview:backImg];
    [backImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(0);
        make.width.mas_offset(20);
        make.height.mas_offset(20);
        make.top.mas_offset(0);
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
//    _orderTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    UIView *footView = [[UIView alloc] init];
   
    footView.backgroundColor = [UIColor whiteColor];
    UILabel *totalMoneyLabel = [self creatLabeltext:@"订单总金额"];
    [footView addSubview:totalMoneyLabel];
    [totalMoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(10);
        make.height.mas_offset(15);
        make.top.mas_offset(5);
    }];
    totalPriceLabel = [self creatLabeltext:[NSString stringWithFormat:@"￥%.2f",totalMoney]];
    totalPriceLabel.textAlignment = 2;
    [footView addSubview:totalPriceLabel];
    [totalPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-10);
        make.height.mas_offset(15);
        make.top.mas_offset(5);
    }];
    UILabel *redMoneyLabel = [self creatLabeltext:@"现金红包抵用"];
    [footView addSubview:redMoneyLabel];
    [redMoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(totalMoneyLabel.mas_bottom).offset(5);
        make.left.mas_offset(10);
        make.height.mas_offset(15);
    }];
    redMoneyPriceLabel = [self creatLabeltext:@"-￥0.00"];
    redMoneyPriceLabel.textAlignment = 2;
    [footView addSubview:redMoneyPriceLabel];
    [redMoneyPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-10);
        make.height.mas_offset(15);
        make.top.equalTo(totalMoneyLabel.mas_bottom).offset(5);
    }];
    UILabel *shopLabel = [self creatLabeltext:@"购物币抵用"];
    [footView addSubview:shopLabel];
    [shopLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(redMoneyLabel.mas_bottom).offset(5);
        make.left.mas_offset(10);
        make.height.mas_offset(15);
    }];
    shopPriceLabel = [self creatLabeltext:@"-￥0.00"];
    shopPriceLabel.textAlignment = 2;
    [footView addSubview:shopPriceLabel];
    [shopPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-10);
        make.height.mas_offset(15);
        make.top.equalTo(redMoneyLabel.mas_bottom).offset(5);
    }];
    
    UILabel *redyLabel = [self creatLabeltext:@"现金币抵用"];
    [footView addSubview:redyLabel];
    [redyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(shopLabel.mas_bottom).offset(5);
        make.left.mas_offset(10);
        make.height.mas_offset(15);
    }];
    redyMoneyPriceLabel = [self creatLabeltext:@"-￥0.00"];
    redyMoneyPriceLabel.textAlignment = 2;
    [footView addSubview:redyMoneyPriceLabel];
    [redyMoneyPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-10);
        make.height.mas_offset(15);
        make.top.equalTo(shopLabel.mas_bottom).offset(5);
    }];
    if ([_isVIP intValue] == 1)  {
        footView.frame = CGRectMake(0, 0, KWIDTH, 22*5);
        UILabel *insLabel = [self creatLabeltext:@"积分抵用"];
        [footView addSubview:insLabel];
        [insLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(redyLabel.mas_bottom).offset(5);
            make.left.mas_offset(10);
            make.height.mas_offset(15);
        }];
        integralPriceLabel = [self creatLabeltext:@"-￥0.00"];
        integralPriceLabel.textAlignment = 2;
        [footView addSubview:integralPriceLabel];
        [integralPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_offset(-10);
            make.height.mas_offset(15);
            make.top.equalTo(redyLabel.mas_bottom).offset(5);
        }];
        
        
        
    }else {
        footView.frame = CGRectMake(0, 0, KWIDTH, 22*4);
    }
    
    _orderTableView.tableFooterView = footView;
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
    _priceNumberLabel = [[UILabel alloc] init];
    _priceNumberLabel.textColor = redTextColor;
    
   
    if (self.isFromShop) {
        NSInteger sum= 0;
        for (OrderPriceModel *model in self.dataArray) {
            for (DetailOrderPriceModel *detailModle in model.productList) {
                [self.shopGoodsArray addObject:detailModle];
                sum+=([detailModle.price doubleValue] *[detailModle.productnum doubleValue]);
            }
        }

        totalMoney = sum;
        
    }else{
        
        NSString *  orderPrice = [NSString stringWithFormat:@"%@",_orderDiction[@"price"]];
         NSString * orderNum = [NSString stringWithFormat:@"%@",_orderDiction[@"shopNum"]];
        double price = [orderPrice doubleValue];
        double num = [orderNum doubleValue];
        totalMoney = price * num;
        remain = totalMoney;

    }
    
    totalPriceLabel.text = [NSString stringWithFormat:@"￥ %.2f",totalMoney];
    NSString *totalPrice = [NSString stringWithFormat:@"%.2f",totalMoney];
    NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"￥ %@",totalPrice]];
    [AttributedStr addAttribute:NSFontAttributeName
                          value:[UIFont systemFontOfSize:15.0]
                          range:NSMakeRange(0, 2)];
    [AttributedStr addAttribute:NSFontAttributeName
                          value:[UIFont fontWithName:@"Arial Rounded MT Bold" size:15]
                          range:NSMakeRange(2, totalPrice.length)];
    _priceNumberLabel.attributedText = AttributedStr;
    [bottomView addSubview:_priceNumberLabel];
    [_priceNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(totalLabel.mas_right).offset(0);
//        make.width
        make.top.mas_offset(0);
        make.height.mas_offset(44);
    }];
    
    
    UIButton *sendOrderButton = [UIButton buttonWithType:UIButtonTypeCustom];
    sendOrderButton.backgroundColor = [UIColor colorWithHexString:@"6493fe"];
    [sendOrderButton setTitle:@"提交订单" forState:UIControlStateNormal];
    sendOrderButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [sendOrderButton addTarget:self action:@selector(sendOrderClick:) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:sendOrderButton];
    [sendOrderButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(0);
        make.width.mas_offset(120);
        make.top.mas_offset(0);
        make.height.mas_offset(44);
    }];

}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (self.isFromShop) {
        
        if (section == 0) {
            return 1;
        }else{
            
            OrderPriceModel *model =(OrderPriceModel *)self.dataArray[section-1];
            return model.productList.count;
        }
        
    }else{
        
        if (section == 0) {
            return 1;
        }else if(section == 1) {
            return 1;
        }
        //hide by zy
        else if (section == 2) {
            
            if ([_isVIP intValue] == 1) {
                return 4;
            }else {
                return 3;
            }
        }
        
        else {
            return 1;
        }
        
        
    }
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (self.isFromShop) {
        
        
        return self.dataArray.count+1;
        
    }else{
        return 3;
    }

    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (self.isFromShop) {
        
        return 0;
        
    }else{
        
        return section == 1 ? 90 : 0;

    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.isFromShop) {
        if (haveAdress == YES) {
           
             return indexPath.section == 0 ? 72 : 90;
            
        }else{
            return indexPath.section == 0 ? 50 : 90;
        }
        
    }else{
        if (haveAdress == YES) {
            if (indexPath.section == 0) {
                return 72;
            }else if (indexPath.section == 1) {
                return 36;//94;
            }else {
                return 50;
            }
            
        }else{
            return indexPath.section == 1 ? 36 : 50;//94
        }
        
        
    }

    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 7;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headView = nil;
    
    if (self.isFromShop) {
        
        
    }else{
        
        if (section == 1) {
            
            OrderHeadView *sectionHead = [[OrderHeadView alloc] initWithFrame:CGRectMake(0, 0, KWIDTH, 90)];
            sectionHead.headImage.image = [UIImage imageNamed:@"picture1"];
            [sectionHead.headImage sd_setImageWithURL:[NSURL URLWithString:_orderDiction[@"imageUrl"]]];
            sectionHead.headLabel.text = _producername;
            NSString *orderPrice = [NSString stringWithFormat:@"%@",_orderDiction[@"price"]];
            NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"￥ %@",orderPrice]];
            [AttributedStr addAttribute:NSFontAttributeName
                                  value:[UIFont systemFontOfSize:15.0]
                                  range:NSMakeRange(0, 2)];
            [AttributedStr addAttribute:NSFontAttributeName
                                  value:[UIFont fontWithName:@"Arial Rounded MT Bold" size:15]
                                  range:NSMakeRange(2, orderPrice.length)];
            sectionHead.priceLabel.attributedText = AttributedStr;
            sectionHead.numberLabel.text = [NSString stringWithFormat:@"x%@",_orderDiction[@"shopNum"]];//@"x1";
            
            headView = sectionHead;
        }else {
            UIView *bgview = [[UIView alloc] initWithFrame:CGRectZero];
            headView = bgview;
        }
        
    }
    
    return headView;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KWIDTH, 7)];
    
    return footView;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    UITableViewCell *cell = nil;
    if (indexPath.section == 0) {
        if (haveAdress == YES) {
            OrderDetailAdressCell *orderDetailAressCell = [[OrderDetailAdressCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:orderDetailAdressCellID];
            if ([dataDiction count] != 0) {
                orderDetailAressCell.nameLabel.text = [NSString stringWithFormat:@"%@",dataDiction[@"Name"]];
                orderDetailAressCell.phoneLabel.text = [NSString stringWithFormat:@"%@",dataDiction[@"Phone"]];
                orderDetailAressCell.detailAdressLabel.text = [NSString stringWithFormat:@"%@%@%@%@",dataDiction[@"ProvinceName"],dataDiction[@"CityName"],dataDiction[@"RegionName"],dataDiction[@"DetailAddress"]];
            }

            cell = orderDetailAressCell;
            
        }else {
            OrderAdressTableViewCell *adressCell = [[OrderAdressTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:adressCellID];
            adressCell.adressLabel.text = @"请添加收货地址";
            cell = adressCell;
        }
        
        
    }
    
    if (self.isFromShop) {
        if (indexPath.section != 0) {
            
            ShopSettleCell *cell = [[ShopSettleCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ShopSettleCellID];
            
            
            DetailOrderPriceModel *detailModle =   (DetailOrderPriceModel *)(((OrderPriceModel*)_dataArray[indexPath.section-1]).productList[indexPath.row]);
            
            NSString *imageUrl;
            if (detailModle.productphotos.count > 0) {
                
                imageUrl = [NSString stringWithFormat:@"%@%@",HTTPUrl,detailModle.photo];
            }else {
                imageUrl = @"";
            }
            
            cell.headImage.image = [UIImage imageNamed:@"picture1"];
            [cell.headImage sd_setImageWithURL:[NSURL URLWithString:imageUrl]];
            
            
            cell.headLabel.text = detailModle.productname;;
            
            
            NSString *orderPrice =detailModle.price;
            
            
            NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"￥ %@",orderPrice]];
            [attributedStr addAttribute:NSFontAttributeName
                                  value:[UIFont systemFontOfSize:15.0]
                                  range:NSMakeRange(0, 2)];
            [attributedStr addAttribute:NSFontAttributeName
                                  value:[UIFont fontWithName:@"Arial Rounded MT Bold" size:15]
                                  range:NSMakeRange(2, orderPrice.length)];
            
            cell.priceLabel.attributedText = attributedStr;
            
            
            cell.numberLabel.text = [NSString stringWithFormat:@"x%@",detailModle.productnum];//@"x1";
            cell.selectionStyle = UITableViewCellSelectionStyleNone;

            
            return cell;
        }
        
    }else{
        
        if (indexPath.section == 1) {
            OrderNumberCell *numberCell = [[OrderNumberCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:orderNumberCellID];
            
            //        };
            numberCell.costClassLabel.text = @"免邮";
            
            cell = numberCell;
        }
        
        // hide by zy
        else if(indexPath.section == 2){
            
            OrderCouponCell *couponCell = [[OrderCouponCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:orderCouponCCellID];
            if (!couponCell) {
                couponCell = [[OrderCouponCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:orderCouponCCellID];
            }
            if (indexPath.row == 0) {
                
                _redSwich = [[UISwitch alloc] init];
                _redSwich.on = NO;//设置初始为ON的一边
                
                _redSwich.onTintColor = [UIColor colorWithHexString:@"6493fe"];
                [_redSwich addTarget:self action:@selector(redSwitchAction:) forControlEvents:UIControlEventValueChanged];
                [couponCell addSubview:_redSwich];
                [_redSwich mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.right.mas_offset(-25);
                    make.width.mas_offset(35);
                    make.height.mas_offset(21);
                    make.top.mas_offset(10);
                }];
                
            }else if (indexPath.row == 1) {
                _shoppingSwich = [[UISwitch alloc] init];
                _shoppingSwich.on = NO;//设置初始为ON的一边
                
                
                _shoppingSwich.onTintColor = [UIColor colorWithHexString:@"6493fe"];
                [_shoppingSwich addTarget:self action:@selector(shopSwitchAction:) forControlEvents:UIControlEventValueChanged];
                [couponCell addSubview:_shoppingSwich];
                [_shoppingSwich mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.right.mas_offset(-25);
                    make.width.mas_offset(35);
                    make.height.mas_offset(21);
                    make.top.mas_offset(10);
                }];
            }else if(indexPath.row == 2){
                
                _redyMoneySwich = [[UISwitch alloc] init];
                _redyMoneySwich.on = NO;//设置初始为ON的一边
                _redyMoneySwich.onTintColor = [UIColor colorWithHexString:@"6493fe"];
                [_redyMoneySwich addTarget:self action:@selector(redyMoneySwitchAction:) forControlEvents:UIControlEventValueChanged];
                [couponCell addSubview:_redyMoneySwich];
                [_redyMoneySwich mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.right.mas_offset(-25);
                    make.width.mas_offset(35);
                    make.height.mas_offset(21);
                    make.top.mas_offset(10);
                }];
                
            }else if (indexPath.row == 3) {
                _integralSwich = [[UISwitch alloc] init];
                _integralSwich.on = NO;//设置初始为ON的一边
                
                _integralSwich.onTintColor = [UIColor colorWithHexString:@"6493fe"];
                [_integralSwich addTarget:self action:@selector(integralSwitchAction:) forControlEvents:UIControlEventValueChanged];
                [couponCell addSubview:_integralSwich];
                [_integralSwich mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.right.mas_offset(-25);
                    make.width.mas_offset(35);
                    make.height.mas_offset(21);
                    make.top.mas_offset(10);
                }];
                
            }
            if ([priceDiction count] != 0) {
                if ([_isVIP intValue] == 1) {
                    NSString *text2 = [NSString stringWithFormat:@"可用现金红包￥%.1f",[priceDiction[@"Coupon"] doubleValue]];
                    NSString *text = [NSString stringWithFormat:@"可用购物币￥%.1f",[priceDiction[@"RemainPoints"] doubleValue]];
                    NSString *text1 = [NSString stringWithFormat:@"可用现金币￥%.1f",[priceDiction[@"RemainElecNum"] doubleValue]];
                    NSString *text3 = [NSString stringWithFormat:@"可用积分%@",priceDiction[@"RemainVIPAmount"]];
                    NSArray *textArr = @[text2,text,text1,text3];
                    couponCell.titleLabel.text = textArr[indexPath.row];
                    
                }else {
                    NSString *text = [NSString stringWithFormat:@"可用购物币￥%.1f",[priceDiction[@"RemainPoints"] doubleValue]];
                    NSString *text1 = [NSString stringWithFormat:@"可用现金币￥%.1f",[priceDiction[@"RemainElecNum"] doubleValue]];
                   
                    NSString *text2 = [NSString stringWithFormat:@"可用现金红包￥%.1f",[priceDiction[@"Coupon"] doubleValue]];
                    NSArray *textArr = @[text2,text,text1];
                    couponCell.titleLabel.text = textArr[indexPath.row];
                }
                
            }
            
            cell = couponCell;
            
        }
        
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    NSLog(@"点击的是%ld行--%ld个",(long)indexPath.section,indexPath.row);
    if (indexPath.section == 0) {
//        AddNewAdressViewController *addVC = [AddNewAdressViewController new];
//        [self.navigationController pushViewController:addVC animated:YES];
        AdressViewController *adress = [AdressViewController new];
        adress.fromVCid = @"1";
        [self.navigationController pushViewController:adress animated:YES];
    }
    
    
}
//hide by zy
#pragma mark -----积分
-(void)integralSwitchAction:(UISwitch *)sender {
    if (sender.on == YES) {
        _shoppingSwich.on = NO;
        _redSwich.on = NO;
        _redyMoneySwich.on = NO;

    }else {

    }
    [self selectedYesOrNo];
}
#pragma mark -----购物币
-(void)shopSwitchAction:(UISwitch *)sender {

    if (sender.on == YES) {
        _integralSwich.on = NO;

    }else {

    }

    [self selectedYesOrNo];
}
#pragma mark -----现金红包
-(void)redSwitchAction:(UISwitch *)sender {

    if (sender.on == YES) {
        _integralSwich.on = NO;

    }else {

    }
    [self selectedYesOrNo];
}
#pragma mark -----现金bi
-(void)redyMoneySwitchAction:(UISwitch *)sender {

    if (sender.on == YES) {
        _integralSwich.on = NO;

    }else {

    }

    [self selectedYesOrNo];
}

- (void)selectedYesOrNo {
    
    //单件商品可用红包
    double elecNum = [_orderDiction[@"elecNum"] doubleValue]/2;
    //商品数量
    NSDecimalNumber *orderNum = [NSDecimalNumber decimalNumberWithString:_orderDiction[@"shopNum"]];;//[NSString stringWithFormat:@"%@",]];
    NSDecimalNumber *elecNumber1 = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%f",elecNum]];
    
    
    
    //积分
//    double elecNum1 = [_orderDiction[@"elecNum"] doubleValue];
//    NSDecimalNumber *elecNumber2 = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%f",elecNum1]];
//    elecNumber2 = [orderNum decimalNumberByMultiplyingBy:elecNumber2];
//    elecNum1 = [elecNumber2 doubleValue];
//
    //实际需要减免的红包总数
    NSDecimalNumber *elecNumber =[orderNum decimalNumberByMultiplyingBy:elecNumber1];
    elecNum =[elecNumber doubleValue];
    
    
    //红包
    NSDecimalNumber *mineElecNumber = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",priceDiction[@"Coupon"]]];
    double mineNumber = [mineElecNumber doubleValue];
    //购物币
    NSDecimalNumber *shopNumber = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",priceDiction[@"RemainPoints"]]];
    //现金币
    NSDecimalNumber *redyNumber = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",priceDiction[@"RemainElecNum"]]];
    
    
    //需要支付的总钱数
    NSDecimalNumber *totalNumber = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%f",totalMoney]];

    NSLog(@"红包总数******%@购物币总数*********现金币总数%@******%@",mineElecNumber,shopNumber,redyNumber );
    //for vip
        double elecNum1 = [_orderDiction[@"elecNum"] doubleValue];
        NSDecimalNumber *elecNumber2 = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%f",elecNum1]];
        elecNumber2 = [orderNum decimalNumberByMultiplyingBy:elecNumber2];
        elecNum1 = [elecNumber2 doubleValue];
    //    //积分
        NSDecimalNumber *remainVIPNumber = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",priceDiction[@"RemainVIPAmount"]]];
    
        if (_integralSwich.on == YES) {
            NSDecimalNumber *remainVIP;
            NSDecimalNumber *remainNum;
            if ([remainVIPNumber doubleValue] > elecNum1) {
                 remainVIP = [totalNumber decimalNumberBySubtracting:elecNumber2];
                remain = [remainVIP doubleValue];
            }else {
                remainVIP = remainVIPNumber;
                remainNum = [totalNumber decimalNumberBySubtracting:remainVIP];
                remain = [remainNum doubleValue];
            }
    
            redPay = 0;
            redyPay = 0;
            shopPay = 0;
    
            if ([remainVIPNumber doubleValue] > elecNum1) {
                integralPriceLabel.text = [NSString stringWithFormat:@"-￥%.2f",elecNum1];
                integralPay = elecNum1;
    
            }else {
                double remainDouble = [remainVIPNumber doubleValue];
                integralPriceLabel.text = [NSString stringWithFormat:@"-￥%.2f",remainDouble];
                integralPay = remainDouble;
            }
    
    
        }else {
            integralPriceLabel.text = [NSString stringWithFormat:@"-￥0.00"];

            if (_redSwich.on == YES && _redyMoneySwich.on == YES && _shoppingSwich.on == YES) {
                NSDecimalNumber *subNum;   //剩余需要支付的
                NSDecimalNumber *remainNum;
                if (mineNumber > elecNum) {
                    subNum = [totalNumber decimalNumberBySubtracting:elecNumber];//减红包
                    redPay = elecNum;
                }else {
                    subNum = [totalNumber decimalNumberBySubtracting:mineElecNumber];
                    redPay = mineNumber;
                }
                redMoneyPriceLabel.text = [NSString stringWithFormat:@"-￥%.2f",redPay];
                
                NSLog(@"红包-%@----",subNum);
                if ([subNum doubleValue] > [shopNumber doubleValue]) {
                    subNum = [subNum decimalNumberBySubtracting:shopNumber];//减购物币
                    shopPay = [shopNumber doubleValue];//购物币抵用
                }else {
                    //                NSDecimalNumber *surplus = [shopNumber decimalNumberBySubtracting:subNum];
                    shopPay = [subNum doubleValue];
                    subNum = [NSDecimalNumber decimalNumberWithString:@"0"];
                }
                NSLog(@"购物币-%@----",subNum);
                if ([subNum doubleValue] > [redyNumber doubleValue]) {
                    subNum = [subNum decimalNumberBySubtracting:redyNumber];//减现金币
                    redyPay = [redyNumber doubleValue];
                }else {
                    //                NSDecimalNumber *surplus = [redyNumber decimalNumberBySubtracting:subNum];
                    redyPay = [subNum doubleValue];
                    subNum = [NSDecimalNumber decimalNumberWithString:@"0"];
                }
                NSLog(@"现金-%@----",subNum);
                
                remainNum = subNum;
                
                remain = [remainNum doubleValue];
                
    
            }else if (_redSwich.on == YES && _redyMoneySwich.on == NO && _shoppingSwich.on == NO) {
                NSDecimalNumber *subNum;
                NSDecimalNumber *remainNum;
    //            subNum = [remainNumber decimalNumberBySubtracting:elecNumber];//减红包
                if (mineNumber > elecNum) {
                    subNum = [totalNumber decimalNumberBySubtracting:elecNumber];//减红包
                    redPay = elecNum;
                }else {
                    subNum = [totalNumber decimalNumberBySubtracting:mineElecNumber];
                    redPay = mineNumber;
                }
    
                 redMoneyPriceLabel.text = [NSString stringWithFormat:@"-￥%.2f",redPay];
    //            redPay = elecNum;
                shopPay = 0;
                redyPay = 0;
                NSLog(@"红包-%@----",subNum);
                remainNum = subNum;
                remain = [remainNum doubleValue];
    
            }
            else if(_redSwich.on == YES && _redyMoneySwich.on == NO && _shoppingSwich.on == YES) {
                NSDecimalNumber *subNum;
                NSDecimalNumber *remainNum;
    //            subNum = [remainNumber decimalNumberBySubtracting:elecNumber];//减红包
                if (mineNumber > elecNum) {
                    subNum = [totalNumber decimalNumberBySubtracting:elecNumber];//减红包
                    redPay = elecNum;
                }else {
                    subNum = [totalNumber decimalNumberBySubtracting:mineElecNumber];
                    redPay = mineNumber;
                }
                 redMoneyPriceLabel.text = [NSString stringWithFormat:@"-￥%.2f",redPay];
    //            redPay = elecNum;
              NSLog(@"红包-%@----",subNum);
                if ([subNum doubleValue] > [shopNumber doubleValue]) {
                    subNum = [subNum decimalNumberBySubtracting:shopNumber];//减购物币
                    shopPay = [shopNumber doubleValue];//购物币抵用
                }else {
    //                NSDecimalNumber *surplus = [shopNumber decimalNumberBySubtracting:subNum];
                    shopPay = [subNum doubleValue];
                    subNum = [NSDecimalNumber decimalNumberWithString:@"0"];
                }
                redyPay = 0;
                NSLog(@"购物币-%@----",subNum);
                remainNum = subNum;
                remain = [remainNum doubleValue];
    
            }else if (_redSwich.on == YES && _redyMoneySwich.on == YES && _shoppingSwich.on == NO) {
                NSDecimalNumber *subNum;
                NSDecimalNumber *remainNum;
    //            subNum = [remainNumber decimalNumberBySubtracting:elecNumber];//减红包
                if (mineNumber > elecNum) {
                    subNum = [totalNumber decimalNumberBySubtracting:elecNumber];//减红包
                    redPay = elecNum;
                }else {
                    subNum = [totalNumber decimalNumberBySubtracting:mineElecNumber];
                    redPay = mineNumber;
                }
                redMoneyPriceLabel.text = [NSString stringWithFormat:@"-￥%.2f",elecNum];
    //            redPay = elecNum;
                if ([subNum doubleValue] > [redyNumber doubleValue]) {
                    subNum = [subNum decimalNumberBySubtracting:redyNumber];//减现金币
                    redyPay = [redyNumber doubleValue];
                }else {
    //                NSDecimalNumber *surplus = [redyNumber decimalNumberBySubtracting:subNum];
    //                redyPay = [surplus doubleValue];
                    redyPay = [subNum doubleValue];
                    subNum = [NSDecimalNumber decimalNumberWithString:@"0"];
                }
                NSLog(@"现金-%@----",subNum);
                shopPay = 0;
    
                remainNum = subNum;
                remain = [remainNum doubleValue];
    
            }else if (_redSwich.on == NO && _redyMoneySwich.on == NO && _shoppingSwich.on == NO) {
                remain = [totalNumber doubleValue];
                shopPay = 0;
                redyPay = 0;
                redPay = 0;
                redMoneyPriceLabel.text = [NSString stringWithFormat:@"-￥0.00"];
    
            }else if (_redSwich.on == NO && _redyMoneySwich.on == YES && _shoppingSwich.on == NO) {
                NSDecimalNumber *subNum;
                NSDecimalNumber *remainNum;
                if ([totalNumber doubleValue] > [redyNumber doubleValue]) {
                    subNum = [totalNumber decimalNumberBySubtracting:redyNumber];//减现金币
                    redyPay = [redyNumber doubleValue];
                }else {
    //                NSDecimalNumber *surplus = [redyNumber decimalNumberBySubtracting:remainNumber];
                    redyPay = [totalNumber doubleValue];
                    subNum = [NSDecimalNumber decimalNumberWithString:@"0"];
                }
                shopPay = 0;
    
                NSLog(@"现金-%@----",subNum);
                redPay = 0;
    
                remainNum = subNum;
                remain = [remainNum doubleValue];
    
            }else if (_redSwich.on == NO && _redyMoneySwich.on == NO && _shoppingSwich.on == YES) {
                NSDecimalNumber *subNum;
                NSDecimalNumber *remainNum;
                if ([totalNumber doubleValue] > [shopNumber doubleValue]) {
                    subNum = [totalNumber decimalNumberBySubtracting:shopNumber];//减购物币
                    shopPay = [shopNumber doubleValue];//购物币抵用
                }else {
    //                NSDecimalNumber *surplus = [shopNumber decimalNumberBySubtracting:remainNumber];
                    shopPay = [totalNumber doubleValue];
                    subNum = [NSDecimalNumber decimalNumberWithString:@"0"];
                }
                NSLog(@"购物币-%@----",subNum);
                redPay = 0;
                redyPay = 0;
    
                remainNum = subNum;
                remain = [remainNum doubleValue];
            }else if (_redSwich.on == NO && _redyMoneySwich.on == YES && _shoppingSwich.on == YES) {
                NSDecimalNumber *subNum;
                NSDecimalNumber *remainNum;
                if ([totalNumber doubleValue] > [shopNumber doubleValue]) {
                    subNum = [totalNumber decimalNumberBySubtracting:shopNumber];//减购物币
                    shopPay = [shopNumber doubleValue];//购物币抵用
                }else {
    //                NSDecimalNumber *surplus = [shopNumber decimalNumberBySubtracting:remainNumber];
    //                shopPay = [surplus doubleValue];
                    shopPay = [totalNumber doubleValue];
                    subNum = [NSDecimalNumber decimalNumberWithString:@"0"];
                }
                  NSLog(@"购物币-%@----",subNum);
                if ([subNum doubleValue] > [redyNumber doubleValue]) {
                    subNum = [subNum decimalNumberBySubtracting:redyNumber];//减现金币
                    redyPay = [redyNumber doubleValue];
                }else {
                    //                NSDecimalNumber *surplus = [redyNumber decimalNumberBySubtracting:subNum];
                    redyPay = [subNum doubleValue];
                    subNum = [NSDecimalNumber decimalNumberWithString:@"0"];
                }
                NSLog(@"现金-%@----",subNum);
    
                redPay = 0;
    
                remainNum = subNum;
                remain = [remainNum doubleValue];
            }
        }
    

    redMoneyPriceLabel.text = [NSString stringWithFormat:@"-￥%.2f",redPay];
    shopPriceLabel.text = [NSString stringWithFormat:@"-￥%.2f",shopPay];
    redyMoneyPriceLabel.text = [NSString stringWithFormat:@"-￥%.2f",redyPay];
    _priceNumberLabel.text = [NSString stringWithFormat:@"￥ %.2f",remain];
}


- (void)updateBelance1{
    //红包
    NSDecimalNumber *mineElecNumber = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",priceDiction[@"Coupon"]]];
    double mineNumber = [mineElecNumber doubleValue];
    //购物币
    NSDecimalNumber *shopNumber = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",priceDiction[@"RemainPoints"]]];
    //现金币
    NSDecimalNumber *redyNumber = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",priceDiction[@"RemainElecNum"]]];
    
    
    NSLog(@"红包总数******%@购物币总数*********现金币总数%@******%@",mineElecNumber,shopNumber,redyNumber );

    
//    @property (nonatomic,strong) NSString *producername;
//    @property (nonatomic,strong) NSString *producerno;
//    @property (nonatomic,strong) NSString *producertel;
    
//    @property (nonatomic,strong) NSString *freight;
//    @property (nonatomic,strong) NSString *memo;
    
    
    
//    @property (nonatomic,strong) NSString *useVIPRemainNum;
    
    
    for (OrderPriceModel *orderModel in self.dataArray) {
        
        //这里是每一单
        ShopOrderModel *shopOrderModel = [[ShopOrderModel alloc] init];
        shopOrderModel.producername = orderModel.producerName;
        shopOrderModel.useVIPRemainNum = @"0";
        
        //每一单的总钱数
        double totalAmount = 0;
        //每一单的实际支付
        double realPay = 0;
        //每一单所用的红包金额
        double useCoupon = 0;
        //每一单所用的购物币
        double usePointNum = 0;
        //每一单所用的现金币
        double useElecNum = 0;
        //每一单的所有商品
        NSMutableArray *perGoodsArray = [NSMutableArray array];
        
        for (DetailOrderPriceModel *detailModel in orderModel.productList) {
            //这里是每一单的一件商品
            ShopOrderSubModel *perGood = [[ShopOrderSubModel alloc] init];
            perGood.productId = detailModel.productID;
            perGood.productNum = detailModel.productnum;
            perGood.specId = detailModel.productSpecID;
            
            
            double goodTotalAmount =[detailModel.price doubleValue] *[detailModel.productnum integerValue];
             NSDecimalNumber *goodTotalNumber = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%f",goodTotalAmount]];
            totalAmount+=goodTotalAmount;
            
            
            //单件商品可用红包
                double elecNum = [detailModel.elecnum doubleValue]/2;
            //商品数量
                NSDecimalNumber *orderNum = [NSDecimalNumber decimalNumberWithString:detailModel.productnum];
            
                NSDecimalNumber *elecNumber1 = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%f",elecNum]];
            
            //实际需要减免的红包总数
                NSDecimalNumber *elecNumber =[orderNum decimalNumberByMultiplyingBy:elecNumber1];
            //实际需要减免的红包总数
                elecNum =[elecNumber doubleValue];
            
          
    
            NSDecimalNumber *subNum;   //剩余需要支付的
            double goodRedPay = 0;
            double goodShopPay = 0;
            double goodRedyPay = 0;
            
            
            if ( mineNumber > elecNum) {
                subNum = [goodTotalNumber decimalNumberBySubtracting:elecNumber];//减红包
                
                goodRedPay = elecNum;
                //更新mineNumber
                mineNumber =mineNumber-elecNum;
               
                
            }else{
                subNum = [goodTotalNumber decimalNumberBySubtracting:mineElecNumber];
                goodRedPay = mineNumber;
                //更新mineNumber
                mineNumber =0;
               
            }
            mineElecNumber =  [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%f",mineNumber]];
            
            //购物币
            if ([subNum doubleValue] > [shopNumber doubleValue]) {
                subNum = [subNum decimalNumberBySubtracting:shopNumber];//减购物币
            
                goodShopPay = [shopNumber doubleValue];//购物币抵用
                //更新购物币
                shopNumber = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%d",0]];;
            }else {
                
                goodShopPay = [subNum doubleValue];
                //更新购物币
                shopNumber = [shopNumber decimalNumberBySubtracting:subNum];

                subNum = [NSDecimalNumber decimalNumberWithString:@"0"];
                
            }
            
           //现金币
            if ([subNum doubleValue] > [redyNumber doubleValue]) {
                subNum = [subNum decimalNumberBySubtracting:redyNumber];//减现金币
                goodRedyPay = [redyNumber doubleValue];
                //更新现金币
                redyNumber = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%d",0]];;
                
            }else {
                
                goodRedyPay = [subNum doubleValue];
                //更新现金币
                shopNumber = [shopNumber decimalNumberBySubtracting:subNum];
                
                subNum = [NSDecimalNumber decimalNumberWithString:@"0"];
              
            }

            shopOrderModel.producerno = detailModel.producerno;
            shopOrderModel.producertel =detailModel.producertel;
            shopOrderModel.freight = @"0";
            shopOrderModel.memo = @"";
            
            realPay +=[subNum doubleValue];
            useCoupon +=goodRedPay;;
            //每一单所用的购物币
            usePointNum += goodShopPay ;
            //每一单所用的现金币
            useElecNum +=goodRedyPay;
            
            [perGoodsArray addObject:perGood];
        }
        //    @property (nonatomic,strong) NSString *realPay;
        //    @property (nonatomic,strong) NSString *totalAmount;
        //    @property (nonatomic,strong) NSString *useCoupon;
        //    @property (nonatomic,strong) NSString *useElecNum;
        //    @property (nonatomic,strong) NSString *usePointNum;
        //    @property (nonatomic,strong) NSArray *orderLines;

        
        
        shopOrderModel.realPay =[NSString stringWithFormat:@"%.1f",realPay] ;
        shopOrderModel.totalAmount =[NSString stringWithFormat:@"%.1f",totalAmount];
        shopOrderModel.useCoupon = [NSString stringWithFormat:@"%.1f",useCoupon];
        shopOrderModel.useElecNum =[NSString stringWithFormat:@"%.1f",useElecNum];
        shopOrderModel.usePointNum =[NSString stringWithFormat:@"%.1f",usePointNum];
        shopOrderModel.orderLines = perGoodsArray;
        [self.submitGoodsArray addObject:shopOrderModel];
        
        remain+= realPay;
        redPay += useCoupon;
        shopPay +=usePointNum;
        redyPay +=useElecNum;
        
        
    }
    
    
    redMoneyPriceLabel.text = [NSString stringWithFormat:@"-￥%.1f",redPay];
    shopPriceLabel.text = [NSString stringWithFormat:@"-￥%.1f",shopPay];
    redyMoneyPriceLabel.text = [NSString stringWithFormat:@"-￥%.1f",redyPay];
    _priceNumberLabel.text = [NSString stringWithFormat:@"￥ %.1f",remain];
    
}


#pragma mark---传过来的地址
- (void)selectedAdress:(NSNotification *)notification{
    NSLog(@"接受到通知");
    NSDictionary *dic = notification.userInfo;
    NSLog( @"######%@",dic);
    dataDiction = dic;
    haveAdress = YES;
    [_orderTableView reloadData];
    
}
//提交订单
- (void)sendOrderClick:(UIButton*)sender {
  
    
    NSString *adrressId = [NSString stringWithFormat:@"%@",dataDiction[@"Id"]];
    NSLog(@"%@",adrressId);
    if (adrressId.length == 0 || [adrressId isEqualToString:@"(null)"]) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"请选择收货地址" message:nil preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }]];
        [self presentViewController:alert animated:YES completion:^{
            
        }];
        return;
        
    }
   
    
    NSDictionary *orderDic;
    if (self.isFromShop) {
        
        NSMutableArray *orderHeads = [NSMutableArray array];
        for (ShopOrderModel *orderMode in self.submitGoodsArray) {
            
            NSDictionary *modelDic = orderMode.mj_keyValues;
            [orderHeads addObject:modelDic];
        }
        
        orderDic = @{
                     @"adrressId":adrressId,
                     @"orderHeads":orderHeads
                     
                     };
      
    }else {
 
        NSDecimalNumber *realPay = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%f",remain]];
        NSDecimalNumber *totalPay = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%f",totalMoney]];
        NSDecimalNumber *useCoupon = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%f",redPay]];
        NSDecimalNumber *useElecNum = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%f",redyPay]];
        NSDecimalNumber *usePointNum = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%f",shopPay]];
        NSDecimalNumber *useVIPRemainNum = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%f",integralPay]];

        orderDic = @{
                                   @"adrressId":adrressId,
                                   @"orderHeads":@[
                                           @{@"producername":_producername,
                                             @"producerno":_producerno,
                                             @"producertel":_producertel,
                                             @"freight":@0,
                                             @"memo":@"",
                                             @"orderLines":@[
                                                     @{@"productId":_productId,
                                                    @"productNum":_orderDiction[@"shopNum"],
                                                       @"specId":_orderDiction[@"specId"]
                                                       }
                                                     ],
                                             @"realPay":realPay,
                                             @"totalAmount":totalPay,
                                             @"useCoupon":useCoupon,
                                             @"useElecNum":useElecNum,
                                             @"usePointNum":usePointNum,
                                             @"useVIPRemainNum":useVIPRemainNum
                                             } 
                                           ]
                                   
                                   };
       }
    
    _createLogic = [[ZJCreateOrderLogic alloc] init];
    _createLogic.delegate = self;
    [_createLogic createOrderWithParams:orderDic];
    
    
 /*
        NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
        NSString *token = [user objectForKey:@"userToken"];
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        manager.responseSerializer = [AFJSONResponseSerializer new];
        manager.requestSerializer=[AFJSONRequestSerializer serializer];
        [manager.requestSerializer setValue:@"application/json"
                         forHTTPHeaderField:@"Content-Type"];
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        //        NSNumber *isNormal = [NSNumber numberWithInteger:IsDefault];
        NSString *url = [NSString stringWithFormat:@"%@%@%@",HTTPUrl,@"/zjapp/v1/PersonalCenter/createBOrder/",token];
        [manager POST:url parameters:orderDic progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSLog(@"%@",responseObject);
            if ([responseObject[@"error_code"] integerValue] == 0) {
                NSString *type = [NSString stringWithFormat:@"%@",responseObject[@"data"][@"type"]];
                if ([type isEqualToString:@"1"]) {
                    NSString *orderUrl = [NSString stringWithFormat:@"%@%@%@",HTTPUrl,@"/zjapp/v1/PersonalCenter/syncHandleOrderC/",token];
                    NSString *orderNoC = [NSString stringWithFormat:@"%@",responseObject[@"data"][@"orderNoC"]];
                    [self setOrderURL:orderUrl orderNo:orderNoC];
                    
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
  
 */
}

- (void)setOrderURL:(NSString *)url orderNo:(NSString *)order {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer new];
 
    NSDictionary *paramete = @{
                               @"orderNoC":order
                               };
    self.orderNoC = order;
    [manager POST:url parameters:paramete progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",responseObject);
        if ([responseObject[@"error_code"] intValue] == 0) {
            
            //跳转支付密码框
            __weak typeof(self) weakSelf = self;
        
            [weakSelf.passwordAlert show];
            [weakSelf.view addSubview:weakSelf.passwordAlert];
        
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
- (UILabel *)creatLabeltext:(NSString *)text {
    UILabel *label = [[UILabel alloc] init];
    label.textColor = redTextColor;
    label.text = text;
    label.font = [UIFont systemFontOfSize:13];
    
    
    return label;
}

#pragma mark - lazy PasswordAlert
- (PasswordAlertView *)passwordAlert {
    if (!_passwordAlert) {
        _passwordAlert = [[PasswordAlertView alloc] initWithType:PasswordAlertViewType_default];
        _passwordAlert.delegate = self;
        _passwordAlert.titleLable.text = @"请输入密码";
        _passwordAlert.tipsLalbe.text = @"您输入的密码不正确";
    }
    return _passwordAlert;
}

#pragma mark - PasswordAlertViewDelegate
//点击了确定按钮或者是完成了6位密码的输入
- (void)PasswordAlertViewCompleteInputWith:(NSString *)password {
   
    _payLogic = [ZJPaymentPswLogic new];
    _payLogic.delegate = self;
    
    [_payLogic verifyPaymentPassWord:password];
    
    
    /*
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *token = [user objectForKey:@"userToken"];
    NSDictionary *dic = @{
                          @"toKen":token,
                          @"payPassword":password
                          };
    __weak typeof(self) weakSelf = self;
    [ZJServices verifyPassWord:dic successBlock:^(id  _Nullable responseObject) {
        if ([responseObject[@"error_code"] intValue] == 0) {
            //处理订单号
            [weakSelf requestData:self.orderNoC];
//            dispatch_sync(dispatch_get_main_queue(), ^{
//                [weakSelf.passwordAlert passwordCorrect];
//            });
        } else if ([responseObject[@"error_code"] intValue] == -1) {
            //提醒未设置支付密码
            dispatch_sync(dispatch_get_main_queue(), ^{
                [weakSelf.passwordAlert passswordNotSetting];
            });
        } else if ([responseObject[@"error_code"] intValue] == 1) {
            //弹框支付密码错误
            dispatch_sync(dispatch_get_main_queue(), ^{
                [weakSelf.passwordAlert passwordError];
            });
        }
    } errorBlock:^(NSError * _Nullable error) {
        //
    }];
     */
    
}
//点击了取消按钮
- (void)passwordAlertViewDidClickCancleButton {
    
}
//点击了忘记密码按钮
- (void)passwordAlertViewDidClickForgetButton {
    
}

#pragma mark - UIAlert

#pragma mark - alert
- (void)alertPasswordError {
    
    [UIAlertController showOralAlertWithTitleString:nil andContentString:@"支付密码错误"];
}

- (void)alertReminderSetPassword {
    
    [UIAlertController showOralAlertWithTitleString:@"未设置支付密码" andContentString:@"请前往个人中心设置支付密码"];
}


- (void)handleOrderC:(NSString *)orderNo {
   
    _handLogic = [ZJHandleOrderCLogic new];
    _handLogic.delegate = self;
    
    [_handLogic handleOrderNoC:orderNo];
    
#pragma mark - 正在被修改
    /*
    NSDictionary *parame = @{
                             @"orderNoC":orderNo
                             };
    __weak typeof(self) weakSelf = self;
    
    [ZJServices syncHandleOrderC:parame successBlock:^(id  _Nullable responseObject) {
       
        dispatch_sync(dispatch_get_main_queue(), ^{
              [weakSelf.passwordAlert passwordViewDismiss];
        });
        
        NSString *code = [NSString stringWithFormat:@"%@",responseObject[@"error_code"]];
        NSString *error_message = [NSString stringWithFormat:@"%@",responseObject[@"error_message"]];
        if ([code integerValue] == 0) {
            [UIAlertController showOralAlertWithTitleString:nil andContentString:error_message];
        }else {
            
            dispatch_sync(dispatch_get_main_queue(), ^{
                MyOrderViewController *orderVc = [[MyOrderViewController alloc] init];
                orderVc.selectedIndex = 0;
                [weakSelf.navigationController pushViewController:orderVc animated:YES];
            });
            
            
            //            MyOrderViewController *orderVc = [[MyOrderViewController alloc] init];
            //            orderVc.selectedIndex = 0;
            //            [weakSelf.navigationController pushViewController:orderVc animated:YES];
            
        }
    } errorBlock:^(NSError * _Nullable error) {
        //
    }];
     */
}

#pragma mark ============ paymentPswLogicDelegate ============
- (void)verfyPaymentPswCompleted:(VerfyPaymentPswStatus)status {
    switch (status) {
        case 1://验证成功
#pragma mark ---- 验证成功过后，需要判断是处理订单还是调支付接口或者是其他
            [self handleOrderC:self.orderNoC];
            break;
        case 2://密码错误
        {
            [self.passwordAlert passwordError];
            break;
        }
        case 3://密码未设置
        {
            [self.passwordAlert passwordNotSetting];
            break;
        }
        default:
            break;
    }
    
}

#pragma mark ============ handleOrderNocDelegate ============
- (void)handleOrderCCompleted {
    
    //隐藏支付框
    [self.passwordAlert hide];
    
    MyOrderViewController *orderVc = [[MyOrderViewController alloc] init];
    orderVc.selectedIndex = 0;
    [self.navigationController pushViewController:orderVc animated:YES];
    
}

#pragma mark ============ creteOrederDelegate ============
- (void)createOrderCompleted:(CreateOrderPaymentMode)payMode orderNoC:(NSString *)orderNoc {
    
    //创造订单成功
    switch (payMode) {
        case 1://平台币支付
             self.orderNoC = orderNoc;
            //弹框
            [self.passwordAlert show];
            break;
        case 2://支付宝支付
        {
            NSString *appScheme = @"com.zhongjianAlipay";
            // NOTE: 调用支付结果开始支付
            [[AlipaySDK defaultService] payOrder:orderNoc fromScheme:appScheme callback:^(NSDictionary *resultDic) {
                NSLog(@"reslut = %@",resultDic);
            }];
            break;
        }
        case 3://混合支付
        {
        
    
            break;
    }
        default:
            break;
    }
}

@end
