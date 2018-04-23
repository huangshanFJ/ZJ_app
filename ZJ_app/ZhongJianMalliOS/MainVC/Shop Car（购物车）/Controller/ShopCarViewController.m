//
//  ShopCarViewController.m
//  ZhongJianMalliOS
//
//  Created by 段 on 2017/10/31.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "ShopCarViewController.h"
#import "ShopCarCell.h"
#import "ShopShowCell.h"
#import "AdressViewController.h"
#import "ShopHeadView.h"
#import "ShoppingCartSettlementViewController.h"
#import "OrderPriceModel.h"
#import "DetailOrderPriceModel.h"
#import "SettlementViewController.h"

@interface ShopCarViewController ()<UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout> {
    int shopNumber;
    NSString *token;
    NSMutableArray *dataArray;
    NSMutableArray *dataListArray;
    int lastNumber;
    NSMutableDictionary *priceDic;
    NSMutableArray *priceArr;
    UIView *noDataImageview;
    NSMutableArray *_array;
    OrderPriceModel *orderModel;
    
    DetailOrderPriceModel *detailModel;
    
}
@property (nonatomic,strong)UIScrollView *bgScrollView;
@property (nonatomic,strong)UITableView *shopTabel;
@property (nonatomic,strong)UICollectionView *shopCollectionView;
@property (nonatomic,strong)UILabel *totalPriceLabel;
// 添加的选中的model
@property (nonatomic,strong)OrderPriceModel * selectorderModel;
@property (nonatomic,strong)DetailOrderPriceModel *selectdetailModel;
// 存选中商品的数组
@property (nonatomic,strong)NSMutableArray * selectarray;
//@property (nonatomic,strong) UIView *bottomView;
@property (nonatomic,strong) UIButton *sendBtn;
//全选按钮
@property(nonatomic,strong)UIButton *allButton;
@end

static NSString *const shopCarCellID = @"ShopCarCell";
static NSString *const shopCellID = @"ShopShowCell";
@implementation ShopCarViewController

-(NSMutableArray*)selectarray{
    
    if (!_selectarray) {
        
        _selectarray = [NSMutableArray arrayWithCapacity:0];
    }
    return _selectarray;
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.hidden = YES;
    
    if (token != nil) {
        [self requestData];
    }else{
        [self initWithNilView];
    }
    
}


