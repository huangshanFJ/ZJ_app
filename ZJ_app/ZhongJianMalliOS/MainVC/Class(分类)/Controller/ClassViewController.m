//
//  ClassViewController.m
//  ZhongJianMalliOS
//
//  Created by 段 on 2017/10/31.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "ClassViewController.h"
#import "UIBarButtonItem+DCBarButtonItem.h"
#import "NewsViewController.h"
//#import "SearhViewController.h"

#import "ClassTableViewCell.h"
#import "ClassCollectionHeadView.h"
#import "ClassHeadImageCell.h"
#import "ClassShopCollectionViewCell.h"
#import "PYSearch.h"
#import "DetailClassViewController.h"
#import "SpecialgiftsViewController.h"
#import "SearchHistoryViewController.h"

@interface ClassViewController ()<UITableViewDataSource,UITableViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,PYSearchViewControllerDelegate>{
    
    NSMutableArray *classDataArray;
//    NSMutableDictionary *shopDataDic;
    
    NSInteger selectedShopHead;
    NSMutableArray *shopDataArray;
}

@property (nonatomic,strong) UITableView *leftTableView;
@property (nonatomic,strong) UICollectionView *shopCollectionView;
/**
 *   页数
 */
@property (nonatomic,assign) int pageIndex;
@end
static NSString *const classCellID = @"lassTableViewCell";
static NSString *const classHeadCellID = @"ClassCollectionHeadView";
static NSString *const classShopCellID = @"ClassShopCollectionViewCell";
static NSString *const classHeadImageCellID = @"ClassHeadImageCell";

@implementation ClassViewController
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
    [self setUpNav];
    [self requestDate];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
  
    classDataArray = [NSMutableArray arrayWithCapacity:0];
//    shopDataDic = [NSMutableDictionary dictionary];
    shopDataArray = [NSMutableArray arrayWithCapacity:0];
    self.view.backgroundColor = [UIColor whiteColor];
   
    selectedShopHead = 0;
    [self creatTable];
    [self creatCollectionView];
}

-(void)requestDate {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer new];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSString *url = [NSString stringWithFormat:@"%@%@",HTTPUrl,@"/zjapp/v1/ProductManager/getProductOfCategory/"];//,token];
    
 
    [manager GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",responseObject);
        if (responseObject[@"data"]) {
            //取出来数组
//            [classDataArray addObjectsFromArray:responseObject[@"data"]];
            classDataArray = [NSMutableArray arrayWithArray:responseObject[@"data"]];
            
            [_leftTableView reloadData];
            [_leftTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionTop];
         
            shopDataArray = classDataArray[0][@"productSubCategories"];
            [_shopCollectionView reloadData];
            
        }
        
        [hud hideAnimated:YES];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
        [hud hideAnimated:YES];
    }];
    
//    [manager POST:url parameters:nil progress:^(NSProgress * _Nonnull uploadProgress) {
//
//    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        NSLog(@"%@",responseObject);
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        NSLog(@"%@",error);
//    }];
    
}
//导航
- (void)setUpNav {
    self.navigationController.navigationBar.backgroundColor = [UIColor whiteColor];
//    self.navigationItem.leftBarButtonItem = [UIBarButtonItem ItemWithImage:[UIImage imageNamed:@"scan_gray"] WithHighlighted:[UIImage imageNamed:@"scan_gray"] Target:self action:@selector(richScanItemClick)];
//    self.navigationItem.rightBarButtonItem = [UIBarButtonItem ItemWithImage:[UIImage imageNamed:@"news_gray"] WithHighlighted:[UIImage imageNamed:@"news_gray"] Target:self action:@selector(messageItemClick)];
    
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
- (void)creatTable {
    
    _leftTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KWIDTH*0.25, KHEIGHT-64-49) style:UITableViewStylePlain];
    _leftTableView.delegate = self;
    _leftTableView.dataSource = self;
    _leftTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_leftTableView];
    
}
- (void)creatCollectionView {
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    layout.minimumLineSpacing = 2;
    layout.minimumInteritemSpacing = 2;
    _shopCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(KWIDTH*0.25, 10, KWIDTH*0.75, KHEIGHT-64-44) collectionViewLayout:layout];
    _shopCollectionView.backgroundColor = [UIColor whiteColor];
    _shopCollectionView.delegate = self;
    _shopCollectionView.dataSource = self;
    [_shopCollectionView registerClass:[ClassCollectionHeadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:classHeadCellID];
    [_shopCollectionView registerClass:[ClassHeadImageCell class] forCellWithReuseIdentifier:classHeadImageCellID];
    [_shopCollectionView registerClass:[ClassShopCollectionViewCell class] forCellWithReuseIdentifier:classShopCellID];
    
    [self.view addSubview:_shopCollectionView];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return classDataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ClassTableViewCell *cell = [[ClassTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:classCellID];
    
    if (!cell) {
        cell = [[ClassTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:classCellID];
    }
//    NSArray *titleArr = //@[@"为您推荐",@"营养保健",@"健康食品",@"家居家纺",@"个人洗护",@"生鲜",@"美容彩妆",@"内衣配饰",@"眼镜手表",@"量子科技"];
    cell.titleLabel.text = [NSString stringWithFormat:@"%@",classDataArray[indexPath.row][@"categoryname"]];
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSLog(@"点击了%ld",indexPath.row);
    selectedShopHead = indexPath.row;
    
    shopDataArray = classDataArray[indexPath.row][@"productSubCategories"];
    [_shopCollectionView reloadData];
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

#pragma mark - head宽高
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return section == 0 ? CGSizeMake(0, 0 ) : CGSizeMake(KWIDTH*0.75 , 35);
}
#pragma mark - foot宽高
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    return CGSizeZero;
}
#pragma mark - item宽高
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    return indexPath.section == 0 ? CGSizeMake(KWIDTH*0.75, 85) : CGSizeMake((KWIDTH*0.75-16)/3, 105);
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
//    NSArray *collectionArr = [NSArray array];
    if (shopDataArray.count > 0) {
//         collectionArr = [NSArray arrayWithArray:shopDataArray[section]];
        return section == 0 ? 1 : shopDataArray.count;
    }else {
        return  0 ;
    }
   
    
    
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 2;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    UICollectionViewCell *shopCell = nil;
    
    if (indexPath.section == 0) {
        ClassHeadImageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:classHeadImageCellID forIndexPath:indexPath];
//        cell.headImage.backgroundColor = [UIColor purpleColor];
        cell.headImage.image = [UIImage imageNamed:@"分类_03"];
        shopCell = cell;
        
    }else{
        ClassShopCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:classShopCellID forIndexPath:indexPath];
