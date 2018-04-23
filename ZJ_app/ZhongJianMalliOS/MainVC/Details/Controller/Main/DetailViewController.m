//
//  DetailViewController.m
//  ZhongJianMalliOS
//
//  Created by 段 on 2017/11/21.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "DetailViewController.h"
#import "JKBannarView.h"
#import "DetailCustomCell.h"
#import "DetailHeadView.h"
#import "DetailClassTableViewCell.h"
#import "DetailCollectionView.h"
#import "ShopDetailHeadView.h"
#import "AddShopViewController.h"
#import "WebTableViewCell.h"
#import "ShopCarViewController.h"
//#import "NavigationViewController.h"
#import "SettlementViewController.h"
#import "ShopCarViewController.h"

#import "HomeViewController.h"
#import "ShopCarChildViewController.h"

@interface DetailViewController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate,AddShopViewControllerDelegate>{
    UIButton *topButton;
    
    NSArray *imageDataArray;
    NSDictionary *dataDiction;
    
}
@property(nonatomic,strong)NSMutableDictionary *heightDic;//

@property (strong, nonatomic) UIScrollView *scrollerView;
@property (nonatomic,strong) UITableView *detailTableView;
@property (strong, nonatomic) UIView *bgView;
/** 记录上一次选中的Button */
@property (nonatomic , weak) UIButton *selectBtn;
/* 标题按钮地下的指示器 */
@property (weak ,nonatomic) UIView *indicatorView;


@end

static NSString *const detailCellID = @"DetailCustomCell";
static NSString *const detailClassCellID = @"DetailCollectionView";
static NSString *const WebTableViewCellID = @"WebTableViewCell";

@implementation DetailViewController
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    //    [self setScrollView];
    imageDataArray = [NSArray array];
    dataDiction = [NSDictionary dictionary];
    // 用于缓存cell高度
    self.heightDic = [[NSMutableDictionary alloc] init];
    // 注册加载完成高度的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(noti:) name:@"WEBVIEW_HEIGHT" object:nil];
    
    [self requestData];
    [self setUpTopButtonView];
    
    [self setTableView];
}

- (void)requestData {
    //
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer new];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    //    if ([_selectedTag isEqualToString:@""]) {
    //
    //    }else {
    NSString *url = [NSString stringWithFormat:@"%@%@",HTTPUrl,@"/zjapp/v1/ProductManager/getProductDetails"];
    NSDictionary *dic = @{
                          @"productId":_productId
                          };
    [manager GET:url parameters:dic progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",responseObject);
        if ([responseObject[@"error_code"] intValue] == 0) {
            dataDiction = responseObject[@"data"];
            imageDataArray = responseObject[@"data"][@"product"][@"productphotos"];
        }
        [self setBottom];
        [_detailTableView reloadData];
        [hud hideAnimated:YES];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
        [hud hideAnimated:YES];
    }];
    
    
}
- (void)setScrollView {
    _scrollerView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, KWIDTH, KHEIGHT-64)];
    _scrollerView.contentSize = CGSizeMake(0, KHEIGHT);
    
}
#pragma mark - 头部View
- (void)setUpTopButtonView {
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
    
    NSArray *titles = @[@"商品",@"评价",@"详情"];
    CGFloat margin = 5;
    
    _bgView = [[UIView alloc] init];
    CGFloat bgHeight = 44;
    CGFloat bgWidth = (60 + margin) * titles.count;
    _bgView.backgroundColor = self.view.backgroundColor;
    
    [self.view addSubview:_bgView];
    [_bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(20);
        make.centerX.mas_offset(0);
        make.height.mas_offset(bgHeight);
        make.width.mas_offset(bgWidth);
    }];
    for (NSInteger i = 0; i < titles.count; i++) {
        
        topButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [topButton setTitle:titles[i] forState:0];
        [topButton setTitleColor:[UIColor colorWithHexString:@"444444"] forState:UIControlStateNormal];
        topButton.tag = i+1000;
        topButton.titleLabel.font = [UIFont systemFontOfSize:17];
        [topButton addTarget:self action:@selector(topBottonClick:) forControlEvents:UIControlEventTouchUpInside];
        CGFloat buttonX = i * (60 + margin);
        
        topButton.frame = CGRectMake(buttonX, 0, 60, bgHeight);
        
        [_bgView addSubview:topButton];
        
    }
    UIButton *firstButton = _bgView.subviews[0];
    [self topBottonClick:firstButton]; //默认选择第一个
    
    //分享按钮
        UIButton *shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [shareButton addTarget:self action:@selector(shareClick:) forControlEvents:UIControlEventTouchUpInside];
        shareButton.tag = 100;
        [shareButton setBackgroundImage:[UIImage imageNamed:@"share"] forState:UIControlStateNormal];
        [self.view addSubview:shareButton];
        [shareButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_offset(-11);
            make.width.mas_offset(20);
            make.height.mas_offset(20);
            make.top.mas_offset(30);
        }];
    
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];
    [self.view addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(0);
        make.right.mas_offset(0);
        make.top.equalTo(_bgView.mas_bottom).offset(-1);
        make.height.mas_offset(1);
    }];
    
    
    //add by zy 添加去购物车按钮
    
