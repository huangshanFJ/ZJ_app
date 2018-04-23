//
//  HomeViewController.m
//  ZhongJianMalliOS
//
//  Created by 段 on 2017/10/31.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "HomeViewController.h"
#import "JKBannarView.h"
#import <JhtMarquee/JhtVerticalMarquee.h>
//#import "SearhViewController.h"
#import "SpecialgiftsViewController.h"
#import "SpecialShopViewController.h"
#import "NewRegisterViewController.h"
#import "NewsViewController.h"
#import "DetailViewController.h"
#import "CommercialViewController.h"
/* head */
#import "TitleHeadView.h"
/* foot */
#import "FooterColletionNews.h"
/*  cell  */
#import "BannerCollectionViewCell.h"
#import "BannerShowCell.h"
#import "ShopShowCell.h"
#import "PYSearch.h"
#import "QRcodeScanViewController.h"
#import "BannerModel.h"
#import "UIBarButtonItem+DCBarButtonItem.h"
#import "WebTestViewController.h"
#import "MemberAreaViewController.h"
#import "SearchHistoryViewController.h"
#import "DirectUpgradesViewController.h"
#import  <AudioToolbox/AudioToolbox.h>
#import "HomeRedPacketViewController.h"

//#import "SDCycleScrollView.h"
#import "WebTestViewController.h"
#import "BusinessSchViewController.h"

@interface HomeViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout,UIGestureRecognizerDelegate,PYSearchViewControllerDelegate> {
     // 上下滚动的跑马灯
     JhtVerticalMarquee *_verticalMarquee;
     // 是否暂停了上下滚动的跑马灯
     BOOL _isPauseV;
     NSMutableArray *bannerDataArray;
     NSMutableArray *homeDataArray;
     //跑马灯数据源
     NSArray *JhtVerticalMarqueeDataArray;

     NSDictionary *dataDic;
     NSString *token;
     UIView *alertView;
     
     NSArray *imageArrSection;
     NSArray *nameArrSection;
     JKBannarView *bannerView;
     FooterColletionNews *footView;
     TitleHeadView *titleHeadView;
     
//     SDCycleScrollView *_sdcycleScrollView;
}
/* collectionView */
@property (strong , nonatomic)UICollectionView *homeCollectionView;

@end
//cell
static NSString *const BannerCollectionViewCellID = @"BannerCollectionViewCell";
static NSString *const bannerShowCellID = @"BannerShowCell";
static NSString *const shopCollectionViewCellID = @"ShopShowCell";
//head
static NSString *const titleCollectionCellID = @"TitleHeadView";
//foot
static NSString *const footCollectionViewID = @"FooterColletionNews";
@implementation HomeViewController
- (void)viewDidAppear:(BOOL)animated {
     [super viewDidAppear:animated];
     // 如果暂停了，使用继续方式开启
     if (_isPauseV) {
          [_verticalMarquee marqueeOfSettingWithState:MarqueeContinue_V];
     }
     
}
- (void)viewWillAppear:(BOOL)animated {
     self.navigationController.navigationBar.hidden = NO;
}
- (void)request {

     AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
     manager.responseSerializer = [AFJSONResponseSerializer serializer];

     NSString *url = [NSString stringWithFormat:@"%@%@",HTTPUrl,@"/zjapp/appNeedUpdate"];
     [manager GET:url parameters:@{@"appCurrentVersion":[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]} progress:^(NSProgress * _Nonnull downloadProgress) {

     } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
          NSLog(@"-=-=-=%@ ",responseObject);
          
          NSString *message = responseObject[@"error_message"];
          NSString *error_code = [NSString stringWithFormat:@"%@",responseObject[@"error_code"]];
          if ([error_code isEqualToString:@"0"]) {
               //无需更新
          } else if ([error_code isEqualToString:@"1"]) {
               //提示更新
               [self appNeedUpdateMandatory:NO message:message];
          } else if ([error_code isEqualToString:@"-1"]) {
               //强制更新
               [self appNeedUpdateMandatory:YES message:message];
          }
          
        


     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
          NSLog(@"%@",error);
     }];
     
     
     
}