- (void)initWithNilView {
    if (noDataImageview) {
        [noDataImageview removeFromSuperview];
        noDataImageview = nil;
    }
    noDataImageview = [[UIView alloc] init];
    noDataImageview.frame = CGRectMake(0, 104, KWIDTH, KHEIGHT-104);
    noDataImageview.tag = 1111;

    [self.view addSubview:noDataImageview];
    
    
    UIImageView *noDataImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, KWIDTH, KHEIGHT-104)];
    noDataImage.image = [UIImage imageNamed:@"圆角矩形1"];
    //    noDataImage.hidden
    noDataImage.contentMode =UIViewContentModeCenter;

    [noDataImageview addSubview:noDataImage];

    self.bottomView.hidden = YES;
    [self.bottomView removeFromSuperview];
    self.bottomView = nil;
    [self.view bringSubviewToFront:noDataImageview];
    
   
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
    _array = [NSMutableArray array];
    self.allButton.selected = NO;
    
    //合计数字为0
    self.totalPriceLabel.text  = @"0.00";
    [self.view removeFromSuperview];
}
- (void)requestData {
    
    NSLog(@"刷新数据");
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer new];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSString *url = [NSString stringWithFormat:@"%@%@",HTTPUrl,@"/zjapp/v1/PersonalCenter/PersonalCenter/getShoppingCartInfo"];//,token];
    NSDictionary *dic = @{
                          @"token":token//@"d8123309-806f-4340-aa45-1619fed871d7"
                          };
    
    [manager GET:url parameters:dic progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //        NSLog(@"成功=%@",responseObject);
        if ([responseObject[@"error_code"] intValue] == 0) {
            NSMutableArray *_dataArray = [NSMutableArray arrayWithArray:responseObject[@"data"]];
            
            if (_dataArray.count == 0) {
                [self initWithNilView];
            }else {
                NSMutableArray *addArr = [NSMutableArray arrayWithCapacity:0];
                for (NSDictionary *diction in _dataArray) {
                    orderModel = [[OrderPriceModel alloc] initWithDic:diction];
                    //                    model.productList = diction[@"productList"];
                    //                    model.producerName = [NSString stringWithFormat:@"%@",diction[@"producerName"]];
                    [addArr addObject:orderModel];
                }
                dataArray = addArr;
                self.selectarray = dataArray;
                
                UIView* subView = [self.view viewWithTag:1111];
                [subView removeFromSuperview];
                if (!self.bottomView) {
                    
                    [self creatBottom];

                }
            }
        }
        
        [hud hideAnimated:YES];
        [_shopTabel reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"失败=%@",error);
        [hud hideAnimated:YES];
    }];
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    shopNumber = 1;
    _array = [NSMutableArray array];
    priceDic = [NSMutableDictionary dictionary];
    dataArray = [NSMutableArray arrayWithCapacity:0];
    priceArr = [NSMutableArray arrayWithCapacity:0];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    token = [userDefaults objectForKey:@"userToken"];
    [self creatNav];
    
    noDataImageview = [[UIView alloc] init];
    [self initWithNilView];
    //    [self creatScrollView];
    //
    [self creatTableView];
    
    //    [self creatCollection];
    
    
}
- (void)creatNav {
    //add by zy  添加返回按钮
//    if (self.isFromGoodsPage) {
    
//        UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        [backButton addTarget:self action:@selector(backButtonClick) forControlEvents:UIControlEventTouchUpInside];
//        [backButton setBackgroundImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
//        [self.view addSubview:backButton];
//        [backButton mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.mas_offset(10);
//            make.width.mas_offset(20);
//            make.height.mas_offset(20);
//            make.top.mas_offset(30);
//        }];
//    }
    
    

    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, KWIDTH, 44)];
    title.text = @"购物车";
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
    
    
}
- (void)creatBottom {
    //    _bgScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, KWIDTH, KHEIGHT-64-44-44)];
    //    _bgScrollView.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];
    //    // 增加额外的滚动区域（逆时针，上、左、下、右）
    //    // top  left  bottom  right
    ////    _bgScrollView.contentInset = UIEdgeInsetsMake(20, 20, 20, 20);
    //    [_bgScrollView setContentSize:CGSizeMake(KWIDTH, KHEIGHT-64-44)];
    //    [self.view addSubview:_bgScrollView];
    
    
    UIView *bottom = [[UIView alloc] init];
    bottom.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bottom];
    
    [self creatChildBottom:bottom];
//    self.bottomView = bottom;
//
//    if (self.isFromGoodsPage) {
//
//        [bottom mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.mas_offset(0);
//            make.width.mas_offset(KWIDTH);
//            make.height.mas_offset(44);
//            make.bottom.mas_offset(0);
//        }];
//
//    }else{
//
//        [bottom mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.mas_offset(0);
//            make.width.mas_offset(KWIDTH);
//            make.height.mas_offset(44);
//            make.bottom.mas_offset(-44);
//        }];
//
//    }
    UILabel *line = [UILabel new];
    line.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];
    [bottom addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(0);
        make.top.mas_offset(0);
        make.height.mas_offset(1);
        make.right.mas_offset(0);
    }];
    UIButton *allButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.allButton = allButton;
    allButton.layer.borderColor = [UIColor colorWithHexString:@"d4d4d4"].CGColor;
    
    [allButton setImage:[UIImage imageNamed:@"choose"] forState:UIControlStateNormal];
    [allButton setImage:[UIImage imageNamed:@"fullin_blue"] forState:UIControlStateSelected];
    [allButton addTarget:self action:@selector(selectedAllClick:) forControlEvents:UIControlEventTouchUpInside];
    [bottom addSubview:allButton];
    [allButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(10);
        make.width.mas_offset(21);
        make.height.mas_offset(21);
        make.centerY.equalTo(bottom.mas_centerY).offset(0);
    }];
        UILabel *total = [UILabel new];
        total.text = @"合计：";
        total.textColor = redTextColor;
        total.font = [UIFont systemFontOfSize:14];
        [bottom addSubview:total];
        [total mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(allButton.mas_right).offset(10);
            make.height.mas_offset(44);
            make.top.mas_offset(0);
        }];
    
        _totalPriceLabel = [[UILabel alloc] init];
        _totalPriceLabel.textColor = redTextColor;
        _totalPriceLabel.text = @"0";
        _totalPriceLabel.font = [UIFont fontWithName:@"Arial Rounded MT Bold" size:14];
        [bottom addSubview:_totalPriceLabel];
        [_totalPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(total.mas_right).offset(5);
            make.height.mas_offset(44);
            make.top.mas_offset(0);
        }];
    UIButton *sendButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    [sendButton setTitle:@"提交订单" forState:UIControlStateNormal];
    [sendButton setTitle:@"结算" forState:UIControlStateNormal];

    sendButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [sendButton addTarget:self action:@selector(sendButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [sendButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    sendButton.backgroundColor = zjTextColor;
    self.sendBtn = sendButton;
    [bottom addSubview:sendButton];
    [sendButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(0);
        make.width.mas_offset(120);
        make.top.mas_offset(0);
        make.height.mas_offset(44);
    }];
    
  
}

- (void)creatChildBottom:(UIView *)bottom {
    
    self.bottomView = bottom;
    
//    if (self.isFromGoodsPage) {
//
//        [bottom mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.mas_offset(0);
//            make.width.mas_offset(KWIDTH);
//            make.height.mas_offset(44);
//            make.bottom.mas_offset(0);
//        }];
//
//    }else{
    
        [bottom mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(0);
            make.width.mas_offset(KWIDTH);
            make.height.mas_offset(44);
            make.bottom.mas_offset(-44);
        }];
        
//    }
}