//    UIButton *goShopBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [goShopBtn addTarget:self action:@selector(goShopAction) forControlEvents:UIControlEventTouchUpInside];
//
//    [goShopBtn setBackgroundImage:[UIImage imageNamed:@"shoppingcart"] forState:UIControlStateNormal];
//    [self.view addSubview:goShopBtn];
//    [goShopBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.mas_offset(-10);
//        make.top.mas_offset(30);
//        make.width.mas_offset(20);
//        make.height.mas_offset(20);
//    }];
    
}
- (void)setTableView {
    
    _detailTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, KWIDTH, KHEIGHT-108) style:UITableViewStyleGrouped];
    _detailTableView.backgroundColor = [UIColor whiteColor];
    _detailTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _detailTableView.delegate = self;
    _detailTableView.dataSource = self;
    [_detailTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([UITableViewCell class])];
    [self.view addSubview:_detailTableView];
}
#pragma mark -- 底部view
- (void)setBottom {
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, KHEIGHT-44, KWIDTH, 44)];
    bottomView.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];
    [self.view addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(0);
        make.height.mas_offset(44);
        make.width.mas_offset(KWIDTH);
        make.top.mas_offset(KHEIGHT-44);
    }];
    NSArray *imageArr = @[@"customerservice",@"shoppingcart"];//,@"collection"];
    NSArray *titleArr = @[@"客服",@"购物车"];//@"购物车",@"收藏"];
    //    for (NSInteger i = 0; i < imageArr.count; i++) {
    
    //    }
    
    for (NSInteger i = 0; i < imageArr.count; i++) {
        UIButton *bottomButton = [UIButton buttonWithType:UIButtonTypeCustom];
        bottomButton.frame = CGRectMake(0.14*KWIDTH*i, 0, 0.14*KWIDTH, 44);
        
        bottomButton.tag = 10+i;
        [bottomButton addTarget:self action:@selector(bottomClick:) forControlEvents:UIControlEventTouchUpInside];
        [bottomButton setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 10, 0)];
        //        bottomButton setImageed
        [bottomView addSubview:bottomButton];
        
        UIImageView *iconImage = [[UIImageView alloc] init];
        iconImage.image = [UIImage imageNamed:imageArr[i]];
        iconImage.frame = CGRectMake(17, 7, 18, 18);
        [bottomButton addSubview:iconImage];
        UILabel *bottomLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.14*KWIDTH*i, 26, 0.14*KWIDTH, 19)];
        bottomLabel.text = titleArr[i];
        bottomLabel.font = [UIFont systemFontOfSize:11];
        bottomLabel.textAlignment = 1;
        bottomLabel.textColor = [UIColor colorWithHexString:@"444444"];
        [bottomView addSubview:bottomLabel];
        
    }
    //hide by zy