//        cell.headImageView.backgroundColor = [UIColor redColor];
//        NSArray *textArr = @[@"缓解疲劳",@"改善睡眠",@"肠道护理",@"告别三高",@"美容养颜"];
//        NSArray *collectionArr = [NSArray arrayWithArray:classDataArray[indexPath.section-1][@"productSubCategories"]];
        if (classDataArray.count > 0) {
            cell.shopNameLabel.text = [NSString stringWithFormat:@"%@",shopDataArray[indexPath.row][@"categoryname"]];
            NSString *url = [NSString stringWithFormat:@"%@%@",HTTPUrl,shopDataArray[indexPath.row][@"icon"]];
            [cell.headImageView sd_setImageWithURL:[NSURL URLWithString:url]];
        }
        shopCell = cell;
    }

    
    return shopCell;
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    UICollectionReusableView *reusableview = nil;
    if (kind == UICollectionElementKindSectionHeader) {
//        if (indexPath.section == 0) {
//            reusableview = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:classHeadCellID forIndexPath:indexPath];
        
        ClassCollectionHeadView *headView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:classHeadCellID forIndexPath:indexPath];//[[ClassCollectionHeadView alloc] initWithFrame:CGRectMake(0, 0, KWIDTH*0.75, 25)];
//        NSArray *titleArr = @[@"renren",@"营养健康",@"热卖产品"];
        if (classDataArray.count > 0) {
            headView.titleLabel.text = classDataArray[selectedShopHead][@"categoryname"];//titleArr[indexPath.section];
            NSLog(@"表头是%@",headView.titleLabel.text);
        }
        
//        [reusableview addSubview:headView];
        reusableview = headView;
//        }
    }else {
        
    }
  
    return reusableview;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSLog(@"%ld---%ld",(long)indexPath.section,(long)indexPath.row);
    DetailClassViewController *detailClassVC = [[DetailClassViewController alloc] init];
    detailClassVC.categoryId = [NSString stringWithFormat:@"%@",shopDataArray[indexPath.row][@"id"]];
    detailClassVC.titleText = [NSString stringWithFormat:@"%@",shopDataArray[indexPath.row][@"categoryname"]];

    [self.navigationController pushViewController:detailClassVC animated:YES];
}
- (void)richScanItemClick {
    NSLog(@"点击了扫描");
}
- (void)messageItemClick {
    NSLog(@"点击了消息");
//    [self.navigationController pushViewController:[NewsViewController new] animated:YES];
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
//- (void)goSearchVC {
//    NSLog(@"点击了搜索"); NSArray *hotSeaches = nil;
//    // 2. Create a search view controller
//    PYSearchViewController *searchViewController = [PYSearchViewController searchViewControllerWithHotSearches:hotSeaches searchBarPlaceholder:NSLocalizedString(@"", @"搜索编程语言") didSearchBlock:^(PYSearchViewController *searchViewController, UISearchBar *searchBar, NSString *searchText) {
//        // Called when search begain.
//        // eg：Push to a temp view controller
////        [searchViewController.navigationController pushViewController:[[s alloc] init] animated:YES];
//    }];
//    searchViewController.searchHistoryStyle = PYSearchHistoryStyleARCBorderTag;
//    searchViewController.hotSearchStyle = PYHotSearchStyleARCBorderTag;
//
//    // 4. Set delegate
//    searchViewController.delegate = self;
//    // 5. Present a navigation controller
//    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:searchViewController];
//    [self presentViewController:nav animated:YES completion:nil];
//
//}
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
