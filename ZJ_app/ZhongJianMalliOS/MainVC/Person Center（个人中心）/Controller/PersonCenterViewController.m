//
//  PersonCenterViewController.m
//  ZhongJianMalliOS
//
//  Created by 段 on 2017/10/31.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "PersonCenterViewController.h"
#import "LoginViewController.h"
//head
#import "HeadImageCollection.h"
#import "PersonMoneyReusableView.h"
//cell
#import "PersonMoneyCell.h"
#import "MyKindUseCell.h"
//foot
#import "FootImageCollectionView.h"

#import "ChangeInformationViewController.h"
#import "MyOrderViewController.h"
#import "MyPurseViewController.h"
#import "FansNumberViewController.h"
#import "MyCardViewController.h"
#import "RecordProfitViewController.h"
#import "WebTestViewController.h"
#import "SendGiftViewController.h"
#import "ShowRealStateViewController.h"
#import "ApplicationFormViewController.h"
#import "MyCourseViewController.h"

@interface PersonCenterViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout> {
    NSString *token;
    NSDictionary *personDataDic;
    NSArray *orderDataArray;
    NSArray *myAlwaysDataArray;
    NSArray *kindNameArr;
    NSArray *kindUseNameArr;
    NSArray *iconArray;
    NSArray *nameArray;
}
@property (strong , nonatomic)UICollectionView *personCollectionView;

@end
//head
static NSString *const headImageViewID = @"HeadImageCollection";
static NSString *const HeadMyReusableID = @"PersonMoneyReusableView";
//cell
static NSString *const moneyKindCellID = @"PersonMoneyCell";
static NSString *const myKindUseCellID = @"MyKindUseCell";
//foot
static NSString *const footViewID = @"FootImageCollectionView";
#import "FootImageCollectionView.h"
@implementation PersonCenterViewController
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    self.navigationController.navigationBar.barStyle = UIStatusBarStyleLightContent;
    if (token != nil && token != [NSNull class]) {
        [self requestHttp];
    }else {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"未登录" message:@"请先登录" preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self.navigationController pushViewController:[LoginViewController new] animated:YES];
        }]];
        [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }]];
        [self presentViewController:alert animated:YES completion:nil];
    }
    
}
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
//    self.navigationController.navigationBar.hidden = NO;
    
}
- (void)requestHttp {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer new];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSString *url = [NSString stringWithFormat:@"%@%@%@",HTTPUrl,@"/zjapp/v1/PersonalCenter/initPersonalCenterData/",token];//,token];
    [manager GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"成功=%@",responseObject);
        if ([responseObject[@"error_code"] intValue] == 0) {
            personDataDic = responseObject[@"data"];
            kindUseNameArr = @[@"我的钱包",@"我的订单",@"我的常用"];
            NSString *canProxyApply = [NSString stringWithFormat:@"%@",personDataDic[@"ProxyApply"][@"canProxyApply"]];
            if ([canProxyApply isEqualToString:@"0"]) {
                iconArray = @[@"fans_red",@"personal_mycourse",@"customer service_blue",@"twosendone",@"collection_red",@"waterpurifier",@"qrcode"];//,@""
                nameArray = @[@"我的粉丝",@"我的课程",@"我的客服",@"二赠一",@"我的名片",@"净水机",@"实名认证"];//,@"我的足迹"
            }else {
                iconArray = @[@"fans_red",@"personal_mycourse",@"customer service_blue",@"twosendone",@"collection_red",@"waterpurifier",@"qrcode",@"certification"];//,@""
                nameArray = @[@"我的粉丝",@"我的课程",@"我的客服",@"二赠一",@"我的名片",@"净水机",@"实名认证",@"代理申请"];//,@"我的足迹"
            }
            
            
            [_personCollectionView reloadData];
        }else if ([responseObject[@"error_code"] intValue] == 3) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"该账号已在其他手机登陆" message:@"" preferredStyle:UIAlertControllerStyleAlert];
            [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                [self.navigationController pushViewController:[LoginViewController new] animated:YES];
            }]];
            [self presentViewController:alert animated:YES completion:nil];
        }
        [hud hideAnimated:YES];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"失败=%@",error);
        [hud hideAnimated:YES];
    }];
    
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.title = @"个人中心";
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.barStyle = UIStatusBarStyleLightContent;
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    token = [userDefaults objectForKey:@"userToken"];
    NSLog(@"token=%@",token);
    personDataDic = [NSDictionary dictionary];
    
    orderDataArray = [NSArray array];
    myAlwaysDataArray = [NSArray array];
    kindNameArr = [NSArray array];
    kindUseNameArr = [NSArray array];
   