#pragma mark ---点击全选
-(void)selectedAllClick:(UIButton *)btn{
    btn.selected = !btn.selected;
    [self cellForTableView:_shopTabel withButton:btn];
}
-(void)cellForTableView:(UITableView *)tableView withButton:(UIButton *)btn{
    NSInteger sections = tableView.numberOfSections;
    
    //合计按钮逻辑重新梳理.by FJ
    CGFloat total = 0.0;
    [_array removeAllObjects];
    
    for (NSInteger section = 0; section < sections; section++) {
        NSInteger rows = [tableView numberOfRowsInSection:section];
        for (NSInteger row = 0; row < rows; row++) {
            NSIndexPath *indexpath = [NSIndexPath indexPathForRow:row inSection:section];
            ShopCarCell *cell = [tableView cellForRowAtIndexPath:indexpath];
            //__weak typeof(cell) weakCell = cell;
            NSString *str = [NSString stringWithFormat:@"%ld_%ld",indexpath.section,indexpath.row];

            self.selectorderModel = self.selectarray[indexpath.section];
            self.selectdetailModel = self.selectorderModel.productList[indexpath.row];
            
            if (btn.selected) {
                
               [cell.selectedButton setBackgroundImage:[UIImage imageNamed:@"fullin_blue"] forState:UIControlStateNormal];
                [_array addObject:str];
                self.selectdetailModel.selected = YES;
//                CGFloat total = [_totalPriceLabel.text floatValue];
                
                NSString *priceStr = [cell.priceLabel.text substringFromIndex:2];
                total += [cell.numberLabel.text integerValue]*[priceStr floatValue];
                _totalPriceLabel.text = [NSString stringWithFormat:@"%.2f",total];
            }else{
                self.selectdetailModel.selected = NO;
                [_array removeObject:str];
               [cell.selectedButton setBackgroundImage:[UIImage imageNamed:@"choose"] forState:UIControlStateNormal];
                _totalPriceLabel.text = [NSString stringWithFormat:@"0.00"];
            }

        }
    }
    
}
- (void)creatTableView {
    _shopTabel = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, KWIDTH, KHEIGHT-64-44) style:UITableViewStyleGrouped];
    _shopTabel.delegate = self;
    _shopTabel.dataSource = self;
    _shopTabel.separatorStyle = UITableViewCellSeparatorStyleNone;
    //    _shopTabel.scrollEnabled = NO;
    
    [self.view addSubview:_shopTabel];
    //    [_bgScrollView addSubview:_shopTabel];
    
}
- (void)creatCollection {
    //    UIView *bottom = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KWIDTH, KHEIGHT-107*2-44)];
    UICollectionViewLayout *layout = [UICollectionViewFlowLayout new];
    _shopCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 64, KWIDTH, KHEIGHT-44-44-64) collectionViewLayout:layout];
    _shopCollectionView.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];
    _shopCollectionView.showsVerticalScrollIndicator = NO;
    //    _shopCollectionView.scrollEnabled = NO;
    _shopCollectionView.delegate = self;
    _shopCollectionView.dataSource = self;
    //注册
    [_shopCollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headID"];
    [_shopCollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headTableID"];
    [_shopCollectionView registerClass:[ShopShowCell class] forCellWithReuseIdentifier:shopCellID];
    //    [bottom addSubview:_shopCollectionView];
    [self.view addSubview:_shopCollectionView];
    //    _shopTabel.tableFooterView = bottom;
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //    if (dataArray > 0) {
    //    NSLog(@"===%lu",[dataArray[section][@"productList"]count]);
    OrderPriceModel *model = dataArray[section];
    return model.productList.count;//[dataArray[section][@"productList"]count];
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return dataArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 107;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40;
}
- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    ShopHeadView *headView = [[ShopHeadView alloc] initWithFrame:CGRectMake(0, 0, KWIDTH, 40)];
    //    headView.shopDetailNameLabel.
    if (dataArray.count > 0) {
        //add by zy
        OrderPriceModel *model = dataArray[section];
        
//        NSString *showtext = [NSString stringWithFormat:@"%@",orderModel.producerName];
        NSString *showtext = [NSString stringWithFormat:@"%@",model.producerName];

        headView.shopDetailNameLabel.text = showtext;
        if ([showtext isEqualToString:@""]) {
            headView.shopDetailNameLabel.text = @"匿名商户";
        }
    }
    
    headView.backgroundColor = [UIColor whiteColor];
    
    return headView;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ShopCarCell *cell = [[ShopCarCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:shopCarCellID];
    if (!cell) {
        cell = [[ShopCarCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:shopCarCellID];
    }
    orderModel = dataArray[indexPath.section];
    detailModel = orderModel.productList[indexPath.row];
    
    self.selectorderModel = orderModel;
    self.selectdetailModel = self.selectorderModel.productList[indexPath.row];
    
    if (dataArray.count > 0) {
        NSString *imageUrl;
        if (detailModel.productphotos.count > 0) {
            //            imageUrl = [NSString stringWithFormat:@"%@%@",HTTPUrl,dataArray[indexPath.section][@"productList"][indexPath.row][@"product"][@"productphotos"][0][@"photo"]];
            imageUrl = [NSString stringWithFormat:@"%@%@",HTTPUrl,detailModel.photo];
        }else {
            imageUrl = @"";
        }
        [cell.shopImageView sd_setImageWithURL:[NSURL URLWithString:imageUrl]]; //.image = [UIImage imageNamed:@"banner"];
        NSString *title = detailModel.productname;
        cell.shopNameLabel.text = title;
        cell.shopNormsLabel.text = [NSString stringWithFormat:@"规格：%@",detailModel.specname];// @"规格：的话胜读";
        NSString *price = detailModel.price;
        NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"￥ %@",price]];
        [AttributedStr addAttribute:NSFontAttributeName
                              value:[UIFont systemFontOfSize:11.0]
                              range:NSMakeRange(0, 2)];
        [AttributedStr addAttribute:NSFontAttributeName
                              value:[UIFont fontWithName:@"Arial Rounded MT Bold" size:17]
                              range:NSMakeRange(2, price.length)];
        cell.priceLabel.attributedText = AttributedStr;
        
        NSString *number = detailModel.productnum;
        cell.numberLabel.text = number;
        NSString *CartId = [NSString stringWithFormat:@"%@",detailModel.orderID];//dataArray[indexPath.section][@"productList"][indexPath.row][@"id"]];
        
        cell.addShopButtonClickBlock = ^{
            //            shopNumber +=1;
            int addnumber = [number intValue];
            addnumber +=1;
            //            cell.numberLabel.text = [NSString stringWithFormat:@"%d",addnumber];
            //            lastNumber = addnumber;
            
            [self addRequestNumber:addnumber shoppingCartId:CartId];
            CGFloat total = [_totalPriceLabel.text floatValue];
            
            total += [price floatValue];
            _totalPriceLabel.text = [NSString stringWithFormat:@"%.2f",total];
        };
        __weak ShopCarCell *weakCell = cell;
        __weak typeof(self) weakSelf = self;
        cell.deleteShopButtonClickBlock = ^{
            int addnumber = [number intValue];
            if (addnumber > 1) {
                addnumber -=1;
                [weakSelf addRequestNumber:addnumber shoppingCartId:CartId];
                CGFloat total = [_totalPriceLabel.text floatValue];
                
                total -= [price floatValue];
                _totalPriceLabel.text = [NSString stringWithFormat:@"%.2f",total];
                //                cell.numberLabel.text = [NSString stringWithFormat:@"%d",addnumber];
            }else {
                weakCell.numberLabel.text = @"1";
                
            }
        };
        NSString *str = [NSString stringWithFormat:@"%ld_%ld",indexPath.section,indexPath.row];
        if ([self shezhiArrayWithStr:str]) {
            self.selectdetailModel.selected = YES;
            [cell.selectedButton setBackgroundImage:[UIImage imageNamed:@"fullin_blue"] forState:UIControlStateNormal];
        }else {
            self.selectdetailModel.selected = NO;
            [cell.selectedButton setBackgroundImage:[UIImage imageNamed:@"choose"] forState:UIControlStateNormal];
        }
        [self.selectarray replaceObjectAtIndex:indexPath.section withObject:self.selectorderModel];
        cell.selectedButtonButtonBlock = ^{
            NSString *str = [NSString stringWithFormat:@"%ld_%ld",indexPath.section,indexPath.row];
            
            /**
             * 添加操作的   model
             */
            self.selectorderModel = self.selectarray[indexPath.section];
            self.selectdetailModel = self.selectorderModel.productList[indexPath.row];
            CGFloat total = [_totalPriceLabel.text floatValue];
            if ([self shezhiArrayWithStr:str]) {//已经选中了
                 self.selectdetailModel.selected = NO;
                [_array removeObject:str];
                total -= [number integerValue]*[price floatValue];
                _totalPriceLabel.text = [NSString stringWithFormat:@"%.2f",total];
                NSLog(@"未选中 -- %@",str);
            }else {//未选中
                [_array addObject:str];
                self.selectdetailModel.selected = YES;
                CGFloat total = [_totalPriceLabel.text floatValue];
                
                total += [number integerValue]*[price floatValue];
                _totalPriceLabel.text = [NSString stringWithFormat:@"%.2f",total];
                NSLog(@"选中 -- %@",str);
            }
#pragma mark-------3.14

            NSInteger count = 0;  //判断是否是全选/取消的最后一个点击
            NSLog(@"dataarray=%@",dataArray);
            if (_array.count==0) {
                NSLog(@"kkkkkk全取消");
                self.allButton.selected = NO;
            }else{
                for (OrderPriceModel *model in dataArray) {
                    count += model.productList.count;
                }
                if (count == _array.count) {
                    self.allButton.selected = YES;
                }else{
                    self.allButton.selected = NO;
                }
                
            }
            
            [self.selectarray replaceObjectAtIndex:indexPath.section withObject:self.selectorderModel];
            
            [tableView reloadData];
            
            
            //            detailModel.selected = !detailModel.selected;
            //            if (detailModel.selected == YES) {
            //                 [weakCell.selectedButton setBackgroundImage:[UIImage imageNamed:@"fullin_blue"] forState:UIControlStateSelected];
            //            }else {
            //                [weakCell.selectedButton setBackgroundImage:[UIImage imageNamed:@"choose"] forState:UIControlStateNormal];
            //            }
            ////            NSLog(@"选择的是=%@",detailModel.selected?@"yes":@"no");
        };
    };
    
    //    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}
- (void)countTotalNumber {
    
    
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    //    NSLog(@"%@",_array);
}
-(BOOL)shezhiArrayWithStr:(NSString*)str {
    return [_array containsObject:str];
}
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSLog(@"----%ld-----%ld",(long)indexPath.section,(long)indexPath.row);
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer new];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    OrderPriceModel *model =(OrderPriceModel*)(dataArray[indexPath.section]);
    DetailOrderPriceModel *detailModle =  model.productList[indexPath.row];