//    if (dataDiction[@"beLongToVIP"] == 0) {
    if ([dataDiction[@"beLongToVIP"] boolValue] == 0) {

        UIButton *addShopButton = [UIButton buttonWithType:UIButtonTypeCustom];
        addShopButton.frame = CGRectMake( 0.14*KWIDTH*titleArr.count, 0,(KWIDTH-0.14*KWIDTH*titleArr.count)/2, 44);
        addShopButton.backgroundColor = [UIColor colorWithRed:238/255.0 green:186/255.0 blue:96/255.0 alpha:1];
        [addShopButton setTitle:@"加入购物车" forState:UIControlStateNormal];
//        addShopButton.userInteractionEnabled = NO;
        addShopButton.userInteractionEnabled = YES;
//        addShopButton.backgroundColor = lightgrayTextColor;
        addShopButton.backgroundColor =[UIColor colorWithRed:246/255.0 green:172/255.0 blue:51/255.0 alpha:1];
        
        addShopButton.titleLabel.font = [UIFont systemFontOfSize:15];
        [addShopButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [addShopButton addTarget:self action:@selector(addShopClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [bottomView addSubview:addShopButton];
        
        UIButton *buyButton = [UIButton buttonWithType:UIButtonTypeCustom];
        buyButton.frame = CGRectMake((KWIDTH-0.14*KWIDTH*titleArr.count)/2+0.14*KWIDTH*titleArr.count, 0,(KWIDTH-0.14*KWIDTH*titleArr.count)/2, 44);
        buyButton.backgroundColor = [UIColor colorWithHexString:@"6493ff"];
        [buyButton setTitle:@"立即购买" forState:UIControlStateNormal];
        //        buyButton.userInteractionEnabled = NO;
        //        buyButton.backgroundColor = lightgrayTextColor;
        [buyButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [buyButton addTarget:self action:@selector(buyButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        buyButton.titleLabel.font = [UIFont systemFontOfSize:15];
        [bottomView addSubview:buyButton];
    }else {
        UIButton *buyButton = [UIButton buttonWithType:UIButtonTypeCustom];
        buyButton.frame = CGRectMake(0.14*KWIDTH*titleArr.count, 0, KWIDTH-0.14*KWIDTH*titleArr.count , 44);
        buyButton.backgroundColor = [UIColor colorWithHexString:@"6493ff"];
        //        buyButton.userInteractionEnabled = NO;
        //        buyButton.backgroundColor = lightgrayTextColor;
        
        [buyButton setTitle:@"立即购买" forState:UIControlStateNormal];
        [buyButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [buyButton addTarget:self action:@selector(buyButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        buyButton.titleLabel.font = [UIFont systemFontOfSize:15];
        [bottomView addSubview:buyButton];
    }
    
    
    
    
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;//3
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //return section == 2 ? 0: 1;//
#pragma mark -- gai
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    //    return 94;//indexPath.section == 1 ? 40 :
    if (indexPath.section == 0) {
        return 94;
    }else if (indexPath.section == 1) {
        return 40;
    }else if (indexPath.section == 2) {
        return 0.01;
    }else {
#pragma mark----   不确定的值
        return 0.01;
        
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    //    return section == 0 ? KWIDTH : 0;
    if (section == 0) {
        return KWIDTH;
    }
    else if(section == 1) {
        return 0.001;
    }else if(section == 3){
#pragma mark-- 大概值
        UIWebView *webview = [[UIWebView alloc] init];
        NSString *str = [NSString stringWithFormat:@"https://appnew.zhongjianmall.com/html/productdetails.html?productId=%@",self.productId];
        
        CGFloat webViewHeight = [[webview stringByEvaluatingJavaScriptFromString:@"document.body.scrollHeight"] floatValue];
        [webview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
        webview.frame = CGRectMake(0, 40, KWIDTH, webViewHeight);
        return 40+webViewHeight;
    }else{
        return 45;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 7;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    if (section == 0) {
        UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KWIDTH, KWIDTH)];
        NSMutableArray *imageViews = [[NSMutableArray alloc]init];
        //    [imageViews addObjectsFromArray:@[@"banner",@"banner1",@"banner2"]];
        
        
        if (imageDataArray.count > 0) {
            for (int i=0; i<imageDataArray.count; i++) {
                NSString *urlStr = [NSString stringWithFormat:@"%@%@",HTTPUrl,imageDataArray[i][@"photo"]];
                [imageViews addObject:urlStr];
            }
        }
        NSLog(@"照片%@",imageViews);
        JKBannarView *bannerView = [[JKBannarView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), self.view.frame.size.width) viewSize:CGSizeMake(CGRectGetWidth(self.view.bounds),self.view.frame.size.width)];
        if(imageViews.count > 0) {
            NSLog(@"照片个数%lu",(unsigned long)imageViews.count);
            bannerView.items = imageViews;
        }
        
        //     bannerView.items = imageViews;
        [bannerView imageViewClick:^(JKBannarView * _Nonnull barnerview, NSInteger index) {
            NSLog(@"点击图片%ld",(long)index);
            //        [self pushNext];
        }];
        [headView addSubview:bannerView];
        
        return headView;
    }
    else if ( section == 2) {
        DetailHeadView *headView = [[DetailHeadView alloc] initWithFrame:CGRectMake(0, 0, KWIDTH, 45)];
        headView.shopClassLabel.text = @"商品评价";
        //        headView.numberLabel.text = @"1122条";
        //        headView.praiseLabel.text = @"100%好评";
        headView.selectedButtonClickNextBlock = ^{
            NSLog(@"评价");
        };
        
        return headView;
    }
    else if ( section == 3){
        UIWebView *webview = [[UIWebView alloc] init];
        NSString *str = [NSString stringWithFormat:@"https://appnew.zhongjianmall.com/html/productdetails.html?productId=%@",self.productId];

        CGFloat webViewHeight = [[webview stringByEvaluatingJavaScriptFromString:@"document.body.scrollHeight"] floatValue];
        [webview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
        webview.frame = CGRectMake(0, 40, KWIDTH, webViewHeight);
       
        ShopDetailHeadView *headView = [[ShopDetailHeadView alloc] initWithFrame:CGRectMake(0, 0, KWIDTH, 40+webViewHeight )];
        headView.productId = self.productId;
        return headView;
    }else{
        UIView *headView = [[UIView alloc] initWithFrame:CGRectZero];
        return headView;
    }
    
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    if (section == 3) {
        UIView *footView = [[UIView alloc] initWithFrame:CGRectZero];
        return footView;
    }else{
        UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KWIDTH, 7)];
        footView.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];
        
        return footView;
    }
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = nil;
    
    
    if (indexPath.section == 0) {
        DetailCustomCell *detailCell = [[DetailCustomCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:detailCellID];
        if (dataDiction != nil) {
            detailCell.detailNameLabel.text = [NSString stringWithFormat:@"%@",dataDiction[@"product"][@"productname"]];
            NSString *price = [NSString stringWithFormat:@"%@",dataDiction[@"product"][@"price"]];
            NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"￥ %@",price]];//@"￥ 128"];
            [AttributedStr addAttribute:NSFontAttributeName
                                  value:[UIFont systemFontOfSize:11.0]
                                  range:NSMakeRange(0, 2)];
            [AttributedStr addAttribute:NSFontAttributeName
                                  value:[UIFont fontWithName:@"Arial Rounded MT Bold" size:19]
                                  range:NSMakeRange(2, price.length)];
            detailCell.priceLabel.attributedText = AttributedStr;
            detailCell.miniteLabel.textColor = [UIColor redColor];
            detailCell.miniteLabel.text = [NSString stringWithFormat:@"%.2f",[dataDiction[@"product"][@"elecnum"] floatValue]/2];//@"30积分";
            detailCell.reserveLable.text = [NSString stringWithFormat:@"库存%@件",dataDiction[@"product"][@"stocknum"]];//@"库存99件";
            detailCell.placeLable.text = [NSString stringWithFormat:@"%@",dataDiction[@"product"][@"placeofdelivery"]];//@"杭州";
        }
        
        
        cell = detailCell;
    }
    else if (indexPath.section == 1) {
        DetailClassTableViewCell *classCell = [[DetailClassTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:detailClassCellID];
        classCell.detailClassLabel.text = @"请选择规格";
        
        cell = classCell;
        
    }else if (indexPath.section == 2) {
#warning 暂时不用
        NSArray *imageArr = @[@"banner",@"banner"];
        //        NSArray *headImage = @[];
        NSArray *nameArr = @[@"入",@"222"];
        NSArray *title = @[@"1234",@"2e434"];
        cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class]) forIndexPath:indexPath];

        DetailCollectionView * classCell = [[DetailCollectionView alloc] initWithFrame:CGRectMake(0, 0, KWIDTH, 120) collectionViewItemSize:CGSizeMake(255, 120) withImageArr:imageArr withHeadImageArray:imageArr withHeadName:nameArr shopDetailArry:title];


        [cell.contentView addSubview:classCell];
    }else {
        WebTableViewCell *webCell = [[WebTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:WebTableViewCellID];
        if (!webCell) {
            webCell = [[WebTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:WebTableViewCellID];
        }
        webCell.tag = indexPath.row;
//        NSString *str = [NSString stringWithFormat:@"https://appnew.zhongjianmall.com/html/productdetails.html?productId=%@",_productId];//
        NSString *str=@"https://appnew.zhongjianmall.com/html/productdetails.html?productId=161";
//        NSString *str=@"https:/www.baidu.com";

        webCell.contentStr = str;
        cell = webCell;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%ld=====%ld",(long)indexPath.section,indexPath.row);
    if (indexPath.section == 1) {
        
        //判断登入
        NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
        NSString *token = [user objectForKey:@"userToken"];

        if (token != nil && token != [NSNull class]) {
        
            AddShopViewController *addShopView = [AddShopViewController new];
            addShopView.delegate = self;
            addShopView.prcie = [NSString stringWithFormat:@"%@",dataDiction[@"product"][@"price"]];
            //        addShopView.headIconImage.image = [UIImage imageNamed:<#(nonnull NSString *)#>]
            NSString *urlStr = [NSString stringWithFormat:@"%@%@",HTTPUrl,imageDataArray[0][@"photo"]];
            addShopView.imageUrl = urlStr;
            NSMutableArray *arr = [NSMutableArray array];
            addShopView.productId = _productId;
            arr = [NSMutableArray arrayWithArray:dataDiction[@"product"][@"productspecs"]];
            NSLog(@"%@====%p",arr,arr);
            //        addShopView.miniteLabel.text = [NSString stringWithFormat:@""];
            addShopView.classArray = arr;
            addShopView.modalPresentationStyle = UIModalPresentationOverCurrentContext;
            [self presentViewController:addShopView animated:NO completion:^{
                addShopView.view.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
            }];
            
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
}
#pragma mark -  AddShopViewControllerDelegate
//add by zy
- (void)AddShopViewControllerSucess{
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode =MBProgressHUDModeCustomView;
    hud.label.text = @"添加成功";
    [hud hideAnimated:YES afterDelay:2];
    
}
- (void)AddShopViewControllerDelegatePushVC{

    SettlementViewController *setVC = [SettlementViewController new];
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
//    [user setObject:shopDic forKey:@"ordrerDic"];
    NSDictionary *orderDic =(NSDictionary *)[user objectForKey:@"ordrerDic"];
    setVC.productname = [NSString stringWithFormat:@"%@",dataDiction[@"product"][@"productname"]];
    setVC.isVIP = [NSString stringWithFormat:@"%@",dataDiction[@"beLongToVIP"]];
    setVC.producerno = [NSString stringWithFormat:@"%@",dataDiction[@"product"][@"producerno"]];
    setVC.producertel = [NSString stringWithFormat:@"%@",dataDiction[@"product"][@"producertel"]];
    setVC.orderDiction = orderDic;
    setVC.producername = [NSString stringWithFormat:@"%@",dataDiction[@"product"][@"producername"]];
    setVC.productId = [NSString stringWithFormat:@"%@",dataDiction[@"product"][@"id"]];

    [self.navigationController pushViewController:setVC animated:YES];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 点击事件
- (void)backButtonClick {
    //    self.navigationController.navigationBar.hidden = NO;
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)shareClick:(UIButton *)sender {
    NSLog(@"点击了分享");
    NSLog(@"分享");
    
    NSArray *imageArr = imageDataArray;
    NSString *imageUrl = [NSString stringWithFormat:@"%@%@",HTTPUrl,imageArr[0][@"photo"]];
    NSString *text = [NSString stringWithFormat:@"%@",dataDiction[@"product"][@"productname"]];
    NSString *info = [NSString stringWithFormat:@"%@%@",@"https://appnew.zhongjianmall.com/html/productWechatShare.html?productId=",dataDiction[@"product"][@"id"]];
    

    NSArray* imageArray = @[imageUrl];
    NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
    [shareParams SSDKSetupShareParamsByText:text
                                     images:imageArray
                                        url:[NSURL URLWithString:info]
                                      title:@"商品详情"
                                       type:SSDKContentTypeAuto];
    //有的平台要客户端分享需要加此方法，例如微博
    [shareParams SSDKEnableUseClientShare];
    //2、分享（可以弹出我们的分享菜单和编辑界面）
    [ShareSDK showShareActionSheet:nil //要显示菜单的视图, iPad版中此参数作为弹出菜单的参照视图，只有传这个才可以弹出我们的分享菜单，可以传分享的按钮对象或者自己创建小的view 对象，iPhone可以传nil不会影响
                             items:nil
                       shareParams:shareParams
               onShareStateChanged:^(SSDKResponseState state, SSDKPlatformType platformType, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error, BOOL end) {
                   
                   switch (state) {
                       case SSDKResponseStateSuccess:
                       {
                           UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享成功"
                                                                               message:nil
                                                                              delegate:nil
                                                                     cancelButtonTitle:@"确定"
                                                                     otherButtonTitles:nil];
                           [alertView show];
                           break;
                       }
                       case SSDKResponseStateFail:
                       {
                           UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享失败"
                                                                           message:[NSString stringWithFormat:@"%@",error]
                                                                          delegate:nil
                                                                 cancelButtonTitle:@"OK"
                                                                 otherButtonTitles:nil, nil];
                           [alert show];
                           break;
                       }
                       default:
                           break;
                   }
               }
     ];
   
}
//add by zy
- (void)goShopAction{
    
    ShopCarChildViewController *shopVc = [[ShopCarChildViewController alloc] init];
//    ShopCarViewController *shopVc = [[ShopCarViewController alloc] init];
//    shopVC.isFromGoodsPage  = YES;
    [self.navigationController pushViewController:shopVc animated:YES];

}
#pragma mark - 头部按钮点击
- (void)topBottonClick:(UIButton *)button
{
    button.selected = !button.selected;
    [_selectBtn setTitleColor:[UIColor colorWithHexString:@"444444"] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor colorWithHexString:@"6493ff"] forState:UIControlStateNormal];
    
    _selectBtn = button;
//    if ([[self.heightDic objectForKey:[NSString stringWithFormat:@"%d",0]] floatValue] < 50) {
//
//    }else {
        if (button.tag == 1000) {
            
            NSIndexPath * dayOne = [NSIndexPath indexPathForRow:0 inSection:0];
            [self.detailTableView scrollToRowAtIndexPath:dayOne atScrollPosition:UITableViewScrollPositionTop animated:YES];
        }else if (button.tag == 1001) {
            //        [self.detailTableView reloadData];
            NSIndexPath * dayOne = [NSIndexPath indexPathForRow:0 inSection:2];
            [self.detailTableView scrollToRowAtIndexPath:dayOne atScrollPosition:UITableViewScrollPositionTop animated:YES];
            
        }else {
            //        [self.detailTableView reloadData];
            NSIndexPath * dayOne = [NSIndexPath indexPathForRow:0 inSection:3];
            [self.detailTableView scrollToRowAtIndexPath:dayOne atScrollPosition:UITableViewScrollPositionTop animated:YES];
            
        }
//    }
    
    
    
}

#pragma mark - UIScrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    NSIndexPath *path =  [self.detailTableView indexPathForRowAtPoint:CGPointMake(scrollView.contentOffset.x, scrollView.contentOffset.y)];
    //    NSLog(@"这是第%li行",(long)path.section);
    if (path.section == 0) {
        
        UIButton *button =  (UIButton *)[self.view viewWithTag:1000];
        button.selected = !button.selected;
        [_selectBtn setTitleColor:[UIColor colorWithHexString:@"444444"] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor colorWithHexString:@"6493ff"] forState:UIControlStateNormal];
        _selectBtn = button;
        
    }else if (path.section == 1) {
        UIButton *button =  (UIButton *)[self.view viewWithTag:1001];
        button.selected = !button.selected;
        [_selectBtn setTitleColor:[UIColor colorWithHexString:@"444444"] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor colorWithHexString:@"6493ff"] forState:UIControlStateNormal];
        _selectBtn = button;
    }else {
        UIButton *button =  (UIButton *)[self.view viewWithTag:1002];
        button.selected = !button.selected;
        [_selectBtn setTitleColor:[UIColor colorWithHexString:@"444444"] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor colorWithHexString:@"6493ff"] forState:UIControlStateNormal];
        _selectBtn = button;
    }
    
    
}
#pragma  mark  底部的点击事件
- (void)bottomClick:(UIButton *)sender {
    NSLog(@"%ld",(long)sender.tag);
    if (sender.tag == 10) {
        NSString *telStr = @"0571-57183790";
        UIWebView *callWebView = [[UIWebView alloc] init];
        NSURL *telURL          = [NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",telStr]];
        [callWebView loadRequest:[NSURLRequest requestWithURL:telURL]];
        
        [self.view addSubview:callWebView];
        
        
    }else if (sender.tag == 11) {
        
        //这里有个逻辑是判断从搜索页面进的,还是从详情页面进的.
        
        [self previousViewController];
        
//        self.tabBarController.selectedIndex = 2;
        //hide by zy
//         [self presentAdd];
        
//        [self goShopAction];
        

    }
    
}

//判断上级页面是哪个页面
- (void)previousViewController {
    
    NSArray *vcArr = self.navigationController.childViewControllers;
//    UIViewController *vc = self.navigationController.visibleViewController;

    if (vcArr.count < 2) {
        [self goShopAction];
        return;
    }
//    int i=0;
//    for (vc in vcArr) {
//        ++i;
//    }

    if ([[self.navigationController.viewControllers objectAtIndex:(vcArr.count-2)] isKindOfClass:[HomeViewController class]]) {
         self.tabBarController.selectedIndex = 2;
    } else {
         [self goShopAction];
    }
    
}


- (void)addShopClick:(UIButton *)sender {
    //hide by zy
//    [self presentAdd];
    [self presentAdd:YES];

}
//hide by zy

//- (void)presentAdd {
- (void)presentAdd:(BOOL)isAddShop{

    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *token = [userDefaults objectForKey:@"userToken"];
   
    
    if (token != nil && token != [NSNull class]) {
        AddShopViewController *addShopView = [AddShopViewController new];
        addShopView.delegate = self;
        addShopView.prcie = [NSString stringWithFormat:@"%@",dataDiction[@"product"][@"price"]];
        //        addShopView.headIconImage.image = [UIImage imageNamed:<#(nonnull NSString *)#>]
        NSString *urlStr = [NSString stringWithFormat:@"%@%@",HTTPUrl,imageDataArray[0][@"photo"]];
        addShopView.imageUrl = urlStr;
        NSMutableArray *arr = [NSMutableArray array];
        addShopView.productId = _productId;
        arr = [NSMutableArray arrayWithArray:dataDiction[@"product"][@"productspecs"]];
        NSLog(@"%@====%p",arr,arr);
        //        addShopView.miniteLabel.text = [NSString stringWithFormat:@""];
        addShopView.classArray = arr;
        addShopView.modalPresentationStyle = UIModalPresentationOverCurrentContext;
        //add by zy
        addShopView.isShowAddShop = isAddShop;
        
        [self presentViewController:addShopView animated:NO completion:^{
            addShopView.view.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
        }];
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
- (void)buyButtonClick:(UIButton *)sender {
//        SettlementViewController *setVC = [[SettlementViewController alloc] init];
//
//        [self.navigationController pushViewController:setVC animated:YES];
    //hide by zy
//    [self presentAdd];
    [self presentAdd:NO];

   
}

#pragma mark - 通知
- (void)noti:(NSNotification *)sender
{
    WebTableViewCell *cell = [sender object];
    NSLog(@"====%@",@(cell.tag));
    NSLog(@"height!!!!!!!====%f",cell.height);

    if (![self.heightDic objectForKey:[NSString stringWithFormat:@"%ld",cell.tag]]||[[self.heightDic objectForKey:[NSString stringWithFormat:@"%ld",cell.tag]] floatValue] != cell.height)
    {
        [self.heightDic setObject:[NSNumber numberWithFloat:cell.height] forKey:[NSString stringWithFormat:@"%ld",cell.tag]];
        [self.detailTableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:cell.tag inSection:3]] withRowAnimation:UITableViewRowAnimationNone];
    }
    
    
}

@end