//    iconArray = @[@"fans_red",@"customer service_blue",@"twosendone",@"collection_red",@"waterpurifier",@"qrcode",@"customer service_blue"];//,@""
//    nameArray = @[@"我的粉丝",@"我的客服",@"二赠一",@"我的名片",@"净水机",@"实名认证",@"我的课程"];//,@"我的足迹"
    
    [self setUpUI];
    
}

- (void)setUpUI {
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    _personCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, KWIDTH, KHEIGHT-29) collectionViewLayout:layout];
    _personCollectionView.backgroundColor = [UIColor whiteColor];
    _personCollectionView.delegate = self;
    _personCollectionView.dataSource = self;
    _personCollectionView.alwaysBounceVertical = YES;
    _personCollectionView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_personCollectionView];
   
    //头部
    [_personCollectionView registerClass:[HeadImageCollection class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headImageViewID];
    [_personCollectionView registerClass:[PersonMoneyReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:HeadMyReusableID];
    
    
    //foot
    [_personCollectionView registerClass:[FootImageCollectionView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:footViewID];
    
    //cell
    [_personCollectionView registerClass:[PersonMoneyCell class] forCellWithReuseIdentifier:moneyKindCellID];
    [_personCollectionView registerClass:[MyKindUseCell class] forCellWithReuseIdentifier:myKindUseCellID];
}


#pragma mark - <UICollectionViewDataSource>
//一共有多少个组
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 4;
}
//每一组有多少个cell
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (section == 0) {
        return 0;
    }else if (section == 1) {
        return 3;
    }else if (section == 2) {
        return 5;
    }else {
        return iconArray.count;
    }
  
}
//动态设置每列的间距大小
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
    //    return section == 0 ? 0 : 7;
}
//动态设置每行的间距大小

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout             minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return section == 1 ? 0.5 : 0;
}

//头部试图的大小
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return section == 0 ? CGSizeMake(KWIDTH, 193) : CGSizeMake(KWIDTH, 40);
    
}
//脚部试图的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    return   CGSizeMake(KWIDTH, 7);
    ;
}
//动态设置每个Item的尺寸大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return indexPath.section == 1 ? CGSizeMake(KWIDTH/3, 94) : CGSizeMake(KWIDTH/5, 75);

}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    UICollectionReusableView *reusableView = nil;
    if (kind == UICollectionElementKindSectionHeader) {
        if (indexPath.section == 0) {
            HeadImageCollection *headImageView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headImageViewID forIndexPath:indexPath];
            if (token != nil) {
                if (personDataDic != nil) {
                    NSString *urlStr = [NSString stringWithFormat:@"%@%@",HTTPUrl,personDataDic[@"personDataMap"][@"HeadPhoto"]];
                    
                    [headImageView.headImage sd_setImageWithURL:[NSURL URLWithString:urlStr]];
                    headImageView.nameLabel.text = [NSString stringWithFormat:@"%@",personDataDic[@"personDataMap"][@"NickName"]];
                    headImageView.nameIDLabel.text = [NSString stringWithFormat:@"ID:%@",personDataDic[@"personDataMap"][@"SysID"]];
                    
                    NSString *lev = [NSString stringWithFormat:@"%@",personDataDic[@"personDataMap"][@"Lev"]];
                    NSString *isGcNum = [NSString stringWithFormat:@"%@",personDataDic[@"personDataMap"][@"isGCmember"]];
                    NSString *IsSubProxy = [NSString stringWithFormat:@"%@",personDataDic[@"personDataMap"][@"IsSubProxy"]];
                    if ([lev intValue] == 0) {
                        if ([isGcNum intValue]) {
                            headImageView.membrelevelLabel.text = @"99会员";
                        } else {
                            headImageView.membrelevelLabel.text = @"免费会员";
                        }
                    }else if ([lev intValue] == 1) {
                       
                        headImageView.membrelevelLabel.text = @"VIP";
                        
                    }else if ([lev intValue] == 2) {
                         if ([IsSubProxy intValue] == 0) {
                             headImageView.membrelevelLabel.text = @"合伙人";
                         }else {
                              headImageView.membrelevelLabel.text = @"准代理";
                         }
                    }else {
                        headImageView.membrelevelLabel.text = @"代理"; 
                    }
                    
                    
                }
            }
            else {
                headImageView.nameLabel.text = @"";
                headImageView.nameIDLabel.text = @"";
            }
           
            __weak typeof (&*self) weakSelf = self;
            headImageView.headButtonClickBlock = ^{
                //头像
                NSLog(@"头像");
                [weakSelf pushNext];
                
//                [weakSelf creatImage];
            };
            headImageView.newsButtonClickBlock = ^{
              //设置
                [weakSelf pushNext];
                NSLog(@"设置");
//                [weakSelf creatImage];
            };
            reusableView = headImageView;

            
        }else{
            PersonMoneyReusableView *kindNameView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:HeadMyReusableID forIndexPath:indexPath];

            NSArray *kindNameArr = @[@"我的钱包",@"我的订单",@"我的常用"];
            kindNameView.kindNameLabel.text = kindNameArr[indexPath.section-1];

            reusableView = kindNameView;
        }
    }else {
        
            FootImageCollectionView *footview = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:footViewID forIndexPath:indexPath];

        reusableView = footview;

        
    
    
    }
    
    return reusableView;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *collectionCell = nil;
    if (indexPath.section == 1) {
        PersonMoneyCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:moneyKindCellID forIndexPath:indexPath];