//    NSString *shoppingCartId = [NSString stringWithFormat:@"%@",dataArray[indexPath.section][@"productList"][indexPath.row][@"id"]];
     NSString *shoppingCartId = [NSString stringWithFormat:@"%@",detailModle.orderID];
    
    NSString *url = [NSString stringWithFormat:@"%@%@",HTTPUrl,@"/zjapp/v1/PersonalCenter/delShoppingCartInfo"];//,token];
    
    NSDictionary *dic = @{
                          @"token":token,//@"d8123309-806f-4340-aa45-1619fed871d7",
                          @"shoppingCartId":shoppingCartId
                          };
    [manager POST:url parameters:dic progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",responseObject);
        if ([responseObject[@"error_code"] intValue] == 0) {
            //add by zy
            [model.productList removeObject:detailModle];
            if (model.productList.count == 0) {
                [dataArray removeObject:model];
            }
            // 刷新
//            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
//                             withRowAnimation:UITableViewRowAnimationFade];
            [tableView reloadData];
            [self requestData];
            
        }
        [hud hideAnimated:YES];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
        [hud hideAnimated:YES];
    }];
    
    
}
- (void)addRequestNumber:(int)number shoppingCartId:(NSString *)shoppingCartId {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer new];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    //    NSString *shoppingCartId = [NSString stringWithFormat:@"%@",dataArray];
    NSString *url = [NSString stringWithFormat:@"%@%@%@",HTTPUrl,@"/zjapp/v1/PersonalCenter/updateShoppingCartInfo/",shoppingCartId];//,token];
    NSString *productNum = [NSString stringWithFormat:@"%d",number];
    NSDictionary *dic = @{
                          @"token":token,//@"d8123309-806f-4340-aa45-1619fed871d7",
                          @"productNum":productNum
                          };
    [manager POST:url parameters:dic progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",responseObject);
        if ([responseObject[@"error_code"] intValue] == 0) {
            //            dataArray = [NSMutableArray arrayWithArray:responseObject[@"data"]];
            [self requestData];
        }
        [hud hideAnimated:YES];
        [_shopTabel reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
        [hud hideAnimated:YES];
    }];
    
    
}