//更新
- (void)appNeedUpdateMandatory:(BOOL)update message:(NSString *)message {
     
     UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:message preferredStyle:UIAlertControllerStyleAlert];
     
     
     UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault
                                                           handler:^(UIAlertAction * action) {
                                                                //响应事件
                                                                NSLog(@"action = %@", action);
                                                                [self jumpToAppstore];
                                                           }];
     UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {
                                                               //响应事件
                                                               NSLog(@"action = %@", action);
                                                          }];

     if (!update) {
           [alert addAction:cancelAction];
     }
     [alert addAction:defaultAction];
     [self presentViewController:alert animated:YES completion:nil];
     
     
}
//跳转appstore
- (void)jumpToAppstore {
     NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://itunes.apple.com/cn/app/zhongjianshangcheng2-0/id1345811927?mt=8"]];
     [[UIApplication sharedApplication] openURL:url];
}

- (void)viewDidLoad {
   
     [super viewDidLoad];
     // Do any additional setup after loading the view.
     self.view.backgroundColor = [UIColor whiteColor];
     [self request];
     //隐藏返回按钮
     UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];
     backItem.tintColor = [UIColor whiteColor];
     self.navigationItem.backBarButtonItem = backItem;
     bannerDataArray = [NSMutableArray arrayWithCapacity:0];
     homeDataArray = [NSMutableArray arrayWithCapacity:0];
     dataDic = [NSDictionary dictionary];
     self.automaticallyAdjustsScrollViewInsets = NO;
     NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
     token = [userDefaults objectForKey:@"userToken"];
     imageArrSection = @[@"icon1",@"icon2",@"icon3",@"icon4"];//@[@"恭",@"贺",@"新",@"禧"];//
     nameArrSection = @[@"新人红包",@"签到好礼",@"会员专区",@"商学院"];
     [self httpRequest];
     static dispatch_once_t disOnce;
     
     dispatch_once(&disOnce,^ {
          
          //只执行一次的代码
          [self showAlert];
     });
     [self setUpNav];

     [self configCollectionView];
     
     //摇一摇
     [UIApplication sharedApplication].applicationSupportsShakeToEdit = YES;
     // 并让自己成为第一响应者
     [self becomeFirstResponder];
     
}
- (void)showAlert {
     
     alertView = [[UIView alloc] initWithFrame:CGRectMake(0, -KHEIGHT, KWIDTH, -KHEIGHT)];
     alertView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.8];
     alertView.tag = 1000;
     [UIView animateWithDuration:1.0f delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
          //动画终点
          alertView.frame = CGRectMake(0, 0, KWIDTH, KHEIGHT);
          
     } completion:^(BOOL finished) {
          
          //view最终状态（UIView会从动画结束状态转换到此处设定的状态，在转换过程中没有动画效果）
          alertView.frame = CGRectMake(0, 0, KWIDTH, KHEIGHT);
          
     }];
     
     
     UIApplication *ap = [UIApplication sharedApplication];
     [ap.keyWindow addSubview:alertView];
     UIButton *close = [UIButton buttonWithType:UIButtonTypeCustom];
     [close setBackgroundImage:[UIImage imageNamed:@"close-1"] forState:UIControlStateNormal];
     [close addTarget:self action:@selector(closeClick) forControlEvents:UIControlEventTouchUpInside];
     [alertView addSubview:close];
     [close mas_makeConstraints:^(MASConstraintMaker *make) {
          make.centerX.mas_offset(0);
          make.width.mas_offset(24);
          make.height.mas_offset(24);
          make.top.mas_offset(-KHEIGHT+20);
     }];
     UIImageView *line = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"矩形3"]];
     [alertView addSubview:line];
     [line mas_makeConstraints:^(MASConstraintMaker *make) {
          make.centerX.mas_offset(0);
          make.height.mas_offset(168);
          make.width.mas_offset(4);
          make.top.equalTo(close.mas_bottom).offset(0);
     }];
     
     UIImageView *showImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"组1"]];
     showImage.userInteractionEnabled = YES;
     [alertView addSubview:showImage];
     [showImage mas_makeConstraints:^(MASConstraintMaker *make) {
          make.width.mas_offset(KWIDTH*0.69);
          make.height.mas_offset(KHEIGHT*0.54);
          make.centerX.mas_offset(0);
          make.top.equalTo(line.mas_bottom).offset(-20);
     }];
     UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick)];
     [showImage addGestureRecognizer:tap];
 
}
- (void)tapClick {
     [alertView removeFromSuperview];
     WebTestViewController *web = [[WebTestViewController alloc] init];
     web.requestString = @"https://appnew.zhongjianmall.com/html/fans.html";
     [self.navigationController pushViewController:web animated:YES];
}
- (void)closeClick {
    
     [alertView removeFromSuperview];
}
- (void)httpRequest {

     AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
     manager.responseSerializer = [AFJSONResponseSerializer new];
     MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
     NSString *url = [NSString stringWithFormat:@"%@%@",HTTPUrl,@"/zjapp/v1/HomePage/initHomePage?productNum=50"];
     NSLog(@"----%@",url);

//     NSDictionary *dic = @{
//   };
     [bannerDataArray removeAllObjects];
     [manager GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {

     } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
          NSLog(@"成功=%@",responseObject);
          if ([responseObject[@"error_message"] isEqualToString:@"成功"]) {
               dataDic = responseObject[@"data"];
               NSArray *manerArr = [NSArray arrayWithArray:responseObject[@"data"][@"picList"]];
               for (NSDictionary *dic in manerArr) {
                    BannerModel *model = [[BannerModel alloc] init];
                    model.AdvType = [NSString stringWithFormat:@"%@",dic[@"AdvType"]];//[dic objectForKey:@"AdvType"];
                    model.Pic = [NSString stringWithFormat:@"%@",dic[@"Pic"]];
                    model.ProductId = [NSString stringWithFormat:@"%@",dic[@"ProductId"]];
                    model.Url = [NSString stringWithFormat:@"%@",dic[@"Url"]];
                    [bannerDataArray addObject:model];
               }

               homeDataArray = [NSMutableArray arrayWithArray:responseObject[@"data"][@"products"]];

               NSString *str = [[dataDic objectForKey:@"tile"] objectForKey:@"Title"];

               JhtVerticalMarqueeDataArray = [str componentsSeparatedByString:@"|"];

               [_homeCollectionView reloadData];
               [hud hideAnimated:YES];
               [self endRefresh];
          };


     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
          NSLog(@"失败是=%@",error);
          [hud hideAnimated:YES];
     }];