//        NSArray *moneyArr = @[@"100",@"2.00",@"3300"];
        NSArray *kindArr = @[@"现金币",@"购物币",@"消费币"];
        if (token != nil) {
            if (personDataDic != nil) {
                
                if (indexPath.row == 0) {
                    cell.moneyLabel.text = [NSString stringWithFormat:@"%.1f",[personDataDic[@"personDataMap"][@"RemainElecNum"] doubleValue]];
                }else if (indexPath.row == 1) {
                    
                    cell.moneyLabel.text = [NSString stringWithFormat:@"%.1f",[personDataDic[@"personDataMap"][@"RemainPoints"] doubleValue]];
                    
                }else {
                    cell.moneyLabel.text = [NSString stringWithFormat:@"%.1f",[personDataDic[@"personDataMap"][@"RemainVIPAmount"] doubleValue]];
                }
                
            }
        }else {
            cell.moneyLabel.text = @"0";
            cell.moneyLabel.text = @"0";
            cell.moneyLabel.text = @"0";
        }
        
//        cell.moneyLabel.text = moneyArr[indexPath.row];
        cell.kindMoneyLabel.text = kindArr[indexPath.row];
        collectionCell = cell;
    }else {
        if (indexPath.section == 2) {
            MyKindUseCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:myKindUseCellID forIndexPath:indexPath];
            
            NSArray *iconArr = @[@"myorder",@"pending payment_orang",@"pending shipment_blue",@"goods to be received_blue",@"pendingevaluation"];//,@"commodity_blue",@"article_green",@"",@"evaluate_yellow"];
            NSArray *nameArr = @[@"我的订单",@"待付款",@"待发货",@"待收货",@"待评价"];//,@"商品",@"文章",@"课程",@"评价"];
            cell.kindImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",iconArr[indexPath.row]]];
            NSArray *numberArr = [NSArray array];
            if (personDataDic != nil) {
                numberArr = [NSArray arrayWithArray:personDataDic[@"orderStatusList"]];
                
           
            if (numberArr.count > 0) {
                
                if (indexPath.row == 1) {
                    cell.numberLabel.text = [NSString stringWithFormat:@"%@",numberArr[0]];
                    if ([cell.numberLabel.text integerValue] == 0) {
                        cell.numberLabel.hidden = YES;
                    }else{
                        cell.numberLabel.hidden =  NO  ;
                    }
//                    [cell.numberLabel.text integerValue] == 0 ? cell.numberLabel.hidden = YES : NO;
                }else if (indexPath.row == 2) {
                    cell.numberLabel.text = [NSString stringWithFormat:@"%@",numberArr[1]];
                    if ([cell.numberLabel.text integerValue] == 0) {
                        cell.numberLabel.hidden = YES;
                    }else{
                         cell.numberLabel.hidden =  NO  ;
                    }
                    
//                    [cell.numberLabel.text integerValue] == 0 ? :
                    
                }else if (indexPath.row == 3) {
                    cell.numberLabel.text = [NSString stringWithFormat:@"%@",numberArr[2]];
                    if ([cell.numberLabel.text integerValue] == 0) {
                        cell.numberLabel.hidden = YES;
                    }else{
                        cell.numberLabel.hidden =  NO  ;
                    }
//                    [cell.numberLabel.text integerValue] == 0 ? cell.numberLabel.hidden = YES :  NO ;
                    
                }else if (indexPath.row == 4) {
                    cell.numberLabel.text = [NSString stringWithFormat:@"%@",numberArr[3]];
                    if ([cell.numberLabel.text integerValue] == 0) {
                        cell.numberLabel.hidden = YES;
                    }else{
                        cell.numberLabel.hidden =  NO  ;
                    }
//                    [cell.numberLabel.text integerValue] == 0 ? cell.numberLabel.hidden = YES :  NO ;
                    
                }else {
                    cell.numberLabel.hidden = YES;
                }
                
            }
                
            }else {
                cell.numberLabel.hidden = YES;
            }
            
            cell.kindNameLabel.text = nameArr[indexPath.row];
            collectionCell = cell;

        }else if (indexPath.section == 3){
             MyKindUseCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:myKindUseCellID forIndexPath:indexPath];
           
            cell.kindImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",iconArray[indexPath.row]]];
            cell.numberLabel.hidden = YES;