#pragma mark - <UICollectionViewDataSource>
//一共有多少个组
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 2;
}
//每一组有多少个cell
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return section == 1 ? 4 : 0;
}
//动态设置每列的间距大小
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 7;
}
//动态设置每行的间距大小
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout             minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 8;
}
//头部试图的大小
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return section == 1 ? CGSizeMake(KWIDTH, 45) : CGSizeMake(KWIDTH, 107*2);
}
//动态设置每个Item的尺寸大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    return CGSizeMake(KWIDTH/2-4, 260);
    
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    UICollectionReusableView *reusableview = nil;
    if (kind == UICollectionElementKindSectionHeader) {
        if (indexPath.section == 0) {
            reusableview = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headTableID" forIndexPath:indexPath];
            _shopTabel = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KWIDTH, 107*2) style:UITableViewStylePlain];
            _shopTabel.delegate = self;
            _shopTabel.dataSource = self;
            _shopTabel.separatorStyle = UITableViewCellSeparatorStyleNone;
            _shopTabel.scrollEnabled = NO;
            [reusableview addSubview:_shopTabel];
        }else {
            reusableview = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headID" forIndexPath:indexPath];
            UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KWIDTH, 45)];
            headView.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];
            UILabel *lickLabel = [[UILabel alloc] init];
            lickLabel.text = @"猜你喜欢";
            lickLabel.font = [UIFont systemFontOfSize:13];
            lickLabel.textAlignment = NSTextAlignmentCenter;
            [headView addSubview:lickLabel];
            [lickLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.mas_offset(0);
                make.height.mas_offset(45);
                make.top.mas_offset(0);
            }];
            UIImageView *leftImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"lick"]];
            [headView addSubview:leftImageView];
            [leftImageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(lickLabel.mas_left).offset(-8);
                make.centerY.mas_offset(0);
                make.width.mas_offset(11);
                make.height.mas_offset(11);
            }];
            UIImageView *rightImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"lick"]];
            [headView addSubview:rightImageView];
            [rightImageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(lickLabel.mas_right).offset(8);
                make.centerY.mas_offset(0);
                make.width.mas_offset(11);
                make.height.mas_offset(11);
            }];
            
            [reusableview addSubview:headView];
        }
        
    }
    return reusableview;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ShopShowCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:shopCellID forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    NSArray *imageArr = @[@"picture1",@"picture2",@"picture3",@"picture3"];
    NSArray *kindNameArr = @[@"天然素",@"木耳",@"程铮一号shufjuehufewufubgjgnjerbgty ",@"大米"];
    NSArray *priceNameArr = @[@"￥100",@"￥100",@"￥100",@"￥100"];
    NSArray *mintArr = @[@"100",@"100",@"100",@"50"];
    NSArray *stateArr = @[@"大卖",@"热销",@"热卖",@"促销"];
    cell.shopImage.image = [UIImage imageNamed:imageArr[indexPath.row]];
    cell.nameLabel.text = kindNameArr[indexPath.row];
    cell.kindLabel.text = stateArr[indexPath.row];
    cell.kindLabel.backgroundColor = [UIColor redColor];
    cell.priceLabel.text = priceNameArr[indexPath.row];
    cell.minitLabel.text = mintArr[indexPath.row];
    return cell;
    
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"第%ld行",indexPath.row);
    [self.navigationController pushViewController:[AdressViewController new] animated:YES];
    
    
}