//
     
}
//导航
- (void)setUpNav {
     
//     self.navigationItem.leftBarButtonItem = [UIBarButtonItem ItemWithImage:[UIImage imageNamed:@"scan_gray"] WithHighlighted:[UIImage imageNamed:@"scan_gray"] Target:self action:@selector(richScanItemClick)];
//     self.navigationItem.rightBarButtonItem = [UIBarButtonItem ItemWithImage:[UIImage imageNamed:@"news_gray"] WithHighlighted:[UIImage imageNamed:@"news_gray"] Target:self action:@selector(messageItemClick)];
     
     UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KWIDTH-10, 24)];
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
//ui
- (void)configCollectionView {
     
     UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
     _homeCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, KWIDTH, KHEIGHT-64-49) collectionViewLayout:layout];
     
     _homeCollectionView.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];
     _homeCollectionView.showsVerticalScrollIndicator = NO;
     
     _homeCollectionView.delegate = self;
     _homeCollectionView.dataSource = self;

     _homeCollectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
          // 进入刷新状态后会自动调用这个block
          [self httpRequest];
     }];
 
     //注册
     [_homeCollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"bannerHeadID"];
     [_homeCollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:titleCollectionCellID];
     [_homeCollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:footCollectionViewID];
     
     [_homeCollectionView registerClass:[ShopShowCell class] forCellWithReuseIdentifier:shopCollectionViewCellID];
     [_homeCollectionView registerClass:[BannerShowCell class] forCellWithReuseIdentifier:bannerShowCellID];
     [_homeCollectionView registerClass:[BannerCollectionViewCell class] forCellWithReuseIdentifier:BannerCollectionViewCellID];
     
     [self.view addSubview:_homeCollectionView];
     
}