//            cell.numberLabel.text = @"2";
            cell.kindNameLabel.text = nameArray[indexPath.row];
            collectionCell = cell;
            if (indexPath.row == 7) {
                NSString *isAlreadyApply = [NSString stringWithFormat:@"%@",personDataDic[@"ProxyApply"][@"isAlreadyApply"]];
                if ([isAlreadyApply isEqualToString:@"1"]) {
                     cell.numberLabel.hidden =  YES ;
                }else {
                     cell.numberLabel.hidden =  NO  ;
                }
                
            }
            
        }
       
        
    }
    
    return collectionCell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (token != nil) {
       
        if (indexPath.section == 1) {
            NSLog(@"点击了1区%ld个",(long)indexPath.row);
            [self.navigationController pushViewController:[MyPurseViewController new] animated:YES];
        }else if (indexPath.section == 2) {
            NSLog(@"点击了2区%ld个",(long)indexPath.row);
            if (indexPath.row < 5 ) {
                MyOrderViewController *myOrderVC = [MyOrderViewController new];
                myOrderVC.selectedIndex = indexPath.row;
                [self.navigationController pushViewController:myOrderVC animated:YES];
            }else if (indexPath.row == 6) {
                //             *
                [self.navigationController pushViewController:[RecordProfitViewController new] animated:YES];
            }else{
                
            }
        }else if (indexPath.section == 3) {
            NSLog(@"点击了3区%ld个",(long)indexPath.row);
            if (indexPath.row == 0) {
                FansNumberViewController *fan = [FansNumberViewController new];
//                fan.token = token;
                [self.navigationController pushViewController:fan animated:YES];
            }else if (indexPath.row == 1) {
                MyCourseViewController *myCourse = [[MyCourseViewController alloc] init];
                [self.navigationController pushViewController:myCourse animated:YES];
            }
            else if(indexPath.row == 2) {
                NSString *telStr = @"0571-57183790";
                UIWebView *callWebView = [[UIWebView alloc] init];
                NSURL *telURL = [NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",telStr]];
                [callWebView loadRequest:[NSURLRequest requestWithURL:telURL]];

                [self.view addSubview:callWebView];
//
            }else if(indexPath.row == 3) {
                SendGiftViewController *sendVC = [SendGiftViewController new];
                
                [self.navigationController pushViewController:sendVC animated:YES];
                
            }else if (indexPath.row == 4) {
                MyCardViewController *myCardVC = [[MyCardViewController alloc] init];
                [self.navigationController pushViewController:myCardVC animated:YES];
            }else if (indexPath.row == 5) {
                WebTestViewController *web = [WebTestViewController new];
                web.requestString = [NSString stringWithFormat:@"https://appnew.zhongjianmall.com/html/waterPurifier.html?token=%@",token];//@"l";
                [self.navigationController pushViewController:web animated:YES];
            }else if (indexPath.row == 6) {
                ShowRealStateViewController *show = [ShowRealStateViewController new];

                [self.navigationController pushViewController:show animated:YES];
            }
            else if (indexPath.row == 7){
                [self.navigationController pushViewController:[ApplicationFormViewController new] animated:YES];
//                [self.navigationController pushViewController:[LoginViewController new] animated:YES];
            }
            
        }
    }else {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"未登录" message:@"请先登录" preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self.navigationController pushViewController:[LoginViewController new] animated:YES];
        }]];
        [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }]];
        [self presentViewController:alert animated:YES completion:nil];
    }
    

//    
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
     // 禁止下拉
    if (scrollView.contentOffset.y <= 0) {
        
        scrollView.bounces = NO;
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)pushNext {
    
#pragma mark - 判断是否登入
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *token = [user objectForKey:@"userToken"];
    
    if (token != nil && token != [NSNull class]) {
        [self.navigationController pushViewController:[ChangeInformationViewController new] animated:YES];
    } else {
         [self.navigationController pushViewController:[LoginViewController new] animated:YES];
    }
    
    
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