-(NSDictionary*)zhengliData {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    for (NSInteger i = 0; i<_array.count; i++) {
        NSArray *arr1 = [_array[i] componentsSeparatedByString:@"_"];
        NSMutableArray *arr2 = [dic[arr1[0]] mutableCopy];
        if (arr2) {
            [arr2 addObject:arr1[1]];
            [dic setObject:arr2 forKey:arr1[0]];
        }else {
            NSArray *arr = [NSArray arrayWithObjects:arr1[1], nil];
            [dic setObject:arr forKey:arr1[0]];
        }
    }
    NSLog(@"---%@",dic);
    return dic;
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    //    NSIndexPath *path =  [_shopTabel indexPathForRowAtPoint:CGPointMake(scrollView.contentOffset.x, scrollView.contentOffset.y)];
    //
    //    NSLog(@"这是第%li行",(long)path.row);
    //
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark -ACTION
- (void)backButtonClick{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}
//结算
- (void)sendButtonClick:(UIButton *)sender {
    
    NSLog(@"%@",_array);
    //    NSLog(@"%@",dataArray);
    if (_array.count == 0) {
        return;
    }
//    ShoppingCartSettlementViewController *shopVC = [[ShoppingCartSettlementViewController alloc] init];
    SettlementViewController *vc = [[SettlementViewController alloc] init];
    //这个是需要结算的商品
//    NSMutableArray * addarray = [NSMutableArray arrayWithCapacity:0];
//
//    NSArray *listArray = [_array copy];
//    for (NSString *str in listArray) {
//        NSInteger section = [[[str componentsSeparatedByString:@"_"] firstObject] integerValue];
//        NSInteger row = [[[str componentsSeparatedByString:@"_"] lastObject] integerValue];
//
//        orderModel = dataArray[section];
//
//        detailModel = orderModel.productList[row];
//
//        // 将 datailModel 放入可不数组中
//        //[multableArr]
//        [addarray addObject:detailModel];
//
//    }
//    shopVC.dataArray = addarray;

    // add by zt
        NSArray *listArray = [_array copy];
    
        NSMutableDictionary *selectDic = [NSMutableDictionary dictionary];
        for (NSString *str in listArray) {
            NSInteger section = [[[str componentsSeparatedByString:@"_"] firstObject] integerValue];
            NSInteger row = [[[str componentsSeparatedByString:@"_"] lastObject] integerValue];
           NSMutableArray * sectionArray = [selectDic objectForKey:@(section)];
            if (!sectionArray) {
                sectionArray = [NSMutableArray array];
                [selectDic setObject:sectionArray forKey:@(section)];

            }
            [sectionArray addObject:@(row)];
    
        }
    NSMutableArray *selecArray = [NSMutableArray array];
    for (NSNumber *key in selectDic.allKeys) {
      OrderPriceModel *orderModel = dataArray[[key integerValue]];
        NSArray *selectSectionValues =(NSArray *)[selectDic objectForKey:key];
        NSMutableArray *dataList = [NSMutableArray array];
        for (NSNumber *value in selectSectionValues) {

            [dataList addObject:orderModel.productList[[value integerValue]]];
            
        }
        orderModel.productList =dataList;
        [selecArray addObject:orderModel];
    }
   
    
    vc.dataArray = selecArray;
    vc.isFromShop = YES;
//end
    [self.navigationController pushViewController:vc animated:YES];
    
}


@end