#pragma mark - <UICollectionViewDataSource>
//一共有多少个组
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
     return homeDataArray.count+1;
}
//每一组有多少个cell
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
   
//     return section == 0 ? 3 : [homeDataArray[section] count];
     if (section == 0) {
          return nameArrSection.count;
     }else {
//          NSLog(@"---+++++%lu", [homeDataArray[section-1][@"productsOfTag"] count]);
//          if ([homeDataArray[section-1][@"productsOfTag"] count ] > 10) {
//               return 10;
//          }else {
//               return [homeDataArray[section-1][@"productsOfTag"] count];
//          }
//          return 10;//[homeDataArray[section-1][@"productsOfTag"] count];
          
          //add by fj
          return [homeDataArray[section-1][@"productsOfTag"] count];
          
     }
     
}
//动态设置每列的间距大小
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
     return section == 0 ? 0 : 7;
}
//动态设置每行的间距大小

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout             minimumLineSpacingForSectionAtIndex:(NSInteger)section {
     return section == 0 ? 0 : 8;
}

//头部试图的大小
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
     return section == 0 ? CGSizeMake(KWIDTH, KWIDTH/2) : CGSizeMake(KWIDTH, 44);
     
}
//脚部试图的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
     return  section == 0 ? CGSizeMake(KWIDTH, 47) : CGSizeMake(0, 0);
     ;
}
//动态设置每个Item的尺寸大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
     
     if (indexPath.section == 0) {
          return CGSizeMake(KWIDTH/nameArrSection.count, 94);
     }else {
//          if (indexPath.row == 0) {
//               return CGSizeMake(KWIDTH, 151);
//          }else{
               return CGSizeMake(KWIDTH/2-4, 260);
//          }
     }
     
}


- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
     
     UICollectionReusableView *reusableview = nil;
     if (kind == UICollectionElementKindSectionHeader) {
          if (indexPath.section == 0) {
               reusableview = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"bannerHeadID" forIndexPath:indexPath];
               NSMutableArray *imageViews = [[NSMutableArray alloc]init];
//               [imageViews addObjectsFromArray:@[@"banner",@"banner1",@"banner2"]];
               BannerModel *model = [[BannerModel alloc] init];
               NSString *type;
               NSInteger typeIndex ;
               if (bannerDataArray.count > 0) {
                    for (int i = 0; i < bannerDataArray.count; i++) {
                         model = bannerDataArray[i];
                         if (dataDic != nil) {
                              NSString *urlStr = [NSString stringWithFormat:@"%@%@",HTTPUrl,model.Pic];
                              type = [NSString stringWithFormat:@"%@",model.AdvType];
                              [imageViews addObject:urlStr];
                              if ([type integerValue] == 3) {
                                   typeIndex = i;
                              }
                         }
                         
                    }
               }
               
//                NSLog(@"照片%@",imageViews);
               NSLog(@"%@",type);
               
               if (!bannerView) {
                    bannerView = [[JKBannarView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), self.view.frame.size.width/2) viewSize:CGSizeMake(CGRectGetWidth(self.view.bounds),self.view.frame.size.width/2)];
               }
               
               if(imageViews.count > 0) {
                    NSLog(@"照片个数%lu",(unsigned long)imageViews.count);
                    bannerView.items = imageViews;
               }
           
              
               [bannerView imageViewClick:^(JKBannarView * _Nonnull barnerview, NSInteger index) {
                    NSLog(@"点击图片%ld",(long)index);
                    //                            [self pushNext];
                   
                    if (typeIndex == index) {
                         DirectUpgradesViewController *directVC = [[DirectUpgradesViewController alloc] init];
                         [self.navigationController pushViewController:directVC animated:YES];
                    } else {
                         BannerModel *model = bannerDataArray[index];
                         if( ![model.Url isEqualToString:@""])  {
                              WebTestViewController *web = [[WebTestViewController alloc] init];
                               web.requestString = model.Url;
                              [self.navigationController pushViewController:web animated:YES];
                         }
                         
                    }
                    
               }];
               [reusableview addSubview:bannerView];

          }
          else {//if (indexPath.section == 1) {
               
               reusableview = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:titleCollectionCellID forIndexPath:indexPath];
               
               if (!titleHeadView) {
                    titleHeadView = [[TitleHeadView alloc] initWithFrame:CGRectMake(0, 0, KWIDTH, 44)];
               }
               
               if (homeDataArray.count > 0) {
                    titleHeadView.titleShowLabel.text = [NSString stringWithFormat:@"%@",homeDataArray[indexPath.section-1][@"tagName"]];//@"特色商品";
                    NSLog(@"-----%@",titleHeadView.titleShowLabel.text);
               }
             
               titleHeadView.headButtonClickBlock = ^{
                    SpecialgiftsViewController *specialVC = [SpecialgiftsViewController new];
                    specialVC.showTitle = [NSString stringWithFormat:@"%@",homeDataArray[indexPath.section-1][@"tagName"]];
                    specialVC.selectedTag = [NSString stringWithFormat:@"%@",homeDataArray[indexPath.section-1][@"tagId"]];
                    [self.navigationController pushViewController:specialVC animated:YES];
               };
 
               [reusableview addSubview:titleHeadView];
          }
   
          
     }
     if (kind == UICollectionElementKindSectionFooter) {
          if (indexPath.section == 0) {
               reusableview  = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:footCollectionViewID forIndexPath:indexPath];
               if (!footView) {
                    footView = [[FooterColletionNews alloc] initWithFrame:CGRectMake(0, 0, KWIDTH, 40)];
               }
               
               footView.backgroundColor = [UIColor whiteColor];
               if (!_verticalMarquee) {
                    _verticalMarquee = [[JhtVerticalMarquee alloc]  initWithFrame:CGRectMake(130, 10, KWIDTH-140, 25)];
               }
               
               [footView addSubview:_verticalMarquee];
               NSArray *soureArray = [NSArray array];
 
               if (dataDic != nil) {

                    if (dataDic[@"tile"] != nil) {
               
                         soureArray = JhtVerticalMarqueeDataArray;

                    }else {
                         soureArray = @[@" "];
                    }

               }
               
               
               _verticalMarquee.sourceArray = soureArray;
               [_verticalMarquee scrollWithCallbackBlock:^(JhtVerticalMarquee *view, NSInteger currentIndex) {
                    //                NSLog(@"滚动到第 %ld 条数据", (long)currentIndex);
               }];
               
               // 开始滚动
               [_verticalMarquee marqueeOfSettingWithState:MarqueeStart_V];
               
               // 给跑马灯添加点击手势
//               UITapGestureRecognizer *vtap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(verticalMarqueeTapGes:)];
//               [_verticalMarquee addGestureRecognizer:vtap];
          
          [reusableview addSubview:footView];
               
          }
     }
     
     return reusableview;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
     UICollectionViewCell *collectionCell = nil;
     if (indexPath.section == 0) {//10
          
          BannerCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:BannerCollectionViewCellID forIndexPath:indexPath];
          //        cell.backgroundColor = [UIColor whiteColor];
          
          cell.newsHeadImage.image = [UIImage imageNamed:imageArrSection[indexPath.row]];
          cell.newsNameLabel.text = [NSString stringWithFormat:@"%@",nameArrSection[indexPath.row]];
          collectionCell = cell;
          
     }
     else {
          ShopShowCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:shopCollectionViewCellID forIndexPath:indexPath];
               cell.backgroundColor = [UIColor whiteColor];
        
          if (homeDataArray.count > 0) {

               cell.priceLabel.text = [NSString stringWithFormat:@"￥%@",homeDataArray[indexPath.section-1][@"productsOfTag"][indexPath.row][@"price"]];
               NSString *number = [NSString stringWithFormat:@"%@",homeDataArray[indexPath.section-1][@"productsOfTag"][indexPath.row][@"elecnum"]];
               int miniteNumber = [number intValue];
               double showNumber = (double)miniteNumber/(double)2;
//               cell.minitLabel.text
               NSString *numberStr = [NSString stringWithFormat:@"%.2lf",showNumber];
               NSTextAttachment *attach = [[NSTextAttachment alloc] initWithData:nil ofType:nil];
               attach.bounds = CGRectMake(0, 0, 12, 12);
               attach.image = [UIImage imageNamed:@"redpacket"];
               
               NSAttributedString *strAtt = [NSAttributedString attributedStringWithAttachment:attach];
               
               NSMutableAttributedString *strMatt = [[NSMutableAttributedString alloc] initWithString:numberStr];
               [strMatt insertAttributedString:strAtt atIndex:0];
               cell.minitLabel.attributedText = strMatt;
               NSString *urlStr;
               cell.nameLabel.text = [NSString stringWithFormat:@"%@",homeDataArray[indexPath.section-1][@"productsOfTag"][indexPath.row][@"productname"]];
               if ([homeDataArray[indexPath.section-1][@"productsOfTag"][indexPath.row][@"productphotos"] count]  > 0) {
                   urlStr = [NSString stringWithFormat:@"%@%@",HTTPUrl,homeDataArray[indexPath.section-1][@"productsOfTag"][indexPath.row][@"productphotos"][0][@"photo"]];
               }else {
                    NSString *urlStr = @"";
               }
//               NSString *urlStr = [NSString stringWithFormat:@"%@%@",HTTPUrl,homeDataArray[indexPath.section-1][@"productsOfTag"][indexPath.row][@"productphotos"][0][@"photo"]];
 
               NSURL *url = [NSURL URLWithString:urlStr];
               [cell.shopImage sd_setImageWithURL:url];
          }
 
               collectionCell = cell;
//          }
          
     }
     
     return collectionCell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
     
     if (indexPath.section == 0) {//4
          if (token == nil) {
               UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"未登录" message:@"请先登录" preferredStyle:UIAlertControllerStyleAlert];
               [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    [self.navigationController pushViewController:[LoginViewController new] animated:YES];
               }]];
               [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                    
               }]];
               [self presentViewController:alert animated:YES completion:nil];
          }else {
               NSLog(@"点击了第%zd",indexPath.row);
               if (indexPath.row == 0) {
                    WebTestViewController *webView = [[WebTestViewController alloc] init];
//                    [self.navigationController pushViewController:[NewRegisterViewController new] animated:YES];
                    webView.requestString = [NSString stringWithFormat:@"https://appnew.zhongjianmall.com/html/newpeople.html?token=%@",token];
                    [self.navigationController pushViewController:webView animated:YES];
                    
               }else if (indexPath.row == 1) {
                    WebTestViewController *webView = [[WebTestViewController alloc] init];
                    //                    [self.navigationController pushViewController:[NewRegisterViewController new] animated:YES893cde93-4504-4639-8ebd-2bda76530bd4];
                    webView.requestString = [NSString stringWithFormat:@"https://appnew.zhongjianmall.com/html/signIn.html?token=%@",token];
                    [self.navigationController pushViewController:webView animated:YES];
               }else if (indexPath.row == 2) {
//              {
                    MemberAreaViewController *specialVC = [MemberAreaViewController new];
                    specialVC.showTitle = @"会员专区";
                    specialVC.selectedTag = @"";
                    [self.navigationController pushViewController:specialVC animated:YES];
               }else {
                    BusinessSchViewController *vc = [[BusinessSchViewController alloc] init];
//                    vc.showTit = @"商学院";
                    [self.navigationController pushViewController:vc animated:YES];
               }
//               else if (indexPath.row == 3) {
//                    [self.navigationController pushViewController:[CommercialViewController new] animated:YES];
//               }
          }
         
     }else {//if (indexPath.section == 1){
          NSLog(@"点击了推荐的第%zd个商品",indexPath.row);
           
          DetailViewController *shopVC = [DetailViewController new];
          shopVC.productId = [NSString stringWithFormat:@"%@",homeDataArray[indexPath.section-1][@"productsOfTag"][indexPath.row][@"id"]];
          [self.navigationController pushViewController:shopVC animated:YES];
     }
}

//- (void)richScanItemClick {
//     NSLog(@"点击了扫描");
//     [self.navigationController pushViewController:[QRcodeScanViewController new] animated:YES];
//}
- (void)messageItemClick {
     NSLog(@"点击了消息");
//     [self.navigationController pushViewController:[NewsViewController new] animated:YES];
}
- (void)goSearchVC {
     NSLog(@"点击了搜索");
     
     NSArray *hotSeaches = nil;
     // 2. Create a search view controller
//     NSLocalizedString(@"", @"搜索商品名称")
     PYSearchViewController *searchViewController = [PYSearchViewController searchViewControllerWithHotSearches:hotSeaches searchBarPlaceholder:@"搜索商品名称" didSearchBlock:^(PYSearchViewController *searchViewController, UISearchBar *searchBar, NSString *searchText) {
          // Called when search begain.
          // eg：Push to a temp view controller
          SearchHistoryViewController *searchHisVC = [SearchHistoryViewController new];
          searchHisVC.showText = searchText;
          
          [searchViewController.navigationController pushViewController:searchHisVC animated:YES];
     }];
     searchViewController.searchTextField.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];
     searchViewController.searchHistoryStyle = PYSearchHistoryStyleARCBorderTag;
     searchViewController.hotSearchStyle = PYHotSearchStyleARCBorderTag;
     
     // 4. Set delegate
     searchViewController.delegate = self;
     // 5. Present a navigation controller
     UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:searchViewController];
     [self presentViewController:nav animated:NO completion:nil];
     //  [self.navigationController pushViewController:[SearhViewController new] animated:YES];
   
}
- (void)verticalMarqueeTapGes:(UITapGestureRecognizer *)ges {
     NSLog(@"点击__纵向__滚动的跑马灯_第 %ld 条数据啦！！！", (long)_verticalMarquee.currentIndex);
     [_verticalMarquee marqueeOfSettingWithState:MarqueePause_V];
     _isPauseV = YES;
     
     //    [self.navigationController pushViewController:[[testVC alloc] init] animated:YES];
}

- (void)didReceiveMemoryWarning {
     [super didReceiveMemoryWarning];
     // Dispose of any resources that can be recreated.
}

#pragma mark 开始进入刷新状态
- (void)endRefresh
{
     
     [_homeCollectionView.mj_header endRefreshing];
//     if (is_noMore == YES) {
//
//          _recordTableView.mj_footer.state = MJRefreshStateNoMoreData;
//          //        _fansTableView.mj_footer.hidden = YES;
//     }else {
//          [_recordTableView.mj_footer endRefreshing];
//     }
}
#pragma mark - 摇一摇
- (void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event {
     NSLog(@"开始摇动");
     return;
}

- (void)motionCancelled:(UIEventSubtype)motion withEvent:(UIEvent *)event {
     NSLog(@"取消摇动");
     return;
}

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event {
     if (event.subtype == UIEventSubtypeMotionShake) { // 判断是否是摇动结束
          NSLog(@"摇动结束");
          
          AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
          HomeRedPacketViewController *packetVC = [[UIStoryboard storyboardWithName:@"Home" bundle:nil] instantiateViewControllerWithIdentifier:@"HomeRedPacketViewController"];
          packetVC.modalPresentationStyle = UIModalPresentationOverCurrentContext;
          
          self.tabBarController.tabBar.hidden = YES; // 隐藏tabBar
          [self presentViewController:packetVC animated:NO completion:^{
               
          }];
          
          
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

